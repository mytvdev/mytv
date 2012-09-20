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

@interface MyTVPlayer : NSObject
{
    id PlayerObserver;
    id StopObserver;
    UIView *PlayerView;
}

@property MPMoviePlayerController *movieController;
@property PlayerSubViewResponder *responder;
@property (unsafe_unretained) UIView *mainView;

- (void) startHandlingPlayerRequests;

@end
