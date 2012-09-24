//
//  PlayerSubViewResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"

@interface PlayerSubViewResponder : SubViewResponder
@property (unsafe_unretained, nonatomic) IBOutlet UIView *playerContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *controlsContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *showControlsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loadingLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *prevButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *nextButton;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblState;

@property UITapGestureRecognizer *displayControlsTap;

- (void) setPlayerView:(UIView *)view;
- (IBAction)stopVideo:(id)sender;
- (IBAction)hideControls:(id)sender;
- (IBAction)showControls:(id)sender;

- (void) setIsLoading:(BOOL)status;
- (void) setNextState:(BOOL)nextState andPreviousState:(BOOL)prevState;
- (void) setCurrentIndex:(NSInteger)index outOf:(NSInteger)total;


- (IBAction)goToPrev:(id)sender;
- (IBAction)goToNext:(id)sender;

@end
