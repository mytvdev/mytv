//
//  LiveTVSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKChannelCell.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"

@interface LiveTVSubViewResponder : SubViewResponder 
{
    BOOL hasLoadedChannelsData;
    id LiveTVObserver;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *ChannelScrollView;
@property (readonly) DataFetcher *channelFetcher;

@end
