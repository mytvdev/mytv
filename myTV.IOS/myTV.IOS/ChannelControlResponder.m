//
//  ChannelControlResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/12/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "ChannelControlResponder.h"

@implementation ChannelControlResponder
@synthesize mainView;
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
    //UITapGestureRecognizer *taprecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fireEvent:)];
    //self.recognizer = taprecognizer;
    //[self.mainView addGestureRecognizer:taprecognizer];
}

-(void)viewDidUnload {
    if(self.imageFetcher != nil) {
        [self.imageFetcher cancelPendingRequest];
        self.imageFetcher = nil;
    }
    self.channel = nil;
    //self.recognizer = nil;
}

/*-(void) fireEvent:(UIGestureRecognizer *)gestureRecognizer {
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Play Channel" message:[NSString stringWithFormat:@"Do you want to play %@?", self.channel.Name] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [view show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    NSLog(@"button clicked of index %d", buttonIndex);
    if(buttonIndex > 0){
        NSLog(@"Play channel");
    }
}*/


@end
