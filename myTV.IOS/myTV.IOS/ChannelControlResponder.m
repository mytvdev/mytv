//
//  ChannelControlResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/12/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "ChannelControlResponder.h"

@implementation ChannelControlResponder
@synthesize imageDisplay;
@synthesize labelDisplay;

-(void)bindData:(NSObject *)data {
    self.channel = (Channel *)data;
    ChannelControlResponder *parent = self;
    self.imageFetcher = [DataFetcher Get:self.channel.SmallLogo usingCallback:^(NSData *data, NSError *error){
        if(error == nil && data != nil) {
            parent.imageDisplay.image = [[UIImage alloc] initWithData:data];
        }
    }];
    labelDisplay.text = self.channel.Name;
}

-(void)viewDidUnload {
    self.channel = nil;
}

@end
