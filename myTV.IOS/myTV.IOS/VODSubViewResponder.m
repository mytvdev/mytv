//
//  VODSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "VODSubViewResponder.h"
#import "MBProgressHUD.h"

@implementation VODSubViewResponder

@synthesize vodFeaturedScrollView = _vodFeaturedScrollView;
@synthesize vodRecentScrollView = _vodRecentScrollView;
@synthesize featuredVOdFetcher = _featuredVOdFetcher;
@synthesize recentVODFetcher = _recentVODFetcher;

-(void)viewDidLoad {
    [self fillFeaturedVOD];
    [self fillRecentVOD];
}

-(void) fillFeaturedVOD {
    if(!hasLoadedVODFeaturedData) {
        VODSubViewResponder *subview = self;
        MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.vodFeaturedScrollView animated:YES];
        _featuredVOdFetcher = [RestService RequestGetFeaturedVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            int xPos = 14;
            for (MyTVProgram *program in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + 14;
                [subview.vodFeaturedScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:program];
                }
                
            }
            subview.vodFeaturedScrollView.contentSize = CGSizeMake(xPos, subview.vodFeaturedScrollView.frame.size.height);
            [loader hide:YES];
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
        VODSubViewResponder *subview = self;
        [MBProgressHUD showHUDAddedTo:subview.vodRecentScrollView animated:YES];
        _recentVODFetcher = [RestService RequestGetNewReleasesVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            int xPos = 14;
            for (MyTVProgram *program in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + 14;
                [subview.vodRecentScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:program];
                }
            }
            subview.vodRecentScrollView.contentSize = CGSizeMake(xPos, subview.vodFeaturedScrollView.frame.size.height);
            [MBProgressHUD hideHUDForView:subview.vodRecentScrollView animated:YES];
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
    [self cancelVODFeaturedFetcher];
    [self cancelVODRecentFetcher];
}

-(void) forceReloadChannels {
    hasLoadedVODFeaturedData = NO;
    hasLoadedVODRecentData = NO;
    [self fillFeaturedVOD];
    [self fillRecentVOD];
}

@end
