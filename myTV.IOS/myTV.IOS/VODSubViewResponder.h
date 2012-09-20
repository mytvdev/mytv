//
//  VODSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "VODControlResponder.h"

@interface VODSubViewResponder : SubViewResponder
{
    BOOL hasLoadedVODFeaturedData;
    BOOL hasLoadedVODRecentData;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodFeaturedScrollView;

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodRecentScrollView;

@property (readonly) DataFetcher *featuredVOdFetcher;

@property (readonly) DataFetcher *recentVODFetcher;

@end
