//
//  RestService.h
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/23/12.
//
//

#import <Foundation/Foundation.h>
#import "Logging.h"
#import "DataFetcher.h"
#import "Linking.h"

typedef void (^RSLinkingCallBack) (Linking*, NSError*);

@interface RestService : NSObject

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId andCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector;

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback;

@end
