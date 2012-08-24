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
#import "Linking.h"

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
                    [callbackObject performSelector:callbackSelector withObject:NULL withObject:NULL];
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


@end
