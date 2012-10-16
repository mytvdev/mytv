//
//  CountriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/21/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "CountriesSubViewResponder.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@implementation CountriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize fillerGenreData = _fillerGenreData;
@synthesize fillerProgramTypeData = _fillerProgramTypeData;
@synthesize countriesSubView;
@synthesize countriesKKGridView;
@synthesize countryFetcher = _countryFetcher;
@synthesize countries;

@synthesize tableVC;

- (id)initWithNibNameAndCountries:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil countries:(NSArray *)Countries
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.countries = Countries;
    }
    return self;
}

- (void)viewDidLoad
{
    /*_fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedCountriesData) {
        countriesKKGridView = [[KKGridView alloc] initWithFrame:self.countriesSubView.bounds];
        countriesKKGridView.dataSource = self;
        countriesKKGridView.delegate = self;
        countriesKKGridView.scrollsToTop = YES;
        countriesKKGridView.backgroundColor = [UIColor clearColor];
        countriesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        countriesKKGridView.cellSize = CGSizeMake(108.f, 60.f);
        countriesKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        countriesKKGridView.allowsMultipleSelection = NO;
        countriesKKGridView.gridHeaderView = nil;
        countriesKKGridView.gridFooterView = nil;
        
        [self fillCountries];
    }*/
    
    self.tableVC=[[TableCountries alloc]initWithStyleAndCountries:UITableViewStylePlain countries:self.countries];
    [self.countriesSubView addSubview:self.tableVC.view];

}

#pragma mark - KKGridViewDataSource

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return 1;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    if(IsLoadingCountries)
        return [[_fillerData objectAtIndex:section] count];
    else if(IsLoadingGenres)
        return [[_fillerGenreData objectAtIndex:section] count];
    else if(IsLoadingProgramTypes)
        return [[_fillerProgramTypeData objectAtIndex:section] count];
    else
        return 0;
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKDemoCell *cell = nil;
    
    if(IsLoadingCountries)
    {
        Country *country = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
        cell = [[KKDemoCell cellForGridView:gridView] initWithCells:YES IsCountryGenreCell:NO IsCountryProgramTypeCell:NO IsGenreCell:NO SetIsGenreProgramTypeCell:NO];
        [cell.button setTitle:country.Title forState:UIControlStateNormal];
    }
    else if (IsLoadingGenres)
    {
        Genre *genre = [[_fillerGenreData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
        cell = [[KKDemoCell cellForGridView:gridView] initWithCells:NO IsCountryGenreCell:YES IsCountryProgramTypeCell:NO IsGenreCell:NO SetIsGenreProgramTypeCell:NO];
        [cell.button setTitle:@"" forState:UIControlStateNormal];
        [cell.button setTitle:genre.Title forState:UIControlStateNormal];
    }
    else
    {
        ProgramType *programtype = [[_fillerProgramTypeData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
        cell = [[KKDemoCell cellForGridView:gridView] initWithCells:NO IsCountryGenreCell:NO IsCountryProgramTypeCell:YES IsGenreCell:NO SetIsGenreProgramTypeCell:NO];
        [cell.button setTitle:programtype.Title forState:UIControlStateNormal];
    }
    
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    cell.delegate = self;
    cell.indexCellPath = indexPath;
    return cell;
}

-(void) fillCountries {
    if(!hasLoadedCountriesData) {
        [MBProgressHUD showHUDAddedTo:self.countriesSubView animated:YES];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        [RestService RequestCountries:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *countries, NSError *error)
         {
             if(countries != nil && error == nil)
             {
                 for (Country *country in countries) {
                     [array addObject:country];
                 }
                 [_fillerData addObject:array];
             }
             
             hasLoadedCountriesData = YES;
             hasLoadedGenresData = NO;
             hasLoadedProgramTypesData = NO;
             IsLoadingCountries = YES;
             IsLoadingGenres = NO;
             IsLoadingProgramTypes = NO;
             if([[self.countriesSubView subviews] count] > 0)
             {
                 for (UIView *subView in [self.countriesSubView subviews])
                 {
                     if ([subView isKindOfClass:[KKGridView class]])
                     {
                         [subView removeFromSuperview];
                     }               
                 }
             }
             [countriesKKGridView reloadData];
             [self.countriesSubView addSubview:countriesKKGridView];
             [MBProgressHUD hideHUDForView:self.countriesSubView animated:YES];
         }];
    }
}

- (void)fillGenres:(KKDemoCell *)cell;
{
    if(!hasLoadedGenresData) {
        [MBProgressHUD showHUDAddedTo:self.countriesSubView animated:YES];
        
        _fillerGenreData = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        Country *country = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)cell.indexCellPath.index];
        
        if(country != nil)
        {
            for (Genre *genre in country.genres) {
                [array addObject:genre];
            }
            [_fillerGenreData addObject:array];
        }
        
        hasLoadedCountriesData = NO;
        hasLoadedGenresData = YES;
        hasLoadedProgramTypesData = NO;
        IsLoadingGenres = YES;
        IsLoadingCountries = NO;
        IsLoadingProgramTypes = NO;
        
        [countriesKKGridView reloadData];
        [self.countriesSubView addSubview:countriesKKGridView];
        [MBProgressHUD hideHUDForView:self.countriesSubView animated:YES];
    }
}

- (void)fillProgramTypes:(KKDemoCell *)cell;
{
    if(!hasLoadedProgramTypesData) {
        [MBProgressHUD showHUDAddedTo:self.countriesSubView animated:YES];
        
        _fillerProgramTypeData = [[NSMutableArray alloc] init];
        NSMutableArray *array = [[NSMutableArray alloc] init];
        
        Genre *genre = [[_fillerGenreData objectAtIndex:0] objectAtIndex:(CGFloat)cell.indexCellPath.index];
        
        if(genre != nil)
        {
            for (ProgramType *programtype in genre.programTypes) {
                [array addObject:programtype];
            }
            [_fillerProgramTypeData addObject:array];
        }
        
        hasLoadedCountriesData = NO;
        hasLoadedGenresData = NO;
        hasLoadedProgramTypesData = YES;
        IsLoadingGenres = NO;
        IsLoadingCountries = NO;
        IsLoadingProgramTypes = YES;
        
        [countriesKKGridView reloadData];
        [self.countriesSubView addSubview:countriesKKGridView];
        [MBProgressHUD hideHUDForView:self.countriesSubView animated:YES];
    }
}

-(void) ReloadGenres:(KKDemoCell *)cell;
{
    
}

-(void) cancelCountryFetcher {
    if(_countryFetcher != nil) {
        [_countryFetcher cancelPendingRequest];
        _countryFetcher = nil;
    }
}

-(void) abortOperatons {
    [self cancelCountryFetcher];
}

-(void) forceReloadCountries {
    hasLoadedCountriesData = NO;
    [self cancelCountryFetcher];
    [self fillCountries];
}

@end
