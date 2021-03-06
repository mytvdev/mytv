//
//  EpisodeSubViewResponder.m
//  myTV.IOS
//
//  Created by myTV Inc. on 9/17/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "EpisodeSubViewResponder.h"

#define PageSize ((VODControl_Space + VODControl_Width) * 3)

@implementation EpisodeSubViewResponder

@synthesize txtPinCode;
@synthesize lblPriceOrExpiry;
@synthesize btnPayOrPlay;
@synthesize lblEpisodeDescription;
@synthesize lblEpisodeName;
@synthesize imgEpisode;
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
        episodeFetcher = [[RestCache CommonProvider] RequestGetEpisode:idvalue usingCallback:^(Episode *episode, NSError *error){
            if(episode != nil && error == nil) {
                episodeId = idvalue;
                programId = episode.ProgramId;
                [self.lblPriceOrExpiry setHidden:YES];
                [self.btnPayOrPlay setHidden:YES];
                [self.btnPayOrPlay setEnabled:YES];
                currentepisode = episode;
                
                lblEpisodeName.text = (episode.Title != nil && [episode.Title length] > 0) ? episode.Title : @"-";
                [[RestCache CommonProvider] RequestGetProgram:programId usingCallback:^(MyTVProgram *program, NSError *error){
                    if(program != nil && error == nil) {
                        lblEpisodeName.text = [NSString stringWithFormat:@"%@ - %@", program.Title, lblEpisodeName.text];
                    }
                }];
                lblEpisodeDescription.text = (episode.Description != nil && [episode.Description length] > 0) ? episode.Description : @"-";
                lblDirector.text = (episode.Director != nil && [episode.Director length] > 0) ? episode.Director : @"-";
                if (episode.Guest != nil && [episode.Guest length] > 0)
                {
                    lblCast.text = [[episode.Guest substringToIndex:25] stringByAppendingString:@"..."];
                }
                else
                {
                    lblCast.text = @"-";
                }
                lblPresenter.text = (episode.Presenter != nil && [episode.Presenter length] > 0) ? episode.Presenter : @"-";
                lblLanguage.text = (episode.Language != nil && [episode.Language length] > 0) ? episode.Language : @"-";
                lblSeason.text = (episode.Season != nil && [episode.Season length] > 0) ? episode.Season : @"-";
                lblReleaseDate.text = (episode.ReleaseDate != nil && [episode.ReleaseDate length] > 0) ? episode.ReleaseDate : @"-";
                lblAwards.text = (episode.Awards != nil && [episode.Awards length] > 0) ? episode.Awards : @"-";
                lblRating.text = (episode.Rating != nil && [episode.Rating length] > 0) ? episode.Rating : @"-";
                episodeImageFetcher = [DataFetcher Get:episode.Thumbnail usingCallback:^(NSData *data, NSError *error){
                    if(data != nil && error == nil) {
                        imgEpisode.image  = [[UIImage alloc] initWithData:data];
                    }
                    episodeImageFetcher = nil;
                }];
                [self fillRelatedVOD:episode.ProgramId];
                [self fillProgramEpisodes:episode.ProgramId];
                [RestService RequestIsPurchased:MyTV_RestServiceUrl thisEpisode:idvalue withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(PurchaseInformation* pi, NSError *error){
                    if(error == nil && pi != nil && pi.isPurchased == YES) {
                        [self.btnPayOrPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
                        [self.btnPayOrPlay setImage:[UIImage imageNamed:@"play-Over.png"] forState:UIControlStateHighlighted];
                        [self.btnPayOrPlay setHidden:NO];
                        if(pi.expiryDate != nil) {
                            [self.lblPriceOrExpiry setHidden:NO];
                            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                            [formatter setDateFormat:@"yyyy-MM-dd"];
                            [self.lblPriceOrExpiry setText:[formatter stringFromDate:pi.expiryDate]];
                        }
                        isPurchased = YES;
                    }
                    else {
                        isPurchased = NO;
                        if ([episode.Price floatValue] > 0) {
                            [self.btnPayOrPlay setImage:[UIImage imageNamed:@"buyEpisode.png"] forState:UIControlStateNormal];
                            [self.btnPayOrPlay setImage:[UIImage imageNamed:@"buyEpisode-Over.png"] forState:UIControlStateHighlighted];
                            [self.btnPayOrPlay setHidden:NO];
                            [self.lblPriceOrExpiry setHidden:NO];
                            [self.lblPriceOrExpiry setText:[NSString stringWithFormat:@"$%@", episode.Price]];
                        }
                    }
                    
                }];
            }
            [MBProgressHUD hideHUDForView:self.mainView animated:NO];
        }];
    }
}

- (void) fillRelatedVOD:(NSString *)programId {
    if(!hasLoadedRelatedData) {
        EpisodeSubViewResponder *subview = self;
        
        for(UIView *view in[subview.relatedVODScrollView subviews]) {
            [view removeFromSuperview];
        }
        MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.relatedVODScrollView animated:YES];
        
        relatedVODFetcher = [[RestCache CommonProvider] RequestFeaturedVOD:^(NSArray *array, NSError *error){
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

- (void) fillProgramEpisodes:(NSString *)pId {
    EpisodeSubViewResponder *subview = self;
    for(UIView *view in[subview.episodeScrollView subviews]) {
        [view removeFromSuperview];
    }
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.episodeScrollView animated:YES];
    programEpisodesFetcher = [[RestCache CommonProvider] RequestGetProgramVOD:pId usingCallback:^(NSArray *array, NSError *error){
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
        subview.txtPinCode.delegate = subview;
        CGRect frame = CGRectMake(0, 0, self.episodeScrollView.frame.size.width, self.episodeScrollView.frame.size.height);
        [subview.episodeScrollView scrollRectToVisible:frame animated:NO];
        float val = subview.episodeScrollView.contentSize.width / PageSize;
        subview.episodePager.numberOfPages = [[NSString stringWithFormat:@"%f",  val] integerValue];
        [self scrollViewDidScroll:subview.episodeScrollView];
        [loader hide:YES];
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
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

- (IBAction)playOrBuyEpisode:(id)sender {
    if(!isPurchased) {
        [btnPayOrPlay setHidden:YES];
        [txtPinCode setHidden:NO];
        txtPinCode.text = @"";
        [txtPinCode becomeFirstResponder];
    }
    else
    {
        [RestService RequestGetVODUrl:MyTV_RestServiceUrl ofVideo:episodeId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSString *url, NSError *error){
                        [[NSNotificationCenter defaultCenter] postNotificationName:@"PlayVideo" object:nil userInfo:@{@"url": url}];
        }];

    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    if(textField == self.txtPinCode) {
        if (txtPinCode.isFirstResponder) {
            [textField resignFirstResponder];
            [txtPinCode setHidden:YES];
            [btnPayOrPlay setHidden:NO];
        }
    }
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.txtPinCode) {
        [txtPinCode setHidden:YES];
        [btnPayOrPlay setHidden:NO];
        return  YES;
    }
    return NO;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.txtPinCode) {
        [textField resignFirstResponder];
        [btnPayOrPlay setEnabled:NO];
        if(isPurchased) {
            //[self playcode]
        }
        else {
            [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error) {
                if(linking != nil && error == nil && [textField.text isEqualToString:[NSString stringWithFormat:@"%d", linking.PinCode]]) {
                    [self buyEpisode];
                    blnPurchased = YES;
                }
                else
                {
                    UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"" message:@"Invalid PIN Code" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                    [message show];
                    blnPurchased = NO;
                    [self.btnPayOrPlay setEnabled:YES];
                }
            } synchronous:YES];
        }
        
        if (blnPurchased) {
            return YES;
        }
    }
    return NO;
}

-(void) buyEpisode {
    EpisodeSubViewResponder *subview = self;
    RSLinkingCallBack callback = ^(Linking *data, NSError *error){
        if(error == nil && data != nil) {
            NSString *pid = [NSString stringWithFormat:@"%d", currentepisode.Id];
            NSString *bid = [NSString stringWithFormat:@"%d", data.BillingId];
            [RestService BuyRequest:MyTV_RestServiceUrl VOD:pid usingBilling:bid withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSString *status, NSError *error) {
                if(error == nil && status != nil) {
                    if([status compare:@"success"] == NSOrderedSame) {
                        isPurchased = YES;
                        [self.btnPayOrPlay setImage:[UIImage imageNamed:@"play.png"] forState:UIControlStateNormal];
                        [self.btnPayOrPlay setImage:[UIImage imageNamed:@"play-Over.png"] forState:UIControlStateHighlighted];
                        [self.btnPayOrPlay setHidden:NO];
                        
                        [self.lblPriceOrExpiry setText:@""];
                    }
                    else {
                        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"Purchase failed: %@", status] delegate:subview cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [view show];
                    }
                }
                [self.btnPayOrPlay setEnabled:YES];
            }];
        }
        else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"You must login with your account first" delegate:subview cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
        }
    };
    
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:callback synchronous:NO];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@ { MyTV_ViewArgument_View: MyTV_View_Login }];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 5) ? NO : YES;
}

@end
