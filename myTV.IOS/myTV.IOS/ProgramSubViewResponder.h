//
//  ProgramSubViewResponder.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/17/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"
#import "VODControlResponder.h"

@interface ProgramSubViewResponder : SubViewResponder <
    UIScrollViewDelegate
>
{
    DataFetcher *programFetcher;
    DataFetcher *programImageFetcher;
    DataFetcher *relatedVODFetcher;
    DataFetcher *programEpisodesFetcher;
    BOOL hasLoadedRelatedData; 
}

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

@end
