//
//  PlayerSubViewResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/14/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "PlayerSubViewResponder.h"

@implementation PlayerSubViewResponder
@synthesize playerContainerView;
@synthesize controlsContainerView;
@synthesize showControlsButton;
@synthesize loadingLabel;

- (void) setPlayerView:(UIView *)view {
    [self.playerContainerView addSubview:view];
}

- (IBAction)stopVideo:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"StopVideo" object:nil];
}

- (IBAction)hideControls:(id)sender {
    for (UIView *view in self.controlsContainerView.subviews) {
        view.alpha = 0;
    }
    showControlsButton.alpha = 1;
}

- (IBAction)showControls:(id)sender {
    for (UIView *view in self.controlsContainerView.subviews) {
        view.alpha = 1;
    }
    showControlsButton.alpha = 0;
}

- (void) setIsLoading:(BOOL)status {
    if(status == YES) {
        loadingLabel.text = @"Loading";
    }
    else {
        loadingLabel.text = @"";
    }
}


@end
