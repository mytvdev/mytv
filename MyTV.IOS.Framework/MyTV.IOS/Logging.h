//
//  Logging.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/22/12.
//
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#   define DLog(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...) do {} while (0)
#endif
// ALog always displays output regardless of the DEBUG setting
#define ALog(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@protocol Logging <NSObject>

@end
