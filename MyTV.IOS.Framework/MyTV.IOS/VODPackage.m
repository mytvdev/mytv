//
//  VODPackage.m
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/29/12.
//
//

#import "VODPackage.h"

@implementation VODPackage

@synthesize EndDate, Price, StartDate, Thumbnail, VODPackageTypeId;

-(id) copyWithZone:(NSZone *)zone {
    VODPackage *copy = [super copyWithZone:zone];
    if(copy) {
        copy.Id = self.Id;
        copy.Price = [self.Price copyWithZone:zone];
        copy.Thumbnail = [self.Thumbnail copyWithZone:zone];
        copy.Description = [self.Description copyWithZone:zone];
        copy.Title = [self.Title copyWithZone:zone];
    }
    return copy;
}

@end
