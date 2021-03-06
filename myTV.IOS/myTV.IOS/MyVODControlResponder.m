//
//  MyVODControlResponderViewController.m
//  myTV.IOS
//
//  Created by Johnny on 9/19/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "MyVODControlResponder.h"

@implementation MyVODControlResponder

@synthesize vod;
@synthesize mainView;
@synthesize imageDisplay;
@synthesize labelDisplay;

-(void)bindData:(NSObject *)data {
    self.vod = (Episode *)data;
    MyVODControlResponder *parent = self;
    self.imageFetcher = [DataFetcher Get:self.vod.Thumbnail Synchronously:NO usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
        //self.imageFetcher = nil;
    }];
    labelDisplay.text = self.vod.Title;
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    self.recognizer = taprecognizer;
    [self.mainView addGestureRecognizer:taprecognizer];
    self.longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(fireLongPress:)];
    [self.mainView addGestureRecognizer:self.longRecognizer];
}

-(void)viewDidUnload {
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
    self.vod = nil;
    self.recognizer = nil;
}

-(void) fireEvent:(UIGestureRecognizer *)gestureRecognizer {
    
    if([self.vod isKindOfClass:[Episode class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View: MyTV_View_Episode, MyTV_ViewArgument_Id: [NSString stringWithFormat:@"%d", self.vod.Id] }];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View: MyTV_View_Program, MyTV_ViewArgument_Id: [NSString stringWithFormat:@"%d", self.vod.Id] }];
    }
    
}

-(void) fireLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    DLog(@"%@", [NSString stringWithFormat:@"%d", gestureRecognizer.state]);
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.imgFrame.image = [UIImage imageNamed:@"frame-Highlight.png"];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.imgFrame.image = [UIImage imageNamed:@"frame.png"];
    }
}

- (void) dealloc {
    self.vod = nil;
    self.recognizer = nil;
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
}

@end
