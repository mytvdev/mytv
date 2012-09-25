//
//  ItemBase.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemBase.h"

@implementation ItemBase

@synthesize Id, Description, Logo, Title, Type;

- (id)copyWithZone:(NSZone *)zone {
    ItemBase *copy = [[[self class] allocWithZone:zone] init];
    copy.Id = self.Id;
    copy.Description = [self.Description copyWithZone:zone];
    copy.Logo = [self.Description copyWithZone:zone];
    copy.Title = [self.Title copyWithZone:zone];
    copy.Type = [self.Type copyWithZone:zone];
    return copy;
}
@end
