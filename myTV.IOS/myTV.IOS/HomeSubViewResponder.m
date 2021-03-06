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
@synthesize standardpackageScrollView = _standardpackageScrollView;
@synthesize channelFetcher = _channelFetcher;
@synthesize featuredVOdFetcher = _featuredVOdFetcher;
@synthesize recentVODFetcher = _recentVODFetcher;
@synthesize mytvPackagesFetcher = _mytvPackagesFetcher;
@synthesize genresFetcher = _genresFetcher;
@synthesize countriesFetcher = _countriesFetcher;
@synthesize labelChannel;
@synthesize labelFeaturedVOD;
@synthesize labelNewReleasesVOD;
@synthesize viewFeaturedVODWidget;
@synthesize viewNewReleasesVODWidget;

-(void)viewDidLoad {
    HomeSubViewResponder *subview = self;
    [MBProgressHUD showHUDAddedTo:subview.channelScrollView animated:YES];
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error){
        if(linking != nil && linking.CustomerId > 0 && error == nil) {
            //for (UIView *subview in self.channelScrollView.subviews) {
            //    [subview removeFromSuperview];
            //}
            
            [self fillChannels];
            [self fillFeaturedVOD];
            [self fillRecentVOD];
            [self.labelFeaturedVOD setHidden:NO];
            [self.labelNewReleasesVOD setHidden:NO];
            [self.viewFeaturedVODWidget setHidden:NO];
            [self.viewNewReleasesVODWidget setHidden:NO];
            [self.labelChannel setText:@"Live Channels"];
        }
        else
        {
            [self fillMyTVPackages];
            [self.labelFeaturedVOD setHidden:YES];
            [self.labelNewReleasesVOD setHidden:YES];
            [self.viewFeaturedVODWidget setHidden:YES];
            [self.viewNewReleasesVODWidget setHidden:YES];
            [self.labelChannel setText:@"Standard Packages"];
        }
        [MBProgressHUD hideHUDForView:subview.channelScrollView animated:YES];
    }];
}

-(void) fillChannels {
    //if(!hasLoadedChannelData) {
        
        
        //[RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error){
            //if(linking != nil && error == nil) {
                HomeSubViewResponder *subview = self;
        
        if([[subview.channelScrollView subviews] count] > 0) {
            for (UIView *view in [subview.channelScrollView subviews])
            {
                [view removeFromSuperview];
            }
        }
        
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
            //}
            //else {
                //_channelFetcher = [RestService RequestGetAllChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:channelCallback];
            //    [self fillMyTVPackages];
            //}
        //}];
    //}
    
    [self.channelScrollView setContentOffset:CGPointZero animated:YES];
}

-(void) cancelChannelFetcher {
    if(_channelFetcher != nil) {
        [_channelFetcher cancelPendingRequest];
        _channelFetcher = nil;
    }
}

-(void) fillMyTVPackages {
    //if(!hasLoadedMyTVPackagesData) {
        
        
        HomeSubViewResponder *subview = self;
        
    if([[subview.channelScrollView subviews] count] > 0) {
        for (UIView *view in [subview.channelScrollView subviews])
        {
            [view removeFromSuperview];
        }
    }
    
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
        
    //}
    
    [self.channelScrollView setContentOffset:CGPointZero animated:YES];
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
    
    [self.vodFeaturedScrollView setContentOffset:CGPointZero animated:YES];
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
    
    [self.vodRecentScrollView setContentOffset:CGPointZero animated:YES];
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
