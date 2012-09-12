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

@interface HomeSubViewResponder : SubViewResponder
{
    BOOL hasLoadedChannelData;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (readonly) DataFetcher *channelFetcher;

-(void)cancelChannelFetcher;
@end
