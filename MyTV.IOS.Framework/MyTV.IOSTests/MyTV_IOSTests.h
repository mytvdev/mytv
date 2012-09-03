//
//  MyTV_IOSTests.h
//  MyTV.IOSTests
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import "HTTPServer.h"

@interface MyTV_IOSTests : SenTestCase

@property (strong, nonatomic) HTTPServer *webServer;

@end
