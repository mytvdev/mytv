//
//  MyTV_IOS_StaticTests.m
//  MyTV.IOS.StaticTests
//
//  Created by Omar Ayoub-Salloum on 9/3/12.
//
//

#import "MyTV_IOS_StaticTests.h"

@implementation MyTV_IOS_StaticTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.webServer = [HTTPServer new];
    [self.webServer setType:@"_http._tcp."];
    [self.webServer setPort:8080];
    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"wwwroot"];
    DLog("%@", webPath);
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

- (void) testSetUp {
    
    
    DataFetcher *fetcher = [DataFetcher Get:@"http://localhost:8080/index.html" usingCallback:^(NSData *data, NSError* error) {
        if(error != NULL) {
            STFail(@"Set up failed. Could not load default page.");
        }
        else {
            STAssertNotNil(data, @"Index page has been loaded");
        }
    }];
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:2];
    while(!fetcher.hasFinishedLoading) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
    
    if(!fetcher.hasFinishedLoading) {
        STFail(@"Failed to load document");
    }
    
}

@end