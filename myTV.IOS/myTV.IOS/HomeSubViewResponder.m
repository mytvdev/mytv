//
//  HomeSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "HomeSubViewResponder.h"



@implementation HomeSubViewResponder

@synthesize channelScrollView = _channelScrollView;
@synthesize channelFetcher = _channelFetcher;

-(void)viewDidLoad {
    [self fillChannels];
}

-(void) fillChannels {
    if(!hasLoadedChannelData) {
        HomeSubViewResponder *subview = self;
        _channelFetcher = [RestService RequestGetAllChannels:@"http://www.my-tv.us/mytv.restws.new/RestService.ashx?" withDeviceId:@"iosdevice1" andDeviceTypeId:@"5" usingCallback:^(NSArray *channels, NSError *error){
            if(subview.channelScrollView != nil) {
                int xPos = ChannelControl_Space;
                for (Channel *channel in channels) {
                    ChannelControlResponder *responder = [[ChannelControlResponder alloc] init];
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                    UIView *view = [array objectAtIndex:0];
                    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                    xPos = xPos + view.frame.size.width + ChannelControl_Space;
                    [subview.channelScrollView addSubview:view];
                    if([responder respondsToSelector:@selector(bindData:)]) {
                        [responder performSelector:@selector(bindData:) withObject:channel];
                    }
                }
                subview.channelScrollView.contentSize = CGSizeMake(xPos, subview.channelScrollView.frame.size.height);
            }
            
            [subview cancelChannelFetcher];
        }];
    }
}

-(void) cancelChannelFetcher {
    if(_channelFetcher != nil) {
        if(_channelFetcher.hasFinishedLoading) hasLoadedChannelData = YES;
        [_channelFetcher cancelPendingRequest];
        _channelFetcher = nil;
    }
}

-(void) abortOperatons {
    [self cancelChannelFetcher];
}

-(void) forceReloadChannels {
    [self cancelChannelFetcher];
    hasLoadedChannelData = false;
    [self fillChannels];
}

@end
