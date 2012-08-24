//
//  RestService.m
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/23/12.
//
//

#import "RestService.h"


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
                    [callbackObject performSelector:callbackSelector withObject:@"success" withObject:NULL];
                }
                
            }
        }
    }];
    
}

@end
