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

@interface LiveTVSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedChannelsData;
}

@property (readonly) DataFetcher *channelFetcher;
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) KKGridView *channelsKKGridView;
@property (nonatomic, strong) IBOutlet UIView *channelsView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblChannelName;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblChannelDescripton;

@end
