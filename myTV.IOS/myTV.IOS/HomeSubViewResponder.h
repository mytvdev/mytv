//
//  HomeSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "ChannelControlResponder.h"
#import "VODControlResponder.h"
#import "VODPackageControlResponder.h"
#import "RestCache.h"

@interface HomeSubViewResponder : SubViewResponder
{
    BOOL hasLoadedChannelData;
    BOOL hasLoadedVODFeaturedData;
    BOOL hasLoadedVODRecentData;
    BOOL hasLoadedMyTVPackagesData;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodFeaturedScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodRecentScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *channelScrollView;

@property (readonly) DataFetcher *channelFetcher;
@property (readonly) DataFetcher *featuredVOdFetcher;
@property (readonly) DataFetcher *recentVODFetcher;
@property (readonly) DataFetcher *mytvPackagesFetcher;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelChannel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelFeaturedVOD;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelNewReleasesVOD;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *viewFeaturedVODWidget;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *viewNewReleasesVODWidget;

-(void)cancelChannelFetcher;

@end
