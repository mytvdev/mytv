//
//  RestService.m
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/23/12.
//
//

#import "RestService.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation RestService


+(DataFetcher *)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback {
    
    return [self SendLinkingRequest:baseUrl withDeviceId:deviceId andDeviceTypeId:deviceTypeId usingCallback:callback synchronous:NO];
    
}

+(DataFetcher *)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback synchronous:(BOOL)sync {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=linking&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:linkingRequestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                callback(NULL, error);
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                if(statusEl == NULL) {
                    DLog(@"No status element found in xml. Passing NULL parameters to callback");
                    callback(NULL, NULL);
                }
                else {
                    NSString *status = [TBXML textForElement:statusEl];
                    if ([status compare:@"failure"] == NSOrderedSame) {
                        error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                        callback(NULL, error);
                    }
                    else
                    {
                        Linking *object = [Linking new];
                        TBXMLElement *root = document.rootXMLElement;
                        TBXMLElement *customer = [TBXML childElementNamed:@"customer" parentElement:root];
                        if (customer == NULL) {
                            callback(NULL, NULL);
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
                            callback(object, NULL);
                            
                        }
                        
                    }
                }
                
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetVODUrl:(NSString *)baseUrl ofVideo:(NSString *)videoId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVodUrlCallBack)callback {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=watchvod&deviceid=%@&devicetypeid=%@&episodeid=%@", deviceId, deviceTypeId, videoId]];
    
    return [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            TBXMLElement *root = document.rootXMLElement;
                            TBXMLElement *url = [TBXML childElementNamed:@"URL" parentElement:root];
                            if (url == NULL) {
                                callback(NULL, NULL);
                            }
                            else {
                                NSString* playurl =  [TBXML textForElement:url];
                                callback(playurl, NULL);
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetChannelUrl:(NSString *)baseUrl ofChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelURlCallback)callback{
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=watchchannel&deviceid=%@&devicetypeid=%@&channelid=%@", deviceId, deviceTypeId, channelId]];
    
    return [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            TBXMLElement *url = [TBXML childElementNamed:@"URL" parentElement:root];
                            if (url == NULL) {
                                callback(NULL, NULL);
                            }
                            else {
                                NSString* playurl =  [TBXML textForElement:url];
                                callback(playurl, NULL);
                            }
                            
                        }
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetProgramEpisodesUrls:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramUrlsCallBack)callback {
    
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=GetVODToWatchFromProgram&deviceid=%@&devicetypeid=%@&ProgramId=%@", deviceId, deviceTypeId, programId]];
    
    return [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            NSMutableArray* urls = [NSMutableArray new];
                            
                            TBXMLElement *urlEl = [TBXML childElementNamed:@"URL" parentElement:root];
                            if(urlEl != NULL) {
                                do {
                                    NSString* url = [TBXML textForElement:urlEl];
                                    [urls addObject:url];
                                    urlEl = [TBXML nextSiblingNamed:@"URL" searchFromElement:urlEl];
                                } while (urlEl != NULL);
                            }
                            
                            callback([NSArray arrayWithArray:urls], NULL);
                            
                        }
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback {
    return  [self RequestGetAllChannels:baseUrl withDeviceId:deviceId andDeviceTypeId:deviceTypeId usingCallback:callback synchronous:NO];
}

+(DataFetcher *)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback synchronous:(BOOL)sync {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannel&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
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
                        
                        callback([NSArray arrayWithArray:channels], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    return [self RequestGetSubscribedChannels:baseUrl withDeviceId:deviceId andDeviceTypeId:deviceTypeId usingCallback:callback synchronous:NO];
}

+(DataFetcher *)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback synchronous:(BOOL)sync {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannels&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channels" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channels element found in response xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
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
                        
                        callback([NSArray arrayWithArray:channels], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetChannels:(NSString *)baseUrl ofPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getmytvchannels&deviceid=%@&devicetypeid=%@&packageid=%@", deviceId, deviceTypeId, packageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
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
                        
                        callback([NSArray arrayWithArray:channels], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}


+(DataFetcher *)RequestGetChannels:(NSString *)baseUrl ofVODPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackagecontent&contenttypeid=3&deviceid=%@&devicetypeid=%@&vodpackageid=%@", deviceId, deviceTypeId, packageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
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
                        
                        callback([NSArray arrayWithArray:channels], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetPreregistrationCode:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPreregistrationCode)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=preregistration&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            TBXMLElement *root = document.rootXMLElement;
                            TBXMLElement *regCode = [TBXML childElementNamed:@"regCode" parentElement:root];
                            if (regCode == NULL) {
                                callback(NULL, NULL);
                            }
                            else {
                                NSString* regcodevalue =  [TBXML textForElement:regCode];
                                callback(regcodevalue, NULL);
                            }
                        }
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetVODPackages:(NSString *)baseUrl ofBouquet:(NSString *)bouquetId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackage&deviceid=%@&devicetypeid=%@&BouquetId=%@", deviceId, deviceTypeId, bouquetId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* vodpackages = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:channelRootEl];
                        if(item != NULL) {
                            do {
                                
                                VODPackage *vodpackage = [VODPackage new];
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
                                TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
                                TBXMLElement *xmlDescription = [TBXML childElementNamed:@"description" parentElement:item];
                                TBXMLElement *xmlPrice = [TBXML childElementNamed:@"Price" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
                                TBXMLElement *xmlStartDate = [TBXML childElementNamed:@"StartDate" parentElement:item];
                                TBXMLElement *xmlEndDate = [TBXML childElementNamed:@"EndDate" parentElement:item];
                                TBXMLElement *xmlVODPackageType = [TBXML childElementNamed:@"VODPackageTypeId" parentElement:item];
                                
                                [vodpackage setId:[[TBXML textForElement:xmlId] intValue]];
                                [vodpackage setTitle:[TBXML textForElement:xmlTitle]];
                                [vodpackage setDescription:[TBXML textForElement:xmlDescription]];
                                [vodpackage setPrice:[TBXML textForElement:xmlPrice]];
                                [vodpackage setStartDate:[TBXML textForElement:xmlStartDate]];
                                [vodpackage setEndDate:[TBXML textForElement:xmlEndDate]];
                                [vodpackage setThumbnail:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                                [vodpackage setVODPackageTypeId:[TBXML textForElement:xmlVODPackageType]];
                                
                                [vodpackages addObject:vodpackage];
                                item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:vodpackages], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}

+(DataFetcher *)RequestGetVODPackageChannels:(NSString *)baseUrl ofVODPackageId:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannel)callback
{
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackagecontent&contenttypeid=3&deviceid=%@&devicetypeid=%@&vodpackageid=%@", deviceId, deviceTypeId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetVODPackagePrograms:(NSString *)baseUrl ofVODPackageId:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback
{
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackagecontent&contenttypeid=2&deviceid=%@&devicetypeid=%@&vodpackageid=%@", deviceId, deviceTypeId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];}

+(DataFetcher *)RequestGetVODPackage:(NSString *)baseUrl withVODPackageId:(NSString *)vodPackageId ofBouquet:(NSString *)bouquetId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVODPackage)callback
{
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackage&deviceid=%@&devicetypeid=%@&BouquetId=%@&vodpackageId=%@", deviceId, deviceTypeId, bouquetId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        //NSMutableArray* vodpackages = [NSMutableArray new];
                        VODPackage *vodpackage = [VODPackage new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:channelRootEl];
                        if(item != NULL) {
                            do {
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
                                TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
                                TBXMLElement *xmlDescription = [TBXML childElementNamed:@"description" parentElement:item];
                                TBXMLElement *xmlPrice = [TBXML childElementNamed:@"Price" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
                                TBXMLElement *xmlStartDate = [TBXML childElementNamed:@"StartDate" parentElement:item];
                                TBXMLElement *xmlEndDate = [TBXML childElementNamed:@"EndDate" parentElement:item];
                                TBXMLElement *xmlVODPackageType = [TBXML childElementNamed:@"VODPackageTypeId" parentElement:item];
                                
                                [vodpackage setId:[[TBXML textForElement:xmlId] intValue]];
                                [vodpackage setTitle:[TBXML textForElement:xmlTitle]];
                                [vodpackage setDescription:[TBXML textForElement:xmlDescription]];
                                [vodpackage setPrice:[TBXML textForElement:xmlPrice]];
                                [vodpackage setStartDate:[TBXML textForElement:xmlStartDate]];
                                [vodpackage setEndDate:[TBXML textForElement:xmlEndDate]];
                                [vodpackage setThumbnail:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                                [vodpackage setVODPackageTypeId:[TBXML textForElement:xmlVODPackageType]];
                                
                                //[vodpackages addObject:vodpackage];
                                //item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
                                item = NULL;
                            } while (item != NULL);
                        }
                        
                        callback(vodpackage, NULL);
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetMyVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    return [self RequestGetMyVOD:baseUrl withDeviceId:deviceId andDeviceTypeId:deviceTypeId usingCallback:callback synchronous:NO];
}

+(DataFetcher *)RequestGetMyVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback synchronous:(BOOL)sync {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=myvod&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];
}

+(void)ProcessVideoItemsTags:(TBXMLElement *)root usingCallBack:(void(^)(id, id))callback onlyFirstElement:(BOOL)onlyFirst {
    TBXMLElement *itemsRoot = [TBXML childElementNamed:@"channel" parentElement:root];
    if(itemsRoot == NULL) {
        DLog(@"No VOD items root found in xml. Passing NULL parameters to callback");
        callback(NULL, NULL);
    }
    else {
        
        NSMutableArray* videos = [NSMutableArray new];
        
        TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:itemsRoot];
        if(item != NULL) {
            do {
                id video = [RestService GetVideoItem:item];
                if(video != NULL) {
                    [videos addObject:video];
                }
                item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
            } while (item != NULL);
        }
        if(onlyFirst == YES) {
            if(videos.count > 0) {
                callback([videos objectAtIndex:0], NULL);
            }
            else {
                callback(NULL, NULL);
            }
        }
        else {
            callback([NSArray arrayWithArray:videos], NULL);
        }
        
    }
}

+(NSObject *)GetVideoItem:(TBXMLElement *)item {
    
    TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
    TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
    TBXMLElement *xmlDescription = [TBXML childElementNamed:@"description" parentElement:item];
    TBXMLElement *xmlPrice = [TBXML childElementNamed:@"Price" parentElement:item];
    TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
    TBXMLElement *xmlDirector = [TBXML childElementNamed:@"Director" parentElement:item];
    TBXMLElement *xmlGuests = [TBXML childElementNamed:@"Guests" parentElement:item];
    TBXMLElement *xmlCategory = [TBXML childElementNamed:@"category" parentElement:item];
    TBXMLElement *xmlRating = [TBXML childElementNamed:@"Rating" parentElement:item];
    TBXMLElement *xmlLanguage = [TBXML childElementNamed:@"language" parentElement:item];
    TBXMLElement *xmlProgramPurchased = [TBXML childElementNamed:@"PackagePurchased" parentElement:item];
    TBXMLElement *xmlCanBuyEpisode = [TBXML childElementNamed:@"CanBuyEpisode" parentElement:item];
    TBXMLElement *xmlProgramTitle = [TBXML childElementNamed:@"ProgramTitle" parentElement:item];
    TBXMLElement *xmlProgramId = [TBXML childElementNamed:@"ProgramId" parentElement:item];
    
    NSString *type = [TBXML textForElement:[TBXML childElementNamed:@"type" parentElement:item]];
    
    if([type compare:@"video" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        Episode *video = [Episode new];
        [video setId:[[TBXML textForElement:xmlId] intValue]];
        video.Title = [TBXML textForElement:xmlTitle];
        video.Description = [TBXML textForElement:xmlDescription];
        video.Price = [TBXML textForElement:xmlPrice];
        video.Thumbnail = [TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail];
        video.Director = [TBXML textForElement:xmlDirector];
        video.Guest = [TBXML textForElement:xmlGuests];
        video.Category = [TBXML textForElement:xmlCategory];
        video.Rating = [TBXML textForElement:xmlRating];
        video.Language = [TBXML textForElement:xmlLanguage];
        video.CanBuyEpisode = [TBXML textForElement:xmlCanBuyEpisode];
        video.ProgramTitle = [TBXML textForElement:xmlProgramTitle];
        if(xmlProgramId != nil) video.ProgramId = [TBXML textForElement:xmlProgramId];
        return video;
    }
    else if([type compare:@"program" options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        MyTVProgram *video = [MyTVProgram new];
        [video setId:[[TBXML textForElement:xmlId] intValue]];
        video.Title = [TBXML textForElement:xmlTitle];
        video.Description = [TBXML textForElement:xmlDescription];
        video.Price = [TBXML textForElement:xmlPrice];
        video.Thumbnail = [TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail];
        video.Director = [TBXML textForElement:xmlDirector];
        video.Guest = [TBXML textForElement:xmlGuests];
        video.Category = [TBXML textForElement:xmlCategory];
        video.Rating = [TBXML textForElement:xmlRating];
        video.Language = [TBXML textForElement:xmlLanguage];
        video.ProgramPrice = video.Price;
        video.ProgramPurchased = [TBXML textForElement:xmlProgramPurchased];
        
        return video;
    }
    else {
        return NULL;
    }
    
}

+(DataFetcher *)RequestGetVOD:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getepisodes&deviceid=%@&devicetypeid=%@&programid=%@", deviceId, deviceTypeId, programId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetVODEpisodes:(NSString *)baseUrl ofVODPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getepisodes&deviceid=%@&devicetypeid=%@&vodpackageid=%@&contenttypeid=2", deviceId, deviceTypeId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetVODPrograms:(NSString *)baseUrl ofVODPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getepisodes&deviceid=%@&devicetypeid=%@&vodpackageid=%@&contenttypeid=1", deviceId, deviceTypeId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:NO];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetFeaturedVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getfeatured&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSMutableArray* vods = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                if(xmlpostertype != NULL) {
                                    
                                    
                                    
                                    if([[TBXML textForElement:xmlpostertype] compare:@"program"] == NSOrderedSame) {
                                        MyTVProgram *program = [[MyTVProgram alloc] init];
                                        [program setId:[[TBXML textForElement:xmlId] intValue]];
                                        program.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                        program.Logo = [TBXML textForElement:xmlThumbnail];
                                        [vods addObject:program];
                                    }
                                    else {
                                        Episode *episode = [[Episode alloc] init];
                                        [episode setId:[[TBXML textForElement:xmlId] intValue]];
                                        episode.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                        episode.Logo = [TBXML textForElement:xmlThumbnail];
                                        [vods addObject:episode];
                                    }
                                    
                                }
                                
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:vods], NULL);
                        
                    }
                }
                
                
            }
        }
    }];
}

+(DataFetcher *)RequestGetNewReleasesVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getnewreleases&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSMutableArray* vods = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                if(xmlpostertype != NULL) {
                                    
                                    
                                    
                                    if([[TBXML textForElement:xmlpostertype] compare:@"program"] == NSOrderedSame) {
                                        MyTVProgram *program = [[MyTVProgram alloc] init];
                                        [program setId:[[TBXML textForElement:xmlId] intValue]];
                                        program.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                        program.Logo = [TBXML textForElement:xmlThumbnail];
                                        [vods addObject:program];
                                    }
                                    else {
                                        Episode *episode = [[Episode alloc] init];
                                        [episode setId:[[TBXML textForElement:xmlId] intValue]];
                                        episode.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                        episode.Logo = [TBXML textForElement:xmlThumbnail];
                                        [vods addObject:episode];
                                    }
                                    
                                }
                                
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:vods], NULL);
                        
                    }
                }
                
                
            }
        }
    }];
}

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisEpisode:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=canplayepisode&deviceid=%@&devicetypeid=%@&episodeid=%@", deviceId, deviceTypeId, episodeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(FALSE, error);
        }
        else {
            if(data == NULL) {
                callback(FALSE, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(FALSE, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(FALSE, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(FALSE, error);
                        }
                        else
                        {
                            TBXMLElement *canplayEl = [TBXML childElementNamed:@"CanPlayEpisode" parentElement:root];
                            if (canplayEl == NULL) {
                                callback(FALSE, NULL);
                            }
                            else {
                                NSString* canplay =  [TBXML textForElement:canplayEl];
                                callback([canplay boolValue], NULL);
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=canplayepisode&deviceid=%@&devicetypeid=%@&programid=%@", deviceId, deviceTypeId, programId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(FALSE, error);
        }
        else {
            if(data == NULL) {
                callback(FALSE, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(FALSE, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(FALSE, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(FALSE, error);
                        }
                        else
                        {
                            TBXMLElement *canplayEl = [TBXML childElementNamed:@"CanPlayProgram" parentElement:root];
                            if (canplayEl == NULL) {
                                callback(FALSE, NULL);
                            }
                            else {
                                NSString* canplay =  [TBXML textForElement:canplayEl];
                                callback([canplay boolValue], NULL);
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=canplayepisode&deviceid=%@&devicetypeid=%@&channelid=%@", deviceId, deviceTypeId, channelId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(FALSE, error);
        }
        else {
            if(data == NULL) {
                callback(FALSE, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(FALSE, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(FALSE, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(FALSE, error);
                        }
                        else
                        {
                            TBXMLElement *canplayEl = [TBXML childElementNamed:@"CanPlayChannel" parentElement:root];
                            if (canplayEl == NULL) {
                                callback(FALSE, NULL);
                            }
                            else {
                                NSString* canplay =  [TBXML textForElement:canplayEl];
                                callback([canplay boolValue], NULL);
                            }
                            
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisEpisode:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback {
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=isvodpurchased&deviceid=%@&devicetypeid=%@&episodeid=%@", deviceId, deviceTypeId, episodeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            PurchaseInformation *info = [PurchaseInformation new];
                            TBXMLElement *isvodel = [TBXML childElementNamed:@"IsVODPurchased" parentElement:root];
                            TBXMLElement *expiryel = [TBXML childElementNamed:@"ExpiryDate" parentElement:root];
                            info.isPurchased = [[TBXML textForElement:isvodel] boolValue];
                            info.expiryDate = [ScanHelper getDateFromNSString:[TBXML textForElement:expiryel]];
                            callback(info, NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=isprogrampurchased&deviceid=%@&devicetypeid=%@&programid=%@", deviceId, deviceTypeId, programId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            PurchaseInformation *info = [PurchaseInformation new];
                            TBXMLElement *isvodel = [TBXML childElementNamed:@"IsProgramPurchased" parentElement:root];
                            TBXMLElement *expiryel = [TBXML childElementNamed:@"ExpiryDate" parentElement:root];
                            info.isPurchased = [[TBXML textForElement:isvodel] boolValue];
                            info.expiryDate = [ScanHelper getDateFromNSString:[TBXML textForElement:expiryel]];
                            callback(info, NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisVodPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=isvodpackagepurchased&deviceid=%@&devicetypeid=%@&vodpackageid=%@", deviceId, deviceTypeId, vodPackageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                            callback(NULL, error);
                        }
                        else
                        {
                            PurchaseInformation *info = [PurchaseInformation new];
                            TBXMLElement *isvodel = [TBXML childElementNamed:@"IsVODPackagePurchased" parentElement:root];
                            TBXMLElement *expiryel = [TBXML childElementNamed:@"ExpiryDate" parentElement:root];
                            info.isPurchased = [[TBXML textForElement:isvodel] boolValue];
                            info.expiryDate = [ScanHelper getDateFromNSString:[TBXML textForElement:expiryel]];
                            callback(info, NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)BuyRequest:(NSString *)baseUrl Package:(NSString *)packageId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=buypackage&deviceid=%@&devicetypeid=%@&billingid=%@&packageid=%@", deviceId, deviceTypeId, billingId, packageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            TBXMLElement *message = [TBXML childElementNamed:@"AuthenticationMessage" parentElement:root];
                            if(message != NULL) {
                                callback([TBXML textForElement:message], NULL);
                            }
                            else {
                                callback(NULL, NULL);
                            }
                        }
                        else
                        {
                            callback(@"success", NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)BuyRequest:(NSString *)baseUrl VODPackage:(NSString *)packageId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=buyvodpackage&deviceid=%@&devicetypeid=%@&billingid=%@&vodpackageid=%@", deviceId, deviceTypeId, billingId, packageId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            TBXMLElement *message = [TBXML childElementNamed:@"AuthenticationMessage" parentElement:root];
                            if(message != NULL) {
                                callback([TBXML textForElement:message], NULL);
                            }
                            else {
                                callback(NULL, NULL);
                            }
                        }
                        else
                        {
                            callback(@"success", NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}


+(DataFetcher *)BuyRequest:(NSString *)baseUrl Program:(NSString *)programId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=buyprogram&deviceid=%@&devicetypeid=%@&billingid=%@&programid=%@", deviceId, deviceTypeId, billingId, programId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            TBXMLElement *message = [TBXML childElementNamed:@"AuthenticationMessage" parentElement:root];
                            if(message != NULL) {
                                callback([TBXML textForElement:message], NULL);
                            }
                            else {
                                callback(NULL, NULL);
                            }
                        }
                        else
                        {
                            callback(@"success", NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)BuyRequest:(NSString *)baseUrl VOD:(NSString *)episodeId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=buyvod&deviceid=%@&devicetypeid=%@&billingid=%@&episodeid=%@", deviceId, deviceTypeId, billingId, episodeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        NSString *status = [TBXML textForElement:statusEl];
                        if ([status compare:@"failure"] == NSOrderedSame) {
                            TBXMLElement *message = [TBXML childElementNamed:@"AuthenticationMessage" parentElement:root];
                            if(message != NULL) {
                                callback([TBXML textForElement:message], NULL);
                            }
                            else {
                                callback(NULL, NULL);
                            }
                        }
                        else
                        {
                            callback(@"success", NULL);
                        }
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetEpisode:(NSString *)baseUrl ofId:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetEpisode)callback {
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getepisode&deviceid=%@&devicetypeid=%@&id=%@", deviceId, deviceTypeId, episodeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:YES];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetProgram:(NSString *)baseUrl ofId:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgram)callback {
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getprogram&deviceid=%@&devicetypeid=%@&id=%@", deviceId, deviceTypeId, programId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback onlyFirstElement:YES];
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGenres:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getgenres2&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        Genre *genre;
                        
                        NSMutableArray* genres = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                TBXMLElement *xmlProgramTypes = [TBXML childElementNamed:@"category" parentElement:item];
                                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"genre"] == NSOrderedSame)
                                {
                                    genre = [Genre new];
                                    
                                    [genre setId:[[TBXML textForElement:xmlId] intValue]];
                                    genre.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                    genre.Logo = [TBXML textForElement:xmlThumbnail];
                                    genre.Description = [TBXML textForElement:xmlProgramTypes];
                                    genre.programTypes = [RestService FetchGenreProgramTypes:xmlProgramTypes];
                                    [genres addObject:genre];
                                }
                                
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:genres], NULL);
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGenres:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback  synchronous:(BOOL)sync
{
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getgenres2&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    return [DataFetcher Get:requestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        Genre *genre;
                        
                        NSMutableArray* genres = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                TBXMLElement *xmlProgramTypes = [TBXML childElementNamed:@"category" parentElement:item];
                                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"genre"] == NSOrderedSame)
                                {
                                    genre = [Genre new];
                                    
                                    [genre setId:[[TBXML textForElement:xmlId] intValue]];
                                    genre.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                    genre.Logo = [TBXML textForElement:xmlThumbnail];
                                    genre.Description = [TBXML textForElement:xmlProgramTypes];
                                    genre.programTypes = [RestService FetchGenreProgramTypes:xmlProgramTypes];
                                    [genres addObject:genre];
                                }
                                
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:genres], NULL);
                    }
                }
            }
        }
    }];
}

+(NSMutableArray *)FetchGenreProgramTypes:(TBXMLElement *)element
{
    NSMutableArray* programtypes = [NSMutableArray new];
    ProgramType *programtype;
    
    if(element != NULL)
    {
        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:element];
        if (item != NULL) {
            do {
                
                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                TBXMLElement *xmlPrograms = [TBXML childElementNamed:@"category" parentElement:item];
                
                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"programtype"] == NSOrderedSame)
                {
                    programtype = [ProgramType new];
                    [programtype setId:[[TBXML textForElement:xmlId] intValue]];
                    programtype.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                    programtype.Logo = [TBXML textForElement:xmlThumbnail];
                    programtype.programs = [RestService FetchProgramTypePrograms:xmlPrograms];
                    [programtypes addObject:programtype];
                }
                
                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
            } while (item != NULL);
        }
    }
    
    return programtypes;
}

+(NSMutableArray *)FetchProgramTypePrograms:(TBXMLElement *)element
{
    NSMutableArray* programs = [NSMutableArray new];
    MyTVProgram *program;
    Episode *episode;
    
    if(element != NULL)
    {
        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:element];
        if (item != NULL) {
            do {
                
                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                
                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"program"] == NSOrderedSame)
                {
                    program = [MyTVProgram new];
                    [program setId:[[TBXML textForElement:xmlId] intValue]];
                    program.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                    program.Logo = [TBXML textForElement:xmlThumbnail];
                    program.Thumbnail = [TBXML textForElement:xmlThumbnail];
                    [programs addObject:program];
                }
                else if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"episode"] == NSOrderedSame)
                {
                    episode = [Episode new];
                    [episode setId:[[TBXML textForElement:xmlId] intValue]];
                    episode.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                    episode.Logo = [TBXML textForElement:xmlThumbnail];
                    episode.Thumbnail = [TBXML textForElement:xmlThumbnail];
                    [programs addObject:episode];
                }
                
                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
            } while (item != NULL);
        }
    }
    
    return programs;
}

+(DataFetcher *)RequestProgramTypes:(NSString *)baseUrl ofGenre:(NSString *)genreId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getgenres2&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* programtypes = [NSMutableArray new];
                        BOOL foundGenre = NO;

                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                NSString *thisGenreId = [TBXML textForElement:[TBXML childElementNamed:@"playlist" parentElement:item]];
                                DLog("Checking genre id: %@", thisGenreId);
                                if([thisGenreId compare:genreId] == NSOrderedSame) {
                                    DLog(@"Inside Genre");
                                    foundGenre = YES;
                                    TBXMLElement *category = [TBXML childElementNamed:@"category" parentElement:item];
                                    if(category != NULL) {
                                        TBXMLElement *pgitem = [TBXML childElementNamed:@"poster" parentElement:category];
                                        if(pgitem != NULL) {
                                            do {
                                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:pgitem];
                                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:pgitem];
                                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:pgitem];
                                                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"programtype"] == NSOrderedSame) {
                                                    ProgramType *pt = [ProgramType new];
                                                    [pt setId:[[TBXML textForElement:xmlId] intValue]];
                                                    pt.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:pgitem];
                                                    pt.Logo = [TBXML textForElement:xmlThumbnail];
                                                    pt.genreId = thisGenreId;
                                                    [programtypes addObject:pt];
                                                }
                                                
                                                pgitem = [TBXML nextSiblingNamed:@"poster" searchFromElement:pgitem];
                                            }
                                            while(pgitem != NULL);
                                        }
                                    }
                                    
                                }
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL && foundGenre == NO);
                        }
                        
                        callback([NSArray arrayWithArray:programtypes], NULL);
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestGetPackages:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramTypes)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getmytvpackages&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"channel" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channel element found in rss xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* packages = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"item" parentElement:channelRootEl];
                        if(item != NULL) {
                            do {
                                
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
                                TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
                                TBXMLElement *xmlDescription = [TBXML childElementNamed:@"description" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
                                TBXMLElement *xmlStartDate = [TBXML childElementNamed:@"StartDate" parentElement:item];
                                TBXMLElement *xmlEndDate = [TBXML childElementNamed:@"EndDate" parentElement:item];
                                TBXMLElement *xmlType = [TBXML childElementNamed:@"type" parentElement:item];
                                if([[TBXML textForElement:xmlType] compare:@"livepackage"] == NSOrderedSame){
                                    MyTVPackage *package = [MyTVPackage new];
                                    [package setId:[TBXML textForElement:xmlId]];
                                    [package setTitle:[TBXML textForElement:xmlTitle]];
                                    [package setDescription:[TBXML textForElement:xmlDescription]];
                                    if(xmlStartDate != NULL) [package setStartDate:[TBXML textForElement:xmlStartDate]];
                                    if(xmlEndDate != NULL) [package setEndDate:[TBXML textForElement:xmlEndDate]];
                                    [package setThumbnail:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                                    [packages addObject:package];
                                }
                                else {
                                    VODPackage *package = [VODPackage new];
                                    [package setId:[[TBXML textForElement:xmlId] intValue]];
                                    [package setTitle:[TBXML textForElement:xmlTitle]];
                                    [package setDescription:[TBXML textForElement:xmlDescription]];
                                    if(xmlStartDate != NULL)[package setStartDate:[TBXML textForElement:xmlStartDate]];
                                    if(xmlEndDate != NULL)[package setEndDate:[TBXML textForElement:xmlEndDate]];
                                    [package setThumbnail:[TBXML valueOfAttributeNamed:@"url" forElement:xmlThumbnail]];
                                    [packages addObject:package];
                                }
                                
                                item = [TBXML nextSiblingNamed:@"item" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:packages], NULL);
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestCountries:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodcountries&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* genres = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                Country *country = [Country new];
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                TBXMLElement *xmlGenres = [TBXML childElementNamed:@"category" parentElement:item];
                                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"country"] == NSOrderedSame) {
                                    [country setId:[[TBXML textForElement:xmlId] intValue]];
                                    country.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                    country.Logo = [TBXML textForElement:xmlThumbnail];
                                    country.genres = [RestService FetchCountryGenres:xmlGenres];
                                    [genres addObject:country];
                                }
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:genres], NULL);
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)RequestCountries:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback synchronous:(BOOL)sync {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodcountries&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    return [DataFetcher Get:requestUrl Synchronously:sync usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                    if(statusEl == NULL) {
                        DLog(@"No status element found in xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* genres = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:root];
                        if(item != NULL) {
                            do {
                                Country *country = [Country new];
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                                TBXMLElement *xmlGenres = [TBXML childElementNamed:@"category" parentElement:item];
                                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"country"] == NSOrderedSame) {
                                    [country setId:[[TBXML textForElement:xmlId] intValue]];
                                    country.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                                    country.Logo = [TBXML textForElement:xmlThumbnail];
                                    country.genres = [RestService FetchCountryGenres:xmlGenres];
                                    [genres addObject:country];
                                }
                                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:genres], NULL);
                        
                    }
                }
            }
        }
    }];
}

+(DataFetcher *)Search:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId andSearchCriteria:(NSString *)searchCriteria usingCallback:(RSGetGenres)callback
{    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=search&deviceid=%@&devicetypeid=%@&episodetitle=%@", deviceId, deviceTypeId, searchCriteria]];
    
    return [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        
        if (error != NULL) {
            callback(NULL, error);
        }
        else {
            if(data == NULL) {
                callback(NULL, NULL);
            }
            else {
                NSError *error;
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    TBXMLElement *channelRootEl = [TBXML childElementNamed:@"episodes" parentElement:root];
                    if(channelRootEl == NULL) {
                        DLog(@"No channels element found in response xml. Passing NULL parameters to callback");
                        callback(NULL, NULL);
                    }
                    else {
                        
                        NSMutableArray* channels = [NSMutableArray new];
                        
                        TBXMLElement *item = [TBXML childElementNamed:@"episode" parentElement:channelRootEl];
                        if(item != NULL) {
                            do {
                                Episode *itembase = [Episode new];
                                TBXMLElement *xmlId = [TBXML childElementNamed:@"id" parentElement:item];
                                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"thumbnail" parentElement:item];
                                TBXMLElement *xmlTitle = [TBXML childElementNamed:@"title" parentElement:item];
                                TBXMLElement *xmlDuration = [TBXML childElementNamed:@"duration" parentElement:item];
                                TBXMLElement *xmlPrice = [TBXML childElementNamed:@"price" parentElement:item];
                                TBXMLElement *xmlExpiresIn = [TBXML childElementNamed:@"expiresin" parentElement:item];
                                TBXMLElement *xmlProgramId = [TBXML childElementNamed:@"programId" parentElement:item];
                                TBXMLElement *xmlType = [TBXML childElementNamed:@"type" parentElement:item];
                                
                                [itembase setId:[[TBXML textForElement:xmlId] intValue]];
                                itembase.Logo = [TBXML textForElement:xmlThumbnail];
                                itembase.Title = [TBXML textForElement:xmlTitle];
                                itembase.Duration = [TBXML textForElement:xmlDuration];
                                itembase.Price = [TBXML textForElement:xmlPrice];
                                itembase.ExpiresIn = [TBXML textForElement:xmlExpiresIn];
                                itembase.Type = [TBXML textForElement:xmlType];
                                itembase.ProgramId = [TBXML textForElement:xmlProgramId];
                                [channels addObject:itembase];
                                
                                item = [TBXML nextSiblingNamed:@"episode" searchFromElement:item];
                            } while (item != NULL);
                        }
                        
                        callback([NSArray arrayWithArray:channels], NULL);
                        
                    }
                    
                }
            }
        }
    }];
    
}

+(NSMutableArray *)FetchCountryGenres:(TBXMLElement *)element
{
    NSMutableArray* genres = [NSMutableArray new];
    Genre *genre;
    
    if(element != NULL)
    {
        TBXMLElement *item = [TBXML childElementNamed:@"poster" parentElement:element];
        if (item != NULL) {
            do {
                
                TBXMLElement *xmlId = [TBXML childElementNamed:@"playlist" parentElement:item];
                TBXMLElement *xmlThumbnail = [TBXML childElementNamed:@"sdposterurl" parentElement:item];
                TBXMLElement *xmlpostertype = [TBXML childElementNamed:@"postertype" parentElement:item];
                TBXMLElement *xmlProgramTypes = [TBXML childElementNamed:@"category" parentElement:item];
                
                if(xmlpostertype != NULL && [[TBXML textForElement:xmlpostertype] compare:@"genre"] == NSOrderedSame)
                {
                    genre = [Genre new];
                    [genre setId:[[TBXML textForElement:xmlId] intValue]];
                    genre.Title = [TBXML valueOfAttributeNamed:@"bcright" forElement:item];
                    genre.Logo = [TBXML textForElement:xmlThumbnail];
                    genre.programTypes = [RestService FetchGenreProgramTypes:xmlProgramTypes];
                    [genres addObject:genre];
                }
                
                item = [TBXML nextSiblingNamed:@"poster" searchFromElement:item];
            } while (item != NULL);
        }
    }
    
    return genres;
}

@end
