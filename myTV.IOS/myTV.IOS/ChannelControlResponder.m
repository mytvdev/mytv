//
//  ChannelControlResponder.m
//  myTV.IOS
//
//  Created by myTV Inc. on 9/12/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "ChannelControlResponder.h"

@implementation ChannelControlResponder
@synthesize mainView;
@synthesize imageDisplay;
@synthesize labelDisplay;

-(void)bindData:(NSObject *)data {
    self.channel = (Channel *)data;
    ChannelControlResponder *parent = self;
    self.imageFetcher = [DataFetcher Get:self.channel.BigLogo usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
        //self.imageFetcher = nil;
    }];
    labelDisplay.text = self.channel.Name;
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    self.recognizer = taprecognizer;
    self.longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(fireLongPress:)];
    [self.mainView addGestureRecognizer:self.longRecognizer];
    [self.mainView addGestureRecognizer:taprecognizer];
    
}

-(void)viewDidUnload {
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
    self.channel = nil;
    self.recognizer = nil;
}

-(void) fireEvent:(UIGestureRecognizer *)gestureRecognizer {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectChannel" object:self.channel];
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Play Channel" message:[NSString stringWithFormat:@"Do you want to play %@?", self.channel.Name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [view show];

}

-(void) fireLongPress:(UILongPressGestureRecognizer *)gestureRecognizer {
    DLog(@"%@", [NSString stringWithFormat:@"%d", gestureRecognizer.state]);
    if(gestureRecognizer.state == UIGestureRecognizerStateBegan) {
        self.imgFrame.image = [UIImage imageNamed:@"frame-Highlight.png"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SelectChannel" object:self.channel];
    }
    else if(gestureRecognizer.state == UIGestureRecognizerStateEnded) {
        self.imgFrame.image = [UIImage imageNamed:@"frame.png"];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"button clicked of index %d", buttonIndex);
    if(buttonIndex > 0){
        [RestService RequestGetChannelUrl:MyTV_RestServiceUrl ofChannel:[NSString stringWithFormat:@"%d", self.channel.Id] withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSString *url, NSError *error){
            if (url != nil && error == nil) {
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayVideo" object:nil userInfo:@{@"url": url}];
            }
        }];
        
    }
}

- (void) dealloc {
    self.channel = nil;
    self.recognizer = nil;
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
}


@end
