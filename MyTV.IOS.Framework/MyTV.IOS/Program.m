//
//  Program.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Program.h"
#import "ItemBase.h"

@implementation MyTVProgram

@synthesize Category, Duration, Director, Guest, ExpiresIn, Presenter, Price, ProgramExpiresIn, ProgramId, ProgramPrice, TrailerFileName, ReleaseDate, Rating,Award, EpisodeCount, Language, PackagePurchased, Season, ProgramPurchased,Thumbnail, Description, Id, Logo, Title, Type;

-(id) copyWithZone:(NSZone *)zone {
    MyTVProgram *copy = [super copyWithZone:zone];
    if(copy) {
        copy.Id = self.Id;
        copy.Category = [self.Category copyWithZone:zone];
                copy.Duration = [self.Duration copyWithZone:zone];
                copy.Director = [self.Director copyWithZone:zone];
                copy.Guest = [self.Guest copyWithZone:zone];
                copy.ExpiresIn = [self.ExpiresIn copyWithZone:zone];
                copy.Presenter = [self.Presenter copyWithZone:zone];
                copy.Price = [self.Price copyWithZone:zone];
                copy.ProgramExpiresIn = [self.ProgramExpiresIn copyWithZone:zone];
                copy.ProgramId = [self.ProgramId copyWithZone:zone];
                copy.ProgramPrice = [self.ProgramPrice copyWithZone:zone];
                copy.TrailerFileName = [self.TrailerFileName copyWithZone:zone];
                copy.ReleaseDate = [self.ReleaseDate copyWithZone:zone];
                copy.Rating = [self.Rating copyWithZone:zone];
                copy.Award = [self.Award copyWithZone:zone];
                copy.EpisodeCount = [self.EpisodeCount copyWithZone:zone];
                copy.PackagePurchased = [self.PackagePurchased copyWithZone:zone];
                copy.Season = [self.Season copyWithZone:zone];
                copy.ProgramPurchased = [self.ProgramPurchased copyWithZone:zone];
                copy.Thumbnail = [self.Thumbnail copyWithZone:zone];
                copy.Description = [self.Description copyWithZone:zone];
                copy.Logo = [self.Logo copyWithZone:zone];
                copy.Title = [self.Title copyWithZone:zone];
        
    }
    return copy;
}

@end


