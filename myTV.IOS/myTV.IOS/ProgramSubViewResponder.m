//
//  ProgramSubViewResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/17/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#define PageSize ((VODControl_Space + VODControl_Width) * 3)

#import "ProgramSubViewResponder.h"

@implementation ProgramSubViewResponder
@synthesize lblProgramDescription;
@synthesize lblProgramName;
@synthesize imgProgram;
@synthesize episodeContainerView;
@synthesize episodeScrollView;
@synthesize relatedVODScrollView;
@synthesize mainView;
@synthesize episodePager;
@synthesize lblDirector;
@synthesize lblCast;
@synthesize lblPresenter;
@synthesize lblLanguage;
@synthesize lblSeason;
@synthesize lblReleaseDate;
@synthesize lblAwards;
@synthesize lblRating;

-(void) viewDidLoad {

}

-(void)bindData:(NSObject *)data {
    NSDictionary *dict = (NSDictionary *)data;
    NSString *idvalue = [dict objectForKey:MyTV_ViewArgument_Id];
    if(idvalue != nil) {
        [MBProgressHUD showHUDAddedTo:self.mainView animated:YES];
        programFetcher = [RestService RequestGetProgram:MyTV_RestServiceUrl ofId:idvalue withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(MyTVProgram *program, NSError *error){
            if(program != nil && error == nil) {
                lblProgramName.text = (program.Title != nil && program.Title != @"") ? program.Title : @"-";
                lblProgramDescription.text = (program.Description != nil && program.Description != @"") ? program.Description : @"-";
                lblDirector.text = (program.Director != nil && program.Director != @"") ? program.Director : @"-";
                lblCast.text = (program.Guest != nil && program.Guest != @"") ? program.Guest : @"-";
                lblPresenter.text = (program.Presenter != nil && program.Presenter != @"") ? program.Presenter : @"-";
                lblLanguage.text = (program.Language != nil && program.Language != @"") ? program.Language : @"-";
                lblSeason.text = (program.Season != nil && program.Season != @"") ? program.Season : @"-";
                lblReleaseDate.text = (program.ReleaseDate != nil && program.ReleaseDate != @"") ? program.ReleaseDate : @"-";
                lblAwards.text = (program.Award != nil && program.Award != @"") ? program.Award : @"-";
                lblRating.text = (program.Rating != nil && program.Rating != @"") ? program.Rating : @"-";
                programImageFetcher = [DataFetcher Get:program.Thumbnail usingCallback:^(NSData *data, NSError *error){
                    if(data != nil && error == nil) {
                        imgProgram.image  = [[UIImage alloc] initWithData:data];
                    }
                    programImageFetcher = nil;
                }];
                [self fillRelatedVOD:idvalue];
                [self fillProgramEpisodes:idvalue];
            }
            [MBProgressHUD hideHUDForView:self.mainView animated:NO];
        }];
    }
}

- (void) fillRelatedVOD:(NSString *)programId {
    if(!hasLoadedRelatedData) {
        ProgramSubViewResponder *subview = self;
        
        for(UIView *view in[subview.relatedVODScrollView subviews]) {
            [view removeFromSuperview];
        }
        MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.relatedVODScrollView animated:YES];
        
        relatedVODFetcher = [RestService RequestGetFeaturedVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            int xPos = VODControl_Space;
            for (ItemBase *vod in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + VODControl_Space;
                [subview.relatedVODScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:vod];
                }
                
            }
            subview.relatedVODScrollView.contentSize = CGSizeMake(xPos, subview.relatedVODScrollView.frame.size.height);
            [loader hide:YES];
            hasLoadedRelatedData = YES;
        }];
    }
}

- (void) fillProgramEpisodes:(NSString *)programId {
    ProgramSubViewResponder *subview = self;
    
    for(UIView *view in[subview.episodeScrollView subviews]) {
        [view removeFromSuperview];
    }
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.episodeScrollView animated:YES];
    programEpisodesFetcher = [RestService RequestGetVOD:MyTV_RestServiceUrl ofProgram:programId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
        int xPos1 = VODControl_Space;
        int xPos2 = VODControl_Space;
        int pos = 0;
        for (ItemBase *vod in array) {
            VODControlResponder *responder = [[VODControlResponder alloc] init];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
            UIView *view = [array objectAtIndex:0];
            if (pos % 2 == 0) {
                view.frame = CGRectMake(xPos1, 0, view.frame.size.width, view.frame.size.height);
                xPos1 = xPos1 + view.frame.size.width + VODControl_Space;
            }
            else {
                view.frame = CGRectMake(xPos2, 155, view.frame.size.width, view.frame.size.height);
                xPos2 = xPos2 + view.frame.size.width + VODControl_Space;
            }
            pos++;
            [subview.episodeScrollView addSubview:view];
            if([responder respondsToSelector:@selector(bindData:)]) {
                [responder performSelector:@selector(bindData:) withObject:vod];
            }
            
                              
        }
        subview.episodeScrollView.contentSize = CGSizeMake(xPos1, subview.relatedVODScrollView.frame.size.height);
        subview.episodeScrollView.delegate = subview;
        float val = subview.episodeScrollView.contentSize.width / PageSize;
        subview.episodePager.numberOfPages = [[NSString stringWithFormat:@"%f",  val] integerValue];
        [loader hide:YES];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    DLog(@"Scorlling hereee");
    if(sender == self.episodeScrollView) {
        int page = floor((self.episodeScrollView.contentOffset.x - PageSize / 2) / PageSize) + 1;
        self.episodePager.currentPage = page;
    }
  
}


- (IBAction)changeEpisodePage:(id)sender {
    CGRect frame;
    frame.origin.x = PageSize * self.episodePager.currentPage;
    frame.origin.y = 0;
    frame.size = self.episodeScrollView.frame.size;
    [self.episodeScrollView scrollRectToVisible:frame animated:YES];
}
@end
