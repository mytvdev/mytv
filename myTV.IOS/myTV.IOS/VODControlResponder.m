//
//  VODControlResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/14/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "VODControlResponder.h"

@implementation VODControlResponder

@synthesize vod;
@synthesize mainView;
@synthesize imageDisplay;
@synthesize labelDisplay;

-(void)bindData:(NSObject *)data {
    self.vod = (ItemBase *)data;
    VODControlResponder *parent = self;
    self.imageFetcher = [DataFetcher Get:self.vod.Logo usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
    }];
    labelDisplay.text = self.vod.Title;
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    self.recognizer = taprecognizer;
    [self.mainView addGestureRecognizer:taprecognizer];
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
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Play Channel" message:[NSString stringWithFormat:@"Do you want to view %@?", self.vod.Title] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [view show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"button clicked of index %d", buttonIndex);
    if(buttonIndex > 0){
        
        
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
