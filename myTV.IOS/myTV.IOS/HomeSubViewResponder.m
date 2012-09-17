//
//  HomeSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "HomeSubViewResponder.h"



@implementation HomeSubViewResponder

@synthesize vodFeaturedScrollView = _vodFeaturedScrollView;
@synthesize vodRecentScrollView = _vodRecentScrollView;
@synthesize channelScrollView = _channelScrollView;
@synthesize channelFetcher = _channelFetcher;
@synthesize featuredVOdFetcher = _featuredVOdFetcher;
@synthesize recentVODFetcher = _recentVODFetcher;

-(void)viewDidLoad {
    [self fillChannels];
    [self fillFeaturedVOD];
    [self fillRecentVOD];
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
                //[subview.channelScrollView setCanCancelContentTouches:YES];
                hasLoadedChannelData = YES;
            }
            
            [subview cancelChannelFetcher];
        }];
    }
}

-(void) cancelChannelFetcher {
    if(_channelFetcher != nil) {
        [_channelFetcher cancelPendingRequest];
        _channelFetcher = nil;
    }
}


-(void) fillFeaturedVOD {
    if(!hasLoadedVODFeaturedData) {
        HomeSubViewResponder *subview = self;
        _featuredVOdFetcher = [RestService RequestGetFeaturedVOD:[NSString stringWithCString:RestServiceUrl encoding:[NSString defaultCStringEncoding]] withDeviceId:@"iosdevice1" andDeviceTypeId:@"5" usingCallback:^(NSArray *array, NSError *error){
            int xPos = ChannelControl_Space;
            for (MyTVProgram *program in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + ChannelControl_Space;
                [subview.vodFeaturedScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:program];
                }
            }
            subview.vodFeaturedScrollView.contentSize = CGSizeMake(xPos, subview.vodFeaturedScrollView.frame.size.height);
            hasLoadedVODFeaturedData = YES;
        }];
    }
}


-(void) cancelVODFeaturedFetcher {
    if(_featuredVOdFetcher != nil) {
        [_featuredVOdFetcher cancelPendingRequest];
        _featuredVOdFetcher = nil;
    }
}

-(void) fillRecentVOD {
    if(!hasLoadedVODRecentData) {
        HomeSubViewResponder *subview = self;
        _recentVODFetcher = [RestService RequestGetNewReleasesVOD:[NSString stringWithCString:RestServiceUrl encoding:[NSString defaultCStringEncoding]] withDeviceId:@"iosdevice1" andDeviceTypeId:@"5" usingCallback:^(NSArray *array, NSError *error){
            int xPos = ChannelControl_Space;
            for (MyTVProgram *program in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + ChannelControl_Space;
                [subview.vodRecentScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:program];
                }
            }
            subview.vodRecentScrollView.contentSize = CGSizeMake(xPos, subview.vodFeaturedScrollView.frame.size.height);
            hasLoadedVODRecentData = YES;
        }];
    }
}

-(void) cancelVODRecentFetcher {
    if(_recentVODFetcher != nil) {
        [_recentVODFetcher cancelPendingRequest];
        _recentVODFetcher = nil;
    }
}

-(void) abortOperatons {
    [self cancelChannelFetcher];
    [self cancelVODFeaturedFetcher];
    [self cancelVODRecentFetcher];
}

-(void) forceReloadChannels {
    [self cancelChannelFetcher];
    hasLoadedChannelData = NO;
    hasLoadedVODFeaturedData = NO;
    hasLoadedVODRecentData = NO;
    [self fillChannels];
    [self fillFeaturedVOD];
    [self fillRecentVOD];
}

@end
