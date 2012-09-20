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

@interface HomeSubViewResponder : SubViewResponder
{
    BOOL hasLoadedChannelData;
    BOOL hasLoadedVODFeaturedData;
    BOOL hasLoadedVODRecentData;
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodFeaturedScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodRecentScrollView;

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (readonly) DataFetcher *channelFetcher;
@property (readonly) DataFetcher *featuredVOdFetcher;
@property (readonly) DataFetcher *recentVODFetcher;
-(void)cancelChannelFetcher;
@end
