//
//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
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
        categoriesKKGridView.cellSize = CGSizeMake(108.f, 40.f);
        categoriesKKGridView.cellPadding = CGSizeMake(0.f, 15.f);
        categoriesKKGridView.allowsMultipleSelection = NO;
        categoriesKKGridView.gridHeaderView = nil;
        categoriesKKGridView.gridFooterView = nil;
        
        [self fillGenres2];
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

-(void) fillGenres2 {
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

-(void) fillGenres {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *genres = [self RequestGenres:MyTV_RestServiceUrl];
    for (Genre *genre in genres) {
        [array addObject:genre.Title];
    }
    [_fillerData addObject:array];
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

-(NSData *)GetDataRS:(NSString *)url {
    DLog("%@", [NSString stringWithFormat:@"url is %@", url]);
    NSString *baseURLString = url;
    NSURL *urlD = [[NSURL alloc] initWithString:baseURLString];
    NSData *result = [[NSData alloc] initWithContentsOfURL:urlD];
    
    return result;
}

-(NSArray *)RequestGenres:(NSString *)baseUrl
{
    NSMutableArray* genres = [NSMutableArray new];
    NSError *error = nil;
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getgenres2&deviceid=%@&devicetypeid=%@", [[UIDevice currentDevice] uniqueDeviceIdentifier], MyTV_DeviceTypeId]];
    NSData *dataD = [self GetDataRS:requestUrl];
    DLog(@"Processing Data inside Code Block");
    if (error != NULL) {
        genres = [NSMutableArray new];
    }
    else {
        if(dataD == NULL) {
            genres = [NSMutableArray new];
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:dataD error:&error];
            if(error != NULL) {
                genres = [NSMutableArray new];
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                if(statusEl == NULL) {
                    DLog(@"No status element found in xml. Passing NULL parameters to callback");
                    genres = [NSMutableArray new];
                }
                else {
                    TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                    if(item != NULL) {
                        do {
                            Genre *genre = [Genre new];
                            TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                            TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                            TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                            if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"genre"] == NSOrderedSame) {
                                [genre setId:[[TBXML textForElement:xmlId] intValue]];
                                genre.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                genre.Logo = [TBXML textForElement:xmlThumbnail];
                                [genres addObject:genre];
                            }
                            item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                        } while (item != NULL);
                    }
                    
                    return genres;
                }
            }
        }
    }
    return genres;
}

@end
