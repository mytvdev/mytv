//
//  CountriesSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 9/21/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKDemoCell.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "TableCountries.h"

@interface CountriesSubViewResponder : UIViewController <MyKKDemoCellDelegate, KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedCountriesData;
    BOOL hasLoadedGenresData;
    BOOL hasLoadedProgramTypesData;
    BOOL IsLoadingCountries;
    BOOL IsLoadingGenres;
    BOOL IsLoadingProgramTypes;
}
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSMutableArray *fillerGenreData;
@property (nonatomic, strong) NSMutableArray *fillerProgramTypeData;
@property (nonatomic, strong) IBOutlet UIView *countriesSubView;
@property (nonatomic, strong) KKGridView *countriesKKGridView;
@property (readonly) DataFetcher *countryFetcher;

@property (strong, nonatomic) TableCountries *tableVC;

@end
