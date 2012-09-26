//
//  DealsSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "KKVODPackageCell.h"

@interface DealsSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedVODPackagesData;
}

@property (readonly) DataFetcher *vodPackagesFetcher;
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) KKGridView *vodPackagesKKGridView;
@property (nonatomic, strong) IBOutlet UIView *vodPackagesView;

@end
