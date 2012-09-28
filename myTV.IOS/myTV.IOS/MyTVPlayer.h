//
//  MyTVPlayer.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/13/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "PlayerSubViewResponder.h"
#import "MyTVPlayerUIHandler.h"

@interface MyTVPlayer : NSObject
{
    id PlayerObserver;
    id StopObserver;
    id FFObserver;
    id RewindObserver;
    id NextVideoObserver;
    id TogglePlayObserver;
    id TimeObserver;
    UIView *PlayerView;
    NSMutableArray *urls;
    int videoIndex;
    BOOL haltPlayback;
    BOOL VideoStopCalled;
}

@property MPMoviePlayerController *movieController;
@property NSObject<MyTVPlayerUIHandler> *responder;
@property (unsafe_unretained) UIView *mainView;

- (void) startHandlingPlayerRequests;

@end
