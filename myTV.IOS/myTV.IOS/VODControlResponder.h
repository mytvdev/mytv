//
//  VODControlResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "DataFetcher.h"
#import "RestService.h"

#define VODControl_Space 14
#define VODControl_Width 162

@interface VODControlResponder : SubViewResponder

@property ItemBase *vod;

@property DataFetcher *imageFetcher;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgFrame;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageDisplay;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelDisplay;
@property UITapGestureRecognizer *recognizer;
@property UILongPressGestureRecognizer *longRecognizer;

@end
