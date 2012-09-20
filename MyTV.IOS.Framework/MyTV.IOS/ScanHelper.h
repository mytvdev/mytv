//
//  ScanHelper.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/24/12.
//
//

#import <Foundation/Foundation.h>

@interface ScanHelper : NSObject

+ (int)getIntFromNSString:(NSString *)string;

+ (NSDate *)getDateFromNSString:(NSString *)string;

@end
