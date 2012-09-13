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
            
            [player.movieController play];
            [[[UIApplication sharedApplication] keyWindow] addSubview:player.movieController.view];
        }
        
    }];

}

- (void) dealloc {
    if (PlayerObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:PlayerObserver];
        PlayerObserver = nil;
    }
}

@end
