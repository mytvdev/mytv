//
//  ChannelControlResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/12/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "Channel.h"
#import "DataFetcher.h"
#import "RestService.h"

#define ChannelControl_Space 14
#define ChannelControl_Width 162
#define ChannelControl_Height 166

@interface ChannelControlResponder : SubViewResponder

@property Channel *channel;

@property DataFetcher *imageFetcher;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgFrame;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageDisplay;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelDisplay;
@property UITapGestureRecognizer *recognizer;
@property UILongPressGestureRecognizer *longRecognizer;

@end
