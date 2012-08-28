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
            //GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                [callbackObject performSelector:callbackSelector withObject:data withObject:error];
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                NSString *status = [TBXML textForElement:[TBXML childElementNamed:@"status" parentElement:root]];
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
            //GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
            if(error != NULL) {
                callback(NULL, error);
            }
            else {
                TBXMLElement *root = document.rootXMLElement;
                NSString *status = [TBXML textForElement:[TBXML childElementNamed:@"status" parentElement:root]];
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
                //GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
                TBXML *document = [TBXML newTBXMLWithXMLData:data error:&error];
                if(error != NULL) {
                    callback(NULL, error);
                }
                else {
                    TBXMLElement *root = document.rootXMLElement;
                    NSString *status = [TBXML textForElement:[TBXML childElementNamed:@"status" parentElement:root]];
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
    }];
    
}

@end
