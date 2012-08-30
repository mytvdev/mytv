//
//  DataFetcher.h
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/17/12.
//
//

#import <Foundation/Foundation.h>

typedef void (^DataProcessorCallback)(NSData*, NSError*);

@interface DataFetcher : NSObject

@property (strong) DataProcessorCallback dataCallback;
@property BOOL hasReceivedData;
@property NSMutableData* receievedData;

+(void)Get:(NSString *)url usingCallback:(DataProcessorCallback) callback;

@end

