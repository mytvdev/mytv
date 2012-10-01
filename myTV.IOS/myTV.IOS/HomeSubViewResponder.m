//
//  HomeSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "HomeSubViewResponder.h"
#import "MBProgressHUD.h"


@implementation HomeSubViewResponder

@synthesize vodFeaturedScrollView = _vodFeaturedScrollView;
@synthesize vodRecentScrollView = _vodRecentScrollView;
@synthesize channelScrollView = _channelScrollView;
@synthesize channelFetcher = _channelFetcher;
@synthesize featuredVOdFetcher = _featuredVOdFetcher;
@synthesize recentVODFetcher = _recentVODFetcher;
@synthesize mytvPackagesFetcher = _mytvPackagesFetcher;

-(void)viewDidLoad {
    [self fillChannels];
    [self fillFeaturedVOD];
    [self fillRecentVOD];
}

-(void) fillChannels {
    if(!hasLoadedChannelData) {
        [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error){
            if(linking != nil && error == nil) {
                HomeSubViewResponder *subview = self;
                [MBProgressHUD showHUDAddedTo:subview.channelScrollView animated:YES];
                RSGetChannelCallBack channelCallback = ^(NSArray *channels, NSError *error){
                    if(subview.channelScrollView != nil) {
                        int xPos = ChannelControl_Space;
                        if (channels != nil && channels.count > 0)
                        {
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
                        else
                        {
                            
                        }
                    }
                    [MBProgressHUD hideHUDForView:subview.channelScrollView animated:YES];
                    [subview cancelChannelFetcher];
                };
                
                _channelFetcher = [RestService RequestGetSubscribedChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:channelCallback];
            }
            else {
                //_channelFetcher = [RestService RequestGetAllChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:channelCallback];
                [self fillMyTVPackages];
            }
        }];
    }
}

-(void) cancelChannelFetcher {
    if(_channelFetcher != nil) {
        [_channelFetcher cancelPendingRequest];
        _channelFetcher = nil;
    }
}

-(void) fillMyTVPackages {
    if(!hasLoadedMyTVPackagesData) {
        HomeSubViewResponder *subview = self;
        MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.channelScrollView animated:YES];
        
        _mytvPackagesFetcher = [[RestCache CommonProvider] RequestGetMyTVPackages:^(NSArray *array, NSError *error){
            int xPos = ChannelControl_Space;
            for (MyTVPackage *package in array) {
                VODPackageControlResponder *responder = [[VODPackageControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VODPackageControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + ChannelControl_Space;
                [subview.channelScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:package];
                }
                
            }
            subview.channelScrollView.contentSize = CGSizeMake(xPos, subview.channelScrollView.frame.size.height);
            [loader hide:YES];
            [MBProgressHUD hideHUDForView:subview.channelScrollView animated:YES];
            hasLoadedMyTVPackagesData = YES;
        }];
        
    }
}


-(void) fillFeaturedVOD {
    if(!hasLoadedVODFeaturedData) {
        HomeSubViewResponder *subview = self;
        MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.vodFeaturedScrollView animated:YES];
        
        _featuredVOdFetcher = [[RestCache CommonProvider] RequestFeaturedVOD:^(NSArray *array, NSError *error){
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
        HomeSubViewResponder *subview = self;
        [MBProgressHUD showHUDAddedTo:subview.vodRecentScrollView animated:YES];
        _recentVODFetcher = [RestService RequestGetNewReleasesVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
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
