//
//  MyTV_IOS_StaticTests.h
//  MyTV.IOS.StaticTests
//
//  Created by Omar Ayoub-Salloum on 9/3/12.
//
//

#import <SenTestingKit/SenTestingKit.h>
#import "HTTPServer.h"
#import "DataFetcher.h"

#ifdef DEBUG
#   define DLog(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#   define DLog(...) do {} while (0)
#endif
// ALog always displays output regardless of the DEBUG setting
#define ALog(__FORMAT__, ...) NSLog((@"%s [Line %d] " __FORMAT__), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

@interface MyTV_IOS_StaticTests : SenTestCase

@property (strong, nonatomic) HTTPServer *webServer;

@end
