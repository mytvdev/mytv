//
//  PlayerSubViewResponder.m
//  myTV.IOS
//
//  Created by myTV Inc. on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "PlayerSubViewResponder.h"

@implementation PlayerSubViewResponder
@synthesize playerContainerView;
@synthesize controlsContainerView;
@synthesize showControlsButton;
@synthesize loadingLabel;
@synthesize prevButton;
@synthesize nextButton;
@synthesize lblState;

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

- (void)setNextState:(BOOL)nextState andPreviousState:(BOOL)prevState {
    [nextButton setHidden:!nextState];
    [prevButton setHidden:!prevState];
}

- (IBAction)goToPrev:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NextVideo" object:nil userInfo:@{ @"index": @"-1" }];
}

- (IBAction)goToNext:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NextVideo" object:nil userInfo:@{ @"index": @"1" }];
}

- (void)setCurrentIndex:(NSInteger)index outOf:(NSInteger)total {
    if (total > 1) {
        lblState.text = [NSString stringWithFormat:@"%d / %d", index, total];
    }
}


@end
