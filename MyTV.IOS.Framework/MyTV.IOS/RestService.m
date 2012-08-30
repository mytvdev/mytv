//
//  RestService.m
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/23/12.
//
//

#import "RestService.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation RestService

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId andCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=linking&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            [callbackObject performSelector:callbackSelector withObject:data withObject:error];
        }
        else {
            NSError *error;
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                [callbackObject performSelector:callbackSelector withObject:data withObject:error];
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                TBXMLElement *statusEl = [TBXML childElementNamed:@"status" parentElement:root];
                if(statusEl == NULL) {
                    DLog(@"No status element found in xml. Passing NULL parameters to callback");
                    [callbackObject performSelector:callbackSelector withObject:NULL withObject:NULL];
                }
                else {
                    NSString *status = [TBXML textForElement:statusEl];
                    if ([status compare:@"failure"] == NSOrderedSame) {
                        error = [NSError errorWithDomain:NSPOSIXErrorDomain code:[@"1" integerValue] userInfo:@{NSLocalizedDescriptionKey: @"Webservice Failure"}];
                        
                        [callbackObject performSelector:callbackSelector withObject:NULL withObject:error];
                    }
                    else
                    {
                        Linking *object = [Linking new];
                        TBXMLElement *root = document.rootXMLElement;
                        TBXMLElement *customer = [TBXML childElementNamed:@"customer" parentElement:root];
                        if (customer == NULL) {
                            [callbackObject performSelector:callbackSelector withObject:NULL withObject:NULL];
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
                            [callbackObject performSelector:callbackSelector withObject:object withObject:NULL];
                            
                        }
                        
                    }
                }
                
            }
        }
    }];
    
}

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=linking&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetVODUrl:(NSString *)baseUrl ofVideo:(NSString *)videoId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVodUrlCallBack)callback {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=watchvod&deviceid=%@&devicetypeid=%@&episodeid=%@", deviceId, deviceTypeId, videoId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetChannelUrl:(NSString *)baseUrl ofChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelURlCallback)callback{
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=watchchannel&deviceid=%@&devicetypeid=%@&channelid=%@", deviceId, deviceTypeId, channelId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetProgramEpisodesUrls:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVodUrlCallBack)callback {
    
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=GetVODToWatchFromProgram&deviceid=%@&devicetypeid=%@&ProgramId=%@", deviceId, deviceTypeId, programId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannel&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getchannels&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetChannels:(NSString *)baseUrl ofPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getmytvchannels&deviceid=%@&devicetypeid=%@&packageid=%@", deviceId, deviceTypeId, packageId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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


+(void)RequestGetChannels:(NSString *)baseUrl ofVODPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackagecontent&contenttypeid=3&deviceid=%@&devicetypeid=%@&vodpackageid=%@", deviceId, deviceTypeId, packageId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetPreregistrationCode:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPreregistrationCode)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=preregistration&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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

+(void)RequestGetVODPackages:(NSString *)baseUrl ofBouquet:(NSString *)bouquetId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getvodpackage&deviceid=%@&devicetypeid=%@&BouquetId=%@", deviceId, deviceTypeId, bouquetId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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
                                
                                [vodpackage setId:[TBXML textForElement:xmlId]];
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

+(void)RequestGetMyVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback{
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=myvod&deviceid=%@&devicetypeid=%@", deviceId, deviceTypeId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback];
                }
            }
        }
    }];
}

+(void)ProcessVideoItemsTags:(TBXMLElement *)root usingCallBack:(RSGetVOD)callback {
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
        callback([NSArray arrayWithArray:videos], NULL);
        
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

+(void)RequestGetVOD:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback {
    
    NSString* requestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=getepisodes&deviceid=%@&devicetypeid=%@&programid=%@", deviceId, deviceTypeId, programId]];
    
    [DataFetcher Get:requestUrl usingCallback:^(NSData *data, NSError *error) {
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
                    [RestService ProcessVideoItemsTags:root usingCallBack:callback];
                }
            }
        }
    }];
}



@end
