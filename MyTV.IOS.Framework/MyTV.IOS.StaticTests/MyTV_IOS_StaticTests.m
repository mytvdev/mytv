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
    NSString *webPath = @"/mytvioswwwroot/wwwroot";
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

- (void) testPreRegistrationSuccess {
    
    
    DataFetcher *fetcher = [RestService RequestGetPreregistrationCode:@"http://localhost:8080/preregistration.success.xml?" withDeviceId:@"deviceid" andDeviceTypeId:@"6" usingCallback:^(NSString* code, NSError* error) {
        STAssertNil(error, @"The method has returned an unexpected error");
        STAssertEqualObjects(code, @"8L8M7", @"The code returned %@ is different than the expected value 8L8M7", code
                             );
    }];
    STAssertNotNil(fetcher, @"The method has not returned a DataFetcher object");
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:2];
    while(!fetcher.hasFinishedLoading) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
    
    if(!fetcher.hasFinishedLoading) {
        STFail(@"Failed to load document");
    }
    
}

- (void) testGetPackages {
    
    DataFetcher *fetcher = [RestService RequestGetPackages:@"http://localhost:8080/getmytvpackages.success.xml?" withDeviceId:@"deviceid" andDeviceTypeId:@"6" usingCallback:^(NSArray* packages, NSError* error) {
        STAssertNil(error, @"The method has returned an unexpected error");
        STAssertNotNil(packages, @"No data was returned from the method call");
        if(packages != NULL) {
            NSString *countval = [NSString stringWithFormat:@"%d", [packages count]];
            STAssertEqualObjects(countval, @"1", @"Only one package should be returned.");
        }
    }];
    
    STAssertNotNil(fetcher, @"The method has not returned a DataFetcher object");
    
    NSDate *loopUntil = [NSDate dateWithTimeIntervalSinceNow:2];
    while(!fetcher.hasFinishedLoading) {
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:loopUntil];
    }
    
    if(!fetcher.hasFinishedLoading) {
        STFail(@"Failed to load document");
    }
    
}

@end
