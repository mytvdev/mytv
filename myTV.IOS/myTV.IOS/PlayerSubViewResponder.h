//
//  PlayerSubViewResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "MyTVPlayerUIHandler.h"

@interface PlayerSubViewResponder : SubViewResponder <MyTVPlayerUIHandler>
{
    double videoDuration;
}
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblDuration;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblElapsed;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *loaderView;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *playerContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *controlsContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *showControlsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *showControlsSimpleView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *loadingLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *prevButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *nextButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *togglePlayButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *simplePlayView;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblState;
@property (unsafe_unretained, nonatomic) IBOutlet UISlider *timeSlider;

@property UITapGestureRecognizer *displayControlsTap;


- (IBAction)stopVideo:(id)sender;
- (IBAction)hideControls:(id)sender;
- (IBAction)showControls:(id)sender;
- (IBAction)togglePlay:(id)sender;

- (IBAction)doRewind:(id)sender;
- (IBAction)doFastForward:(id)sender;
- (IBAction)sliderTouch:(id)sender;
- (IBAction)sliderValueChanged:(id)sender;


- (IBAction)goToPrev:(id)sender;
- (IBAction)goToNext:(id)sender;

@end
