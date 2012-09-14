//
//  PlayerSubViewResponder.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/14/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"

@interface PlayerSubViewResponder : SubViewResponder
@property (unsafe_unretained, nonatomic) IBOutlet UIView *playerContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *controlsContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *showControlsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loadingLabel;


@property UITapGestureRecognizer *displayControlsTap;

- (void) setPlayerView:(UIView *)view;
- (IBAction)stopVideo:(id)sender;
- (IBAction)hideControls:(id)sender;
- (IBAction)showControls:(id)sender;

- (void) setIsLoading:(BOOL)status;

@end
