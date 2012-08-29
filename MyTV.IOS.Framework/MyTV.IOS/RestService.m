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

@end
