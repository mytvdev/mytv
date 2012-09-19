//
//  VODSubViewResponder.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
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
