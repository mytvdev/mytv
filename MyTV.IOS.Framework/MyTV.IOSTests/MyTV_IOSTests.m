//
//  MyTV_IOSTests.m
//  MyTV.IOSTests
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MyTV_IOSTests.h"

@implementation MyTV_IOSTests

- (void)setUp
{
    [super setUp];
    // Set-up code here.
    self.webServer = [HTTPServer new];
    [self.webServer setType:@"_http._tcp."];
    [self.webServer setPort:8080];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
    DLog(@"%@", webPath);
    [self.webServer setDocumentRoot:webPath];
    NSError *error;
    [self.webServer start:&error];
}

- (void)tearDown
{
    [self.webServer stop];
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    STFail(@"Unit tests are not implemented yet in MyTV.IOSTests");
}

@end
