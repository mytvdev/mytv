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
                [[player.movieController view] setFrame:[self.mainView bounds]];
                player.movieController.controlStyle = MPMovieControlStyleNone;
                
                self.responder = [[PlayerSubViewResponder alloc] init];
                NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"PlayerSubView" owner:self.responder options:nil];
                UIView *view = [nibs objectAtIndex:0];
                PlayerView = view;
                [self.responder setPlayerView:player.movieController.view];
                [self.mainView addSubview:view];
                [self setNextPreviousStates];
            }
            else {
                UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Error" message:@"No Video Found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [view show];
            }
            
        }
        
    }];
    StopObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"StopVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        haltPlayback = YES;
        [player.movieController stop];
        
        if(haltPlayback == YES && PlayerView != nil) {
            [PlayerView removeFromSuperview];
            PlayerView = nil;
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
    
    [[NSNotificationCenter defaultCenter] addObserverForName:MPMoviePlayerPlaybackStateDidChangeNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
        MPMoviePlaybackState state = [player.movieController playbackState];
        switch (state) {
            case MPMoviePlaybackStatePlaying :
                [player.responder setIsLoading:NO];
                break;
                
            case MPMoviePlaybackStateInterrupted :
                [player.responder setIsLoading:YES];
                break;

            case MPMoviePlaybackStateStopped:
                VideoStopCalled = YES;
                if(haltPlayback == YES && PlayerView != nil) {
                    [PlayerView removeFromSuperview];
                    PlayerView = nil;
                }
                else {
                    [self playNextOrHalt];
                }
                break;
            default:
                break;
        }
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
        [self setNextPreviousStates];
    }
    else {
        [PlayerView removeFromSuperview];
        PlayerView = nil;
    }
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
    if (PlayerObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:PlayerObserver];
        PlayerObserver = nil;
    }
    if(StopObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:StopObserver];
        StopObserver = nil;
    }
    if(NextVideoObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:NextVideoObserver];
        NextVideoObserver = nil;
    }
}

@end
