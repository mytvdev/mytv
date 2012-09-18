//
//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "CategoriesSubViewResponder.h"
#import "TBXML.h"

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize categoriesSubView;
@synthesize categoriesKKGridView;
@synthesize genreFetcher = _genreFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    //NSMutableArray *array = [[NSMutableArray alloc] init];
    //for (NSUInteger j = 1; j <= 10; j++)
   //{
   //     [array addObject:[NSString stringWithFormat:@"%u", j]];
   // }
    
    //[_fillerData addObject:array];
    
    if(!hasLoadedGenresData) {        
        [self fillGenres];
    
    
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
        
        [categoriesKKGridView performSelectorOnMainThread:@selector(reloadData)
                                         withObject:nil
                                      waitUntilDone:NO];
        

        [self.categoriesSubView addSubview:categoriesKKGridView];
        hasLoadedGenresData = YES;
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

//- (NSString *)gridView:(KKGridView *)gridView titleForHeaderInSection:(NSUInteger)section
//{
//    return [NSString stringWithFormat:@"%u", section + 1];
//}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKDemoCell *cell = [KKDemoCell cellForGridView:gridView];
    cell.label.text = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //CGFloat percentage = (CGFloat)indexPath.index / (CGFloat)[[_fillerData objectAtIndex:indexPath.section] count];
    //cell.contentView.backgroundColor = [UIColor colorWithWhite:percentage alpha:1.f];
    return cell;
}

-(void) fillGenres {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *genres = [self RequestGenres:MyTV_RestServiceUrl];
    //NSArray *genres = [RestService RequestGenresWithNoCallback:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId];
    //
    for (Genre *genre in genres) {
        [array addObject:genre.Title];
    }
    [_fillerData addObject:array];
}

-(void) cancelGenreFetcher {
    if(_genreFetcher != nil) {
        //if(_genreFetcher.hasFinishedLoading) hasLoadedChannelData = YES;
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
    
    //NSURLResponse* response = nil;
    //NSData* data = [NSURLConnection sendSynchronousRequest:[NSURL URLWithString:url] returningResponse:&response error:nil];
    
    //NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    //NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
    
    //NSMutableData *receiveData = nil;
    //if (theConnection) {
    //    receiveData = [NSMutableData data];
    //}
    
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
    //NSMutableArray *data = [[NSMutableArray alloc] initWithCapacity:10];
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
