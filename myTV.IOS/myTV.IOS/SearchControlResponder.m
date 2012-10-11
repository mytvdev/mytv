//
//  SearchControlResponder.m
//  myTV.IOS
//
//  Created by Johnny on 10/5/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SearchControlResponder.h"

@implementation SearchControlResponder

@synthesize labelDuration;
@synthesize labelExpiry;
@synthesize labelPrice;
@synthesize labelTitle;
@synthesize mainView;
@synthesize priceButton;
@synthesize imageDisplay;

-(void)bindData:(NSObject *)data {
    self.itemBase = (Episode *)data;
    SearchControlResponder *parent = self;
    NSString *image = self.itemBase.Logo;
    if(image == nil) {
        if([data isKindOfClass:[Episode class]]) {
            image = ((Episode *)data).Thumbnail;
        }
        else if([data isKindOfClass:[MyTVProgram class]]) {
            image = ((MyTVProgram *) data).Thumbnail;
        }
    }
    self.imageFetcher = [DataFetcher Get:image usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
    }];
    
    labelTitle.text = self.itemBase.Title;
    labelDuration.text = self.itemBase.Duration;
    labelExpiry.text = self.itemBase.ExpiresIn;
    
    NSString *s = @"$ ";
    labelPrice.text = [s stringByAppendingString:self.itemBase.Price];
    [self.priceButton setTitle:[s stringByAppendingString:self.itemBase.Price] forState:UIControlStateNormal];
    
    UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    self.recognizer = taprecognizer;
    [self.mainView addGestureRecognizer:taprecognizer];
}

-(void)viewDidUnload {
    self.itemBase = nil;
    self.recognizer = nil;
}

- (void) dealloc {
    self.itemBase = nil;
    self.recognizer = nil;
}

-(void) fireEvent:(UIGestureRecognizer *)gestureRecognizer{
    if([self.itemBase isKindOfClass:[Episode class]]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View: MyTV_View_Episode, MyTV_ViewArgument_Id: [NSString stringWithFormat:@"%d", self.itemBase.Id] }];
    }
    else {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View: MyTV_View_Program, MyTV_ViewArgument_Id: [NSString stringWithFormat:@"%d", self.itemBase.Id] }];
    }
}

@end
