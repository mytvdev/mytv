//
//  HomeSubViewResponder.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
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
}
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *vodFeaturedScrollView;

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (readonly) DataFetcher *channelFetcher;
@property (readonly) DataFetcher *featuredVOdFetcher;

-(void)cancelChannelFetcher;
@end
