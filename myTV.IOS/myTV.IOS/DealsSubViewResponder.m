//
//  DealsSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "DealsSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation DealsSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize vodPackagesKKGridView;
@synthesize vodPackagesView;
@synthesize vodPackagesFetcher = _vodPackagesFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedVODPackagesData) {
        vodPackagesKKGridView = [[KKGridView alloc] initWithFrame:CGRectMake(20, 20, 970, 550)];
        vodPackagesKKGridView.dataSource = self;
        vodPackagesKKGridView.delegate = self;
        vodPackagesKKGridView.scrollsToTop = YES;
        vodPackagesKKGridView.backgroundColor = [UIColor blackColor];
        vodPackagesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        vodPackagesKKGridView.cellSize = CGSizeMake(190.f, 185.f);
        vodPackagesKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        vodPackagesKKGridView.allowsMultipleSelection = NO;
        vodPackagesKKGridView.gridHeaderView = nil;
        vodPackagesKKGridView.gridFooterView = nil;
        
        [self fillVODPackages];
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
    KKVODPackageCell *cell = [KKVODPackageCell cellForGridView:gridView];
    VODPackage *vodPackage = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.vodPackage = vodPackage;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if([cell respondsToSelector:@selector(bindVODPackage:)])
        [cell performSelector:@selector(bindVODPackage:) withObject:vodPackage];
    return cell;
}

-(void) fillVODPackages {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.vodPackagesView animated:YES];
    [RestService RequestGetVODPackages:MyTV_RestServiceUrl ofBouquet:@"1" withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *vodPackages, NSError *error)
     {
         if(vodPackages != nil && error == nil)
         {
             for (VODPackage *vodPackage in vodPackages) {
                 [array addObject:vodPackage];
             }
             [_fillerData addObject:array];
         }
         [vodPackagesKKGridView reloadData];
         [self.vodPackagesView addSubview:vodPackagesKKGridView];
         hasLoadedVODPackagesData = YES;
         [MBProgressHUD hideHUDForView:self.vodPackagesView animated:NO];
     }];
}

@end
