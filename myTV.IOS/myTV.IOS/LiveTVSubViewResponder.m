//
//  LiveTVSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "LiveTVSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation LiveTVSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize channelsKKGridView;
@synthesize channelsView;
@synthesize channelFetcher = _channelFetcher;

- (void)viewDidLoad
{
    [MBProgressHUD showHUDAddedTo:self.channelsView animated:YES];
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedChannelsData) {
        [self fillChannels2];
        
        
        channelsKKGridView = [[KKGridView alloc] initWithFrame:self.channelsView.bounds];
        channelsKKGridView.dataSource = self;
        channelsKKGridView.delegate = self;
        channelsKKGridView.scrollsToTop = YES;
        channelsKKGridView.backgroundColor = [UIColor clearColor];
        channelsKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        channelsKKGridView.cellSize = CGSizeMake(180.f, 180.f);
        channelsKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        channelsKKGridView.allowsMultipleSelection = NO;
        channelsKKGridView.gridHeaderView = nil;
        channelsKKGridView.gridFooterView = nil;
        
        [channelsKKGridView performSelectorOnMainThread:@selector(reloadData)
                                               withObject:nil
                                            waitUntilDone:NO];
        
        
        [self.channelsView addSubview:channelsKKGridView];
        hasLoadedChannelsData = YES;
    }
    [MBProgressHUD hideHUDForView:self.channelsView animated:YES];
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
    KKChannelCell *cell = [KKChannelCell cellForGridView:gridView];
    Channel *channel = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.channel = channel;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if([cell respondsToSelector:@selector(bindChannel:)]) {
        [cell performSelector:@selector(bindChannel:) withObject:channel];
    }
    return cell;
}

-(void) fillChannels2 {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    Linking *linking = [self SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId];
    if(linking != nil)
    {
        NSArray *channels = [self RequestGetSubscribedChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId];
        if (channels != nil){
            for (Channel *channel in channels) {
                [array addObject:channel];
            }
            [_fillerData addObject:array];
        }
    }
    else
    {
        NSArray *channels = [self RequestGetAllChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId];
        if (channels != nil){
            for (Channel *channel in channels) {
                [array addObject:channel];
            }
            [_fillerData addObject:array];
        }
    }
    
}

-(NSData *)GetDataRS:(NSString *)url {
    DLog("%@", [NSString stringWithFormat:@"url is %@", url]);
    NSString *baseURLString = url;
    NSURL *urlD = [[NSURL alloc] initWithString:baseURLString];
    NSData *result = [[NSData alloc] initWithContentsOfURL:urlD];
    
    return result;
}

-(Linking *)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId
{
    Linking* linking = [Linking new];
    NSError *error = nil;
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=linking&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    NSData *data = [self GetDataRS:linkingRequestUrl];
    
    //return [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            linking = nil;
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                linking = nil;
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                if(statusEl == NULL) {
                    DLog(@"No status element found in xml. Passing NULL parameters to callback");
                    linking = nil;
                }
                else {
                    NSString *status = [TBXML textForElement:statusEl];
                    if ([status compare:@"failure"] == NSOrderedSame) {
                        error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                        linking = nil;
                    }
                    else
                    {
                        Linking *object = [Linking new];
                        TBXMLElement *root = document.rootXMLElement;
                        TBXMLElement *customer = [TBXML childElementNamed:@"customer" parentElement:root];
                        if (customer == NULL) {
                            linking = nil;
                        }
                        else {
                            TBXMLElement *pin = [TBXML childElementNamed:@"PinCode" parentElement:customer];
                            TBXMLElement *customerid = [TBXML childElementNamed:@"Id" parentElement:customer];
                            TBXMLElement *billingid = [TBXML childElementNamed:@"BillingId" parentElement:customer];
                            if(pin != NULL)
                                object.PinCode = [ScanHelper getIntFromNSString:[TBXML textForElement:pin]];
                            if(customerid != NULL)
                                object.CustomerId = [ScanHelper getIntFromNSString:[TBXML textForElement:customerid]];
                            if(billingid != NULL)
                                object.BillingId = [ScanHelper getIntFromNSString:[TBXML textForElement:billingid]];
                            
                            linking = object;
                        }
                        
                    }
                }
                
            }
        }
    //}];
    return  linking;
}

-(NSArray *)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId
{
    NSArray* archannels = [NSArray new];
    NSError *error = nil;
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannels&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    NSData *data = [self GetDataRS:requestUrl];
    
    //return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
    DLog(@"Processing Data inside Code Block");
    if (error != NULL) {
        archannels = nil;
    }
    else {
        if(data == NULL) {
            archannels = nil;
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                archannels = nil;
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channels" parentElement:root];
                if(channelRootEl == NULL) {
                    DLog(@"No channels element found in response xml. Passing NULL parameters to callback");
                    archannels = nil;
                }
                else {
                    
                    NSMutableArray* channels = [NSMutableArray new];
                    
                    TBXMLElement *item = [TBXML childElementNamed:@"channel" parentElement:channelRootEl];
                    if(item != NULL) {
                        do {
                            Channel *channel = [Channel new];
                            TBXMLElement *xmlId = [TBXML childElementNamed:@"Id" parentElement:item];
                            TBXMLElement *xmlTitle = [TBXML childElementNamed:@"Name" parentElement:item];
                            TBXMLElement *xmlSmallDesc = [TBXML childElementNamed:@"SmallDescription" parentElement:item];
                            TBXMLElement *xmlBigDesc = [TBXML childElementNamed:@"BigDescription" parentElement:item];
                            TBXMLElement *xmlSmallLogo = [TBXML childElementNamed:@"SmallLogoPath" parentElement:item];
                            TBXMLElement *xmlBigLogo = [TBXML childElementNamed:@"BigLogoPath" parentElement:item];
                            TBXMLElement *xmlStartDate = [TBXML childElementNamed:@"StartDate" parentElement:item];
                            TBXMLElement *xmlEndDate = [TBXML childElementNamed:@"EndDate" parentElement:item];
                            
                            [channel setId:[[TBXML textForElement:xmlId] intValue]];
                            [channel setName:[TBXML textForElement:xmlTitle]];
                            [channel setBigDescription:[TBXML textForElement:xmlBigDesc]];
                            [channel setSmallDescription:[TBXML textForElement:xmlSmallDesc]];
                            [channel setStartDate:[TBXML textForElement:xmlStartDate]];
                            [channel setEndDate:[TBXML textForElement:xmlEndDate]];
                            [channel setSmallLogo:[TBXML textForElement:xmlSmallLogo]];
                            [channel setBigLogo:[TBXML textForElement:xmlBigLogo]];
                            [channels addObject:channel];
                            item = [TBXML nextSiblingNamed:@"channel" searchFromElement:item];
                        } while (item != NULL);
                    }
                    
                    archannels = channels;
                    
                }
                
            }
        }
    }
    //}];
    return archannels;
}

-(NSArray *)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId
{
    NSArray* archannels = [NSArray new];
    NSError *error = nil;
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannel&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    NSData *data = [self GetDataRS:requestUrl];
    
    //return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
    DLog(@"Processing Data inside Code Block");
    if (error != NULL) {
        archannels = nil;
    }
    else {
        if(data == NULL) {
            archannels = nil;
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                archannels = nil;
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                if(channelRootEl == NULL) {
                    DLog(@"No channels element found in response xml. Passing NULL parameters to callback");
                    archannels = nil;
                }
                else {
                    
                    NSMutableArray* channels = [NSMutableArray new];
                    
                    TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:channelRootEl];
                    if(item != NULL) {
                        do {
                            Channel *channel = [Channel new];
                            TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
                            TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
                            TBXMLElement *xmlDescription = [TBXML childElementNamed:@"description" parentElement:item];
                            TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
                            TBXMLElement *xmlStartDate = [TBXML childElementNamed:@"StartDate" parentElement:item];
                            TBXMLElement *xmlEndDate = [TBXML childElementNamed:@"EndDate" parentElement:item];
                            
                            [channel setId:[[TBXML textForElement:xmlId] intValue]];
                            [channel setName:[TBXML textForElement:xmlTitle]];
                            [channel setBigDescription:[TBXML textForElement:xmlDescription]];
                            [channel setSmallDescription:[TBXML textForElement:xmlDescription]];
                            [channel setStartDate:[TBXML textForElement:xmlStartDate]];
                            [channel setEndDate:[TBXML textForElement:xmlEndDate]];
                            [channel setSmallLogo:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                            [channel setBigLogo:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                            [channels addObject:channel];
                            item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
                        } while (item != NULL);
                    }
                    
                    archannels = channels;
                }
                
            }
        }
    }
    //}];
    return archannels;
}

-(void) fillChannels {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.channelsView animated:YES];
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error){
        if(linking != nil && error == nil) {
            _channelFetcher = [RestService RequestGetSubscribedChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *channels, NSError *error)
                               {
                                   if(channels != nil && error == nil)
                                   {
                                       for (Channel *channel in channels) {
                                           [array addObject:channel.Name];
                                       }
                                       [_fillerData addObject:array];
                                   }
                               }];
        }
        else {
            _channelFetcher = [RestService RequestGetAllChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *channels, NSError *error)
                               {
                                   if(channels != nil && error == nil)
                                   {
                                       for (Channel *channel in channels) {
                                           [array addObject:channel.Name];
                                       }
                                       [_fillerData addObject:array];
                                   }
                               }];
        }
        [MBProgressHUD hideHUDForView:self.channelsView animated:YES];
    }];
}

@end
