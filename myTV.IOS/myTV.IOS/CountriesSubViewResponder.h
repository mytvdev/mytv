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

@interface CountriesSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedCountriesData;
}
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) IBOutlet UIView *countriesSubView;
@property (nonatomic, strong) KKGridView *countriesKKGridView;
@property (readonly) DataFetcher *countryFetcher;

@end
