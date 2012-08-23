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

@property NSObject* callbackObject;
@property SEL callbackSelector;
@property (unsafe_unretained) DataProcessorCallback dataCallback;

+(void)Get:(NSString *)url withCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector;
+(void)Get:(NSString *)url usingCallback:(DataProcessorCallback) callback;

@end

