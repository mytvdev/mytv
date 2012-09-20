//
//  DataFetcher.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/17/12.
//
//

#import <Foundation/Foundation.h>

typedef void (^DataProcessorCallback)(NSData*, NSError*);

@interface DataFetcher : NSObject

@property (strong) DataProcessorCallback dataCallback;
@property BOOL hasReceivedData, hasFinishedLoading;
@property NSMutableData* receievedData;
@property NSURLConnection* connection;

+(DataFetcher *)Get:url Synchronously:(BOOL)sync usingCallback:(DataProcessorCallback)callback;
+(DataFetcher *)Get:(NSString *)url usingCallback:(DataProcessorCallback) callback;
-(BOOL)cancelPendingRequest;

@end

