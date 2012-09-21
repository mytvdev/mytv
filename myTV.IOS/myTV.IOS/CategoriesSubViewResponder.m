//
//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "CategoriesSubViewResponder.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize categoriesSubView;
@synthesize categoriesKKGridView;
@synthesize genreFetcher = _genreFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedGenresData) {
        categoriesKKGridView = [[KKGridView alloc] initWithFrame:self.categoriesSubView.bounds];
        categoriesKKGridView.dataSource = self;
        categoriesKKGridView.delegate = self;
        categoriesKKGridView.scrollsToTop = YES;
        categoriesKKGridView.backgroundColor = [UIColor clearColor];
        categoriesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        categoriesKKGridView.cellSize = CGSizeMake(108.f, 60.f);
        categoriesKKGridView.cellPadding = CGSizeMake(0.f, 15.f);
        categoriesKKGridView.allowsMultipleSelection = NO;
        categoriesKKGridView.gridHeaderView = nil;
        categoriesKKGridView.gridFooterView = nil;
        
        [self fillGenres];
    }
}

#pragma mark - KKGridViewDataSource

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
    KKDemoCell *cell = [KKDemoCell cellForGridView:gridView];
    cell.label.text = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void) fillGenres {
    if(!hasLoadedGenresData) {
        [MBProgressHUD showHUDAddedTo:self.categoriesSubView animated:YES];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [RestService RequestGenres:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *genres, NSError *error)
        {
            if(genres != nil && error == nil)
            {
                for (Genre *genre in genres) {
                    [array addObject:genre.Title];
                }
                [_fillerData addObject:array];
            }
            [categoriesKKGridView reloadData];
            [self.categoriesSubView addSubview:categoriesKKGridView];
            hasLoadedGenresData = YES;
            [MBProgressHUD hideHUDForView:self.categoriesSubView animated:YES];
        }];
    }
}

-(void) cancelGenreFetcher {
    if(_genreFetcher != nil) {
        [_genreFetcher cancelPendingRequest];
        _genreFetcher = nil;
    }
}

-(void) abortOperatons {
    [self cancelGenreFetcher];
}

-(void) forceReloadGenres {
    hasLoadedGenresData = NO;
    [self cancelGenreFetcher];
    [self fillGenres];
}

@end
