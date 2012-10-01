//
//  MyTVPackage.m
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/31/12.
//
//

#import "MyTVPackage.h"

@implementation MyTVPackage

@synthesize Description, EndDate, Id, Price, StartDate, Thumbnail, Title;

-(id) copyWithZone:(NSZone *)zone {
    MyTVPackage *copy = [[[self class] allocWithZone:zone] init];
    copy.Id = self.Id;
    copy.Description = [self.Description copyWithZone:zone];
    copy.EndDate = [self.EndDate copyWithZone:zone];
    copy.Price = [self.Price copyWithZone:zone];
    copy.StartDate = [self.StartDate copyWithZone:zone];
    copy.Thumbnail = [self.Thumbnail copyWithZone:zone];
    copy.Title = [self.Title copyWithZone:zone];
    return copy;
}

@end
