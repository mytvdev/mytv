//
//  MyVODSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
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

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedMyVODData) {
        [self fillMyVOD];
        
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
        
        [myvodKKGridView performSelectorOnMainThread:@selector(reloadData)
                                             withObject:nil
                                          waitUntilDone:NO];
        
        
        [self.myvodView addSubview:myvodKKGridView];
        hasLoadedMyVODData = YES;
    }
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
    if([cell respondsToSelector:@selector(bindData::)]) {
        [cell performSelector:@selector(bindData:) withObject:episode];
    }
    return cell;
}

-(void) fillMyVOD {
    if(!hasLoadedMyVODData) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [RestService RequestGetMyVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *episodes, NSError *error)
         {
             if(episodes != nil && error == nil)
             {
                 for (Episode *episode in episodes) {
                     [array addObject:episode];
                 }
                 [_fillerData addObject:array];
             }
             hasLoadedMyVODData = YES;
         } synchronous:YES];
    }
}

-(void) cancelMyVODFetcher {
    if(_myvodFetcher != nil) {
        [_myvodFetcher cancelPendingRequest];
        _myvodFetcher = nil;
    }
}

@end
