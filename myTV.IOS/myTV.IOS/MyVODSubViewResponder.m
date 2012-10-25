//  MyVODSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "MyVODSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation MyVODSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize myvodKKGridView;
@synthesize myvodView;
@synthesize myvodFetcher = _myvodFetcher;
@synthesize imageDisplay;

- (void)viewDidLoad
{
    if([[self.myvodView subviews] count] > 0) {
        for (UIView *view in [self.myvodView subviews])
        {
            if ([view isMemberOfClass:[KKGridView class]])
            {
                [view removeFromSuperview];
            }
        }
    }
    
    _fillerData = [[NSMutableArray alloc] init];
    
    //if(!hasLoadedMyVODData) {
        [self.imageDisplay setHidden:YES];
        myvodKKGridView = [[KKGridView alloc] initWithFrame:self.myvodView.bounds];
        myvodKKGridView.dataSource = self;
        myvodKKGridView.delegate = self;
        myvodKKGridView.scrollsToTop = YES;
        myvodKKGridView.backgroundColor = [UIColor clearColor];
        myvodKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        myvodKKGridView.cellSize = CGSizeMake(180.f, 180.f);
        myvodKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        myvodKKGridView.allowsMultipleSelection = NO;
        myvodKKGridView.gridHeaderView = nil;
        myvodKKGridView.gridFooterView = nil;
        
        [self fillMyVOD];
    //}
}

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return _fillerData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return [[_fillerData objectAtIndex:section] count];
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKEpisodeCell *cell = [KKEpisodeCell cellForGridView:gridView];
    Episode *episode = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.episode = episode;             
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if([cell respondsToSelector:@selector(bindEpisode:)])
        [cell performSelector:@selector(bindEpisode:) withObject:episode];
    return cell;
}

-(void) fillMyVOD {
    //if(!hasLoadedMyVODData) {
        [MBProgressHUD showHUDAddedTo:self.myvodView animated:YES];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [RestService RequestGetMyVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *episodes, NSError *error)
         {
             if(episodes != nil && error == nil)
             {
                 if (episodes.count > 0)
                 {
                     for (ItemBase *episode in episodes) {
                         [array addObject:episode];
                     }
                     [_fillerData addObject:array];
                     [self.imageDisplay setHidden:YES];
                 }
                 else
                     [self.imageDisplay setHidden:NO];
             }
             else
             {
                 [self.imageDisplay setHidden:NO];
             }
             [myvodKKGridView reloadData];
             [self.myvodView addSubview:myvodKKGridView];
             hasLoadedMyVODData = YES;
             [MBProgressHUD hideHUDForView:self.myvodView animated:NO];
         } synchronous:NO];
    //}
}

-(void) cancelMyVODFetcher {
    if(_myvodFetcher != nil) {
        [_myvodFetcher cancelPendingRequest];
        _myvodFetcher = nil;
    }
}

@end
