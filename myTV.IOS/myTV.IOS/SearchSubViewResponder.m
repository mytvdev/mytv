//
//  SearchSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 10/10/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SearchSubViewResponder.h"

@implementation SearchSubViewResponder

@synthesize searchFetcher = _searchFetcher;
@synthesize SearchScrollView;
@synthesize ProgramSearchScrollView;
@synthesize labelResults;
@synthesize labelEpisodes;
@synthesize labelPrograms;

- (void)viewDidLoad
{
    //[super viewDidLoad];
    [self.labelResults setHidden:YES];
}

-(void)bindData:(NSObject *)data
{
    if([[self.SearchScrollView subviews] count] > 0) {
        for (UIView *view in [self.SearchScrollView subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    if([[self.ProgramSearchScrollView subviews] count] > 0) {
        for (UIView *view in [self.ProgramSearchScrollView subviews])
        {
            [view removeFromSuperview];
        }
    }
    
    [self searchEpisodes:data];
}

-(void) searchEpisodes:(NSObject *)SearchText {
    [self.SearchScrollView setHidden:NO];
    [self.ProgramSearchScrollView setHidden:NO];
    [self.labelEpisodes setHidden:NO];
    [self.labelPrograms setHidden:NO];
    [MBProgressHUD showHUDAddedTo:self.SearchScrollView animated:YES];
    [MBProgressHUD showHUDAddedTo:self.ProgramSearchScrollView animated:YES];
    [RestService Search:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId andSearchCriteria:(NSString *)SearchText usingCallback:^(NSArray* episodes, NSError *error)
    {
        if(episodes != nil && error == nil && episodes.count > 0)
        {
            int maximumWidth = self.SearchScrollView.frame.size.width;
            int xPos = 0;
            int yPos = 0;
            int xPosP = 0;
            int yPosP = 0;
            for (Episode *episode in episodes)
            {
                
                NSString *type = episode.Type;
                if ([type isEqualToString:@"episode"])
                {
                    if(xPos == 0)
                    {
                        xPos = SearchControl_Space;
                    }
                    else if ( (xPos + SearchControl_Width + SearchControl_Space + SearchControl_Width) > maximumWidth)
                    {
                        xPos = SearchControl_Space;
                        yPos = yPos + SearchControl_Height;
                    }
                    else
                    {
                        xPos = xPos + SearchControl_Width + SearchControl_Space;
                    }
                    
                    SearchControlResponder *responder = [[SearchControlResponder alloc] init];
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchControl" owner:responder options:nil];
                    UIView *view = [array objectAtIndex:0];
                    view.frame = CGRectMake(xPos, yPos, view.frame.size.width, view.frame.size.height);
                    [self.SearchScrollView addSubview:view];
                    [responder bindData:episode];
                }
                else
                {
                    if(xPosP == 0)
                    {
                        xPosP = SearchControl_Space;
                    }
                    else if ( (xPosP + SearchControl_Width + SearchControl_Space + SearchControl_Width) > maximumWidth)
                    {
                        xPosP = SearchControl_Space;
                        yPosP = yPosP + SearchControl_Height;
                    }
                    else
                    {
                        xPosP = xPosP + SearchControl_Width + SearchControl_Space;
                    }
                    
                    SearchControlResponder *responder = [[SearchControlResponder alloc] init];
                    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchControl" owner:responder options:nil];
                    UIView *view = [array objectAtIndex:0];
                    view.frame = CGRectMake(xPosP, yPosP, view.frame.size.width, view.frame.size.height);
                    [self.ProgramSearchScrollView addSubview:view];
                    [responder bindData:episode];
                }
                
            }
            self.SearchScrollView.contentSize = CGSizeMake(maximumWidth, yPos + SearchControl_Height);
            self.ProgramSearchScrollView.contentSize = CGSizeMake(maximumWidth, yPosP + SearchControl_Height);
            [self.labelResults setText:@""];
            [self.labelResults setHidden:YES];
        }
        else
        {
            [self.SearchScrollView setHidden:YES];
            [self.ProgramSearchScrollView setHidden:YES];
            [self.labelEpisodes setHidden:YES];
            [self.labelPrograms setHidden:YES];
            [self.labelResults setHidden:NO];
            [self.labelResults setText:@"No Results found."];
        }
        
    }];
    [MBProgressHUD hideHUDForView:self.SearchScrollView animated:YES];
    [MBProgressHUD hideHUDForView:self.ProgramSearchScrollView animated:YES];
}

@end
