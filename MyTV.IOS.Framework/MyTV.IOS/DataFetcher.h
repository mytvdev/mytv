//
//  DataFetcher.h
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/17/12.
//
//

#import <Foundation/Foundation.h>

@interface DataFetcher : NSObject

@property NSObject* callbackObject;
@property SEL callbackSelector;

+(void)Get:(NSString *)url withCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector;

@end

