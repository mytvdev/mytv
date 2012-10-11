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

- (void)viewDidLoad
{
    //[super viewDidLoad];
}

-(void)bindData:(NSObject *)data
{
    if([[self.SearchScrollView subviews] count] > 0) {
        [[[self.SearchScrollView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    [self searchEpisodes:data];
}

-(void) searchEpisodes:(NSObject *)SearchText {
    [MBProgressHUD showHUDAddedTo:self.SearchScrollView animated:YES];
    [RestService Search:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId andSearchCriteria:(NSString *)SearchText usingCallback:^(NSArray* episodes, NSError *error)
    {
        if(episodes != nil && error == nil)
        {
            int maximumWidth = self.SearchScrollView.frame.size.width;
            int xPos = 0;
            int yPos = 0;
            for (Episode *episode in episodes)
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
            self.SearchScrollView.contentSize = CGSizeMake(maximumWidth, yPos + SearchControl_Height);
            [MBProgressHUD hideHUDForView:self.SearchScrollView animated:YES];
        }
    }];
}

@end
