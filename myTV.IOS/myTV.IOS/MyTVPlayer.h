//
//  MyTVPlayer.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface MyTVPlayer : NSObject
{
    id PlayerObserver;
}

@property MPMoviePlayerController *movieController;

- (void) startHandlingPlayerRequests;

@end
