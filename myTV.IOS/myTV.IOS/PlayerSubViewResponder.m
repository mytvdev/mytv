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
    for(UIView *view in self.simplePlayView.subviews) {
        view.alpha = 0;
    }
    self.showControlsSimpleView.alpha = 1;
}

- (IBAction)showControls:(id)sender {
    for (UIView *view in self.controlsContainerView.subviews) {
        view.alpha = 1;
    }
    showControlsButton.alpha = 0;
    for(UIView *view in self.simplePlayView.subviews) {
        view.alpha = 1;
    }
    self.showControlsSimpleView.alpha = 0;
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
}

- (IBAction)togglePlay:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"TogglePlayVideo" object:nil];
}

- (IBAction)changeMode:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeAspectVideo" object:nil];
    if(isLetterBox) {
        [self.btnChangeMode setImage:[UIImage imageNamed:@"letterbox.png"] forState:UIControlStateNormal];
        [self.btnSimpleChangeMode setImage:[UIImage imageNamed:@"letterbox.png"] forState:UIControlStateNormal];
        isLetterBox = NO;
    }
    else {
        [self.btnChangeMode setImage:[UIImage imageNamed:@"fullscreen.png"] forState:UIControlStateNormal];
        [self.btnSimpleChangeMode setImage:[UIImage imageNamed:@"fullscreen.png"] forState:UIControlStateNormal];
        isLetterBox = YES;
    }
}

- (void) setIsLoading:(BOOL)status {
   [self.loaderView setHidden:!status];
}

- (void)setNextState:(BOOL)nextState andPreviousState:(BOOL)prevState {
    [nextButton setEnabled:nextState];
    [prevButton setEnabled:prevState];
}

- (IBAction)goToPrev:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NextVideo" object:nil userInfo:@{ @"index": @"-1" }];
}

- (IBAction)goToNext:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"NextVideo" object:nil userInfo:@{ @"index": @"1" }];
}

- (void)setCurrentIndex:(NSInteger)index outOf:(NSInteger)total {
    if (total > 1) {
        lblState.text = [NSString stringWithFormat:@"%d / %d", index, total];
    }
}

- (IBAction)doRewind:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"RewindVideo" object:nil];
}

- (IBAction)doFastForward:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"FastForwardVideo" object:nil];
}

- (IBAction)sliderTouch:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
}

- (IBAction)sliderValueChanged:(id)sender {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeTimeVideo" object:nil userInfo:@ {@"time": [NSString stringWithFormat:@"%f", self.timeSlider.value] }];
}

- (void)setIsPlaying:(BOOL)playing {
    if (!playing) {
        [self.togglePlayButton setImage:[UIImage imageNamed:@"playvid.png"] forState:UIControlStateNormal];
        [self.togglePlayButton setImage:[UIImage imageNamed:@"playvidover.png"] forState:UIControlStateNormal];
    }
    else {
        [self.togglePlayButton setImage:[UIImage imageNamed:@"pause.png"] forState:UIControlStateNormal];
        [self.togglePlayButton setImage:[UIImage imageNamed:@"pauseover.png"] forState:UIControlStateNormal];
    }
}

- (void)setIsSimpleStream:(BOOL)simple {
    if(simple) {
        [self.simplePlayView setHidden:NO];
        [self.controlsContainerView setHidden:YES];
    }
    else {
        [self.simplePlayView setHidden:YES];
        [self.controlsContainerView setHidden:NO];
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self performSelector:@selector(hideControls:) withObject:nil afterDelay:5];
}

- (void)setDuration:(double)duration {
    videoDuration = duration;
    self.timeSlider.maximumValue = videoDuration;
    self.lblDuration.text = [self stringFromTimeInterval:duration];
}

- (void)setCurrentTime:(double)time {
    self.lblElapsed.text = [self stringFromTimeInterval:time];
    if(time >= 0) {
        self.timeSlider.value = time;
    }
    else {
        self.timeSlider.value = 0;
    }
}

- (NSString *)stringFromTimeInterval:(NSTimeInterval)interval {
    if(interval < 0) return @"00:00:00";
    NSInteger ti = (NSInteger)interval;
    NSInteger seconds = ti % 60;
    NSInteger minutes = (ti / 60) % 60;
    NSInteger hours = (ti / 3600);
    return [NSString stringWithFormat:@"%02i:%02i:%02i", hours, minutes, seconds];
}

-(void) dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

@end
