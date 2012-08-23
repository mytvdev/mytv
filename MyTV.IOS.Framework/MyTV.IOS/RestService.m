//
//  RestService.m
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/23/12.
//
//

#import "RestService.h"


@implementation RestService

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector {
    
    NSString* linkingRequestUrl = [baseUrl stringByAppendingString:[NSString stringWithFormat:@"action=linking&deviceid=%@&devicetypeid=5", deviceId]];
    
    [DataFetcher Get:linkingRequestUrl usingCallback:^(NSData *data, NSError *error) {
        DLog(@"Processing Data inside Code Block");
        if (error != NULL) {
            [callbackObject performSelector:callbackSelector withObject:data withObject:error];
        }
        else {
            NSError *error;
            //GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithData:data options:0 error:&error];
            NSLog(@"Processed xml document");
        }
    }];
    
}

@end
