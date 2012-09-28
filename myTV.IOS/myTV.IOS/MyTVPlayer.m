//
//  MyTVPlayer.m
//  myTV.IOS
//
//  Created by myTV Inc. on 9/13/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "MyTVPlayer.h"


@implementation MyTVPlayer

- (void) startHandlingPlayerRequests {
    MyTVPlayer *player = self;
    PlayerObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"PlayVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        
        if (note.userInfo != nil) {
            NSObject *url = [note.userInfo valueForKey:@"url"];
            DLog(@"%@", url);
            if(url != nil && [url isKindOfClass:[NSString class]]) {
                urls = [[NSMutableArray alloc] init];
                [urls addObject:url];
            }
            else {
                urls = (NSMutableArray *)url;
            }
            if(urls != nil && [urls count] > 0) {
                videoIndex = 0;
                NSString *playurl = [urls objectAtIndex:videoIndex];
                NSURL *vidUrl = [NSURL URLWithString:playurl];
                player.movieController = [[MPMoviePlayerController alloc] initWithContentURL:vidUrl];
                player.movieController.scalingMode = MPMovieScalingModeAspectFit;
                [player.movieController play];
                [self performSelector:@selector(setCurrentTime) withObject:nil afterDelay:1];
                [[player.movieController view] setFrame:[self.mainView bounds]];
                player.movieController.controlStyle = MPMovieControlStyleNone;
                
                self.responder = [[PlayerSubViewResponder alloc] init];
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PlayerSubView" owner:self.responder options:nil];
                UIView *view = [nibs objectAtIndex:0];
                PlayerView = view;
                [self.responder setPlayerView:player.movieController.view];
                [self.mainView addSubview:view];
                [self setNextPreviousStates];
                [self.responder setIsPlaying:YES];
                [self.responder setIsSimpleStream:YES];
            }
            else {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Video Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [view show];
            }
            
        }
        
    }];
    StopObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"StopVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        haltPlayback = YES;
        self.movieController.currentPlaybackRate = 1;
        [player.movieController stop];
        if(haltPlayback == YES && PlayerView != nil) {
            [self removePlayer];
        }
    }];
    
    NextVideoObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"NextVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        haltPlayback = NO;
        if(note.userInfo != nil) {
            NSString *value = [note.userInfo valueForKey:@"index"];
            if(value != nil) {
                NSInteger intval = [value integerValue];
                if(intval != 0) {
                    videoIndex = videoIndex + intval - 1;
                    if(videoIndex < -1) videoIndex = -1;
                }
            }
        }
        VideoStopCalled = NO;
        [player.movieController stop];
        if(!VideoStopCalled) {
            [self playNextOrHalt];
        }
    }];
    
    TimeObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"ChangeTimeVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        NSString *time = [note.userInfo valueForKey:@"time"];
        float currentTime = [time floatValue];
        if (currentTime >= 0 && currentTime <= self.movieController.duration) {
            self.movieController.currentPlaybackTime = currentTime;
        }
        
    }];
    
    FFObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"FastForwardVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        float playbackrate = self.movieController.currentPlaybackRate;
        if(self.movieController.currentPlaybackRate < 1) {
            self.movieController.currentPlaybackRate = 2;
        }
        else {
            if(self.movieController.currentPlaybackRate < 32) {
                self.movieController.currentPlaybackRate = self.movieController.currentPlaybackRate * 2;
            }
        }
         playbackrate = self.movieController.currentPlaybackRate;
    }];
    RewindObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"RewindVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        float playbackrate = self.movieController.currentPlaybackRate;
        if(self.movieController.currentPlaybackRate > -1) {
            [self.movieController beginSeekingBackward];
            self.movieController.currentPlaybackRate = -1;
        }
        else {
            if(self.movieController.currentPlaybackRate > -32) {
                [self.movieController beginSeekingForward];
                self.movieController.currentPlaybackRate = self.movieController.currentPlaybackRate * 2;
            }
        }
         playbackrate = self.movieController.currentPlaybackRate;
    }];
    
    TogglePlayObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"TogglePlayVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        if (self.movieController.playbackState == MPMoviePlaybackStatePlaying) {
            [self.movieController pause];
            [self.responder setIsPlaying:NO];
        }
        else {
            self.movieController.currentPlaybackRate = 1;
            [self.movieController play];
            [self.responder setIsPlaying:YES];
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackStateDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        MPMoviePlaybackState state = [player.movieController playbackState];
        switch (state) {
            case MPMoviePlaybackStateStopped:
                VideoStopCalled = YES;
                if(haltPlayback == YES && PlayerView != nil) {
                    [self removePlayer];
                }
                else {
                    [self playNextOrHalt];
                }
                break;
            default:
                DLog(@"%d", state);
                break;
        }
    }];
    
    [[NSNotificationCenter defaultCenter] addObserverForName:MPMovieDurationAvailableNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        [self.responder setIsSimpleStream:NO];
        [self.responder setDuration:self.movieController.duration];
    }];

}

- (void) playNextOrHalt {
    
    videoIndex += 1;
    if (videoIndex < [urls count]) {   
        NSString *playurl = [urls objectAtIndex:videoIndex];
        NSURL *vidUrl = [NSURL URLWithString:playurl];
        self.movieController.contentURL = vidUrl;
        [self.movieController prepareToPlay];
        [self.movieController play];
        [self.responder setIsLoading:YES];
        [self setNextPreviousStates];
    }
    else {
        [self removePlayer];
    }
}

- (void) setCurrentTime {
    if(self.responder != nil && self.movieController != nil) {
        [self.responder setCurrentTime:self.movieController.currentPlaybackTime];
        [self performSelector:@selector(setCurrentTime) withObject:nil afterDelay:0.5];
        if(self.movieController.loadState == MPMovieLoadStateStalled || self.movieController.loadState == MPMovieLoadStateUnknown || self.movieController.playbackState == MPMoviePlaybackStateInterrupted) {
            [self.responder setIsLoading:YES];
        }
        else {
            [self.responder setIsLoading:NO];
        }
    }

}

- (void) removePlayer {
    [PlayerView removeFromSuperview];
    [NSObject cancelPreviousPerformRequestsWithTarget:self.responder];
    PlayerView = nil;
    self.responder = nil;
    self.movieController = nil;
}

- (void) setNextPreviousStates {
    BOOL prevState = NO;
    BOOL nextState = NO;
    if(videoIndex > 0) prevState = YES;
    if(videoIndex < [urls count] - 1) nextState = YES;
    [self.responder setNextState:nextState andPreviousState:prevState];
    [self.responder setCurrentIndex:(videoIndex + 1) outOf:[urls count]];
}

- (void) dealloc {
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    if (PlayerObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:PlayerObserver];
    }
    if(StopObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:StopObserver];
    }
    if(NextVideoObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:NextVideoObserver];
    }
    if(FFObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:FFObserver];
    }
    if(RewindObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:RewindObserver];
    }
    if(TogglePlayObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:TogglePlayObserver];
    }
}


@end
