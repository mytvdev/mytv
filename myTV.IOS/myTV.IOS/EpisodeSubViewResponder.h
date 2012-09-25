//
//  EpisodeSubViewResponder.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/17/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"
#import "VODControlResponder.h"
#import "RestCache.h"

@interface EpisodeSubViewResponder : SubViewResponder <
UIScrollViewDelegate
, UITextFieldDelegate
, UIAlertViewDelegate
>
{
    DataFetcher *episodeFetcher;
    DataFetcher *episodeImageFetcher;
    DataFetcher *relatedVODFetcher;
    DataFetcher *programEpisodesFetcher;
    BOOL hasLoadedRelatedData;
    Episode *currentepisode;
    BOOL isPurchased;
    NSString *episodeId;
    NSString *programId;
}

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txtPinCode;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPriceOrExpiry;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnPayOrPlay;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblEpisodeDescription;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblEpisodeName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgEpisode;
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
- (IBAction)playOrBuyEpisode:(id)sender;

@end
