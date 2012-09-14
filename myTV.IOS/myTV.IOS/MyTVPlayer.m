//
//  MyTVPlayer.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "MyTVPlayer.h"


@implementation MyTVPlayer

- (void) startHandlingPlayerRequests {
    MyTVPlayer *player = self;
    PlayerObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"PlayVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        
        if (note.userInfo != nil) {
            NSString *url = [note.userInfo valueForKey:@"url"];
            DLog(@"%@", url);
            NSURL *vidUrl = [NSURL URLWithString:url];
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
            
            
        }
        
    }];
    StopObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"StopVideo" object:nil queue:nil usingBlock:^(NSNotification *note){
        [player.movieController stop];
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
                [PlayerView removeFromSuperview];
                PlayerView = nil;
                break;
            default:
                break;
        }
    }];
    

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
    self.movieController = nil;
    self.responder = nil;
}

@end
