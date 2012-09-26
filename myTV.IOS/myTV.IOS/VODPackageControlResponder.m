//
//  VODPackageControlResponderViewController.m
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "VODPackageControlResponder.h"

@implementation VODPackageControlResponder

@synthesize vodPackage;
@synthesize mainView;
@synthesize imageDisplay;
@synthesize labelDisplay;

-(void)bindData:(NSObject *)data {
    self.vodPackage = (VODPackage *)data;
    VODPackageControlResponder *parent = self;
    self.imageFetcher = [DataFetcher Get:self.vodPackage.Thumbnail Synchronously:NO usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
    }];
    labelDisplay.text = self.vodPackage.Title;
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    self.recognizer = taprecognizer;
    [self.mainView addGestureRecognizer:taprecognizer];
}

-(void)viewDidUnload {
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
    self.vodPackage = nil;
    self.recognizer = nil;
}

-(void) fireEvent:(UIGestureRecognizer *)gestureRecognizer {
    
    if([self.vodPackage isKindOfClass:[VODPackage class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View: MyTV_View_VODPackage, MyTV_ViewArgument_Id: self.vodPackage.Id }];
    }
}

- (void) dealloc {
    self.vodPackage = nil;
    self.recognizer = nil;
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
}
@end
