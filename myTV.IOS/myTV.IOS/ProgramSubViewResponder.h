//
//  ProgramSubViewResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/17/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"
#import "VODControlResponder.h"

@interface ProgramSubViewResponder : SubViewResponder <
    UIScrollViewDelegate
    , UITextFieldDelegate
    , UIAlertViewDelegate
>
{
    DataFetcher *programFetcher;
    DataFetcher *programImageFetcher;
    DataFetcher *relatedVODFetcher;
    DataFetcher *programEpisodesFetcher;
    BOOL hasLoadedRelatedData;
    MyTVProgram *currentprogram;
    BOOL isPurchased;
}


@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txtPinCode;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPriceOrExpiry;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnPayOrPlay;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblProgramDescription;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblProgramName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgProgram;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *episodeContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *episodeScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *relatedVODScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblDirector;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblCast;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPresenter;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblLanguage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblSeason;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblReleaseDate;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblAwards;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblRating;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIPageControl *episodePager;

- (IBAction)changeEpisodePage:(id)sender;
- (IBAction)playOrBuyProgram:(id)sender;

@end
