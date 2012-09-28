//
//  MyTVPlayerUIHandler.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/27/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MyTVPlayerUIHandler <NSObject>

- (void) setPlayerView:(UIView *)view;
- (void) setIsLoading:(BOOL)status;
- (void) setNextState:(BOOL)nextState andPreviousState:(BOOL)prevState;
- (void) setCurrentIndex:(NSInteger)index outOf:(NSInteger)total;
- (void) setIsPlaying:(BOOL)playing;
- (void) setIsSimpleStream:(BOOL)simple;
- (void) setDuration:(double)duration;
- (void) setCurrentTime:(double)time;

@end
