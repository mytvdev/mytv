//
//  Channel.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Channel.h"

@implementation Channel

@synthesize Id, BigDescription, BigLogo, EndDate, Name, SmallDescription, SmallLogo, StartDate;

-(id) copyWithZone:(NSZone *)zone {
    Channel *copy = [[[self class] allocWithZone:zone] init];
    copy.Id = self.Id;
    copy.BigDescription = [self.BigDescription copyWithZone:zone];
    copy.BigLogo = [self.BigLogo copyWithZone:zone];
    copy.EndDate = [self.EndDate copyWithZone:zone];
    copy.Name = [self.Name copyWithZone:zone];
    copy.SmallDescription = [self.SmallDescription copyWithZone:zone];
    copy.SmallLogo = [self.SmallLogo copyWithZone:zone];
    copy.StartDate = [self.StartDate copyWithZone:zone];
    return copy;
}

@end
