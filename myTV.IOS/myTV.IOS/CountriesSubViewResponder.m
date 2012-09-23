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
@synthesize countriesSubView;
@synthesize countriesKKGridView;
@synthesize countryFetcher = _countryFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedCountriesData) {
        countriesKKGridView = [[KKGridView alloc] initWithFrame:self.countriesSubView.bounds];
        countriesKKGridView.dataSource = self;
        countriesKKGridView.delegate = self;
        countriesKKGridView.scrollsToTop = YES;
        countriesKKGridView.backgroundColor = [UIColor clearColor];
        countriesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        countriesKKGridView.cellSize = CGSizeMake(108.f, 60.f);
        countriesKKGridView.cellPadding = CGSizeMake(0.f, 15.f);
        countriesKKGridView.allowsMultipleSelection = NO;
        countriesKKGridView.gridHeaderView = nil;
        countriesKKGridView.gridFooterView = nil;
        
        [self fillCountries];
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
    //cell.label.text = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    [cell.button setTitle:[[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index] forState:UIControlStateNormal];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
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
                     [array addObject:country.Title];
                 }
                 [_fillerData addObject:array];
             }
             [countriesKKGridView reloadData];
             [self.countriesSubView addSubview:countriesKKGridView];
             hasLoadedCountriesData = YES;
             [MBProgressHUD hideHUDForView:self.countriesSubView animated:YES];
         }];
    }
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
