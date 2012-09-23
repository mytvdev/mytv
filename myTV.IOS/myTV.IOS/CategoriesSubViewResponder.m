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
@synthesize fillerProgramTypeData = _fillerProgramTypeData;
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
        categoriesKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        categoriesKKGridView.allowsMultipleSelection = NO;
        categoriesKKGridView.gridHeaderView = nil;
        categoriesKKGridView.gridFooterView = nil;
        
        [self fillGenres];
    }
}

#pragma mark - KKGridViewDataSource

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    if(!IsLoadingProgramTypes)
        return _fillerData.count;
    else
        return _fillerProgramTypeData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    if(!IsLoadingProgramTypes)  
        return [[_fillerData objectAtIndex:section] count];
    else
        return [[_fillerProgramTypeData objectAtIndex:section] count];
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKDemoCell *cell = [KKDemoCell cellForGridView:gridView];
    
    if(!IsLoadingProgramTypes)
    {
        Genre *genre = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
        [cell.button setTitle:genre.Title forState:UIControlStateNormal];
    }
    else
    {
        ProgramType *programtype = [[_fillerProgramTypeData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
        
        if (programtype.Id == -1) {
            [cell setIsBackButton:YES];
            [cell.button setTitle:@"" forState:UIControlStateNormal];
            UIImage *backButtonImage = [UIImage imageNamed:@"backward.png"];
            [cell.button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
        }
        else
        {
            [cell setIsBackButton:NO];
            [cell.button setTitle:programtype.Title forState:UIControlStateNormal];
        }
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    cell.indexCellPath = indexPath;
    return cell;
}

- (void)fillProgramTypes:(KKDemoCell *)cell;
{
    if(hasLoadedGenresData) {
        [MBProgressHUD showHUDAddedTo:self.categoriesSubView animated:YES];
        
        _fillerProgramTypeData = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        Genre *genre = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)cell.indexCellPath.index];
        
        if(genre != nil)
        {
            ProgramType *pt = [ProgramType new];
            [pt setId:-1];
            [pt setTitle:@""];
            //[array addObject:pt];
            
            for (ProgramType *programtype in genre.programTypes) {
                [array addObject:programtype];
            }
            [_fillerProgramTypeData addObject:array];
        }
        IsLoadingProgramTypes = YES;
        [categoriesKKGridView reloadData];
        
        [MBProgressHUD hideHUDForView:self.categoriesSubView animated:YES];
    }
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
                    [array addObject:genre];
                }
                [_fillerData addObject:array];
            }
            hasLoadedGenresData = YES;
            IsLoadingProgramTypes = NO;
            [categoriesKKGridView reloadData];
            [self.categoriesSubView addSubview:categoriesKKGridView];
            [MBProgressHUD hideHUDForView:self.categoriesSubView animated:YES];
        }];
    }
}

-(void) ReloadGenres:(KKDemoCell *)cell;
{
    [MBProgressHUD showHUDAddedTo:self.categoriesSubView animated:YES];
    hasLoadedGenresData = YES;
    IsLoadingProgramTypes = NO; 
    [categoriesKKGridView reloadData];
    [self.categoriesSubView addSubview:categoriesKKGridView];
    [MBProgressHUD hideHUDForView:self.categoriesSubView animated:YES];
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
