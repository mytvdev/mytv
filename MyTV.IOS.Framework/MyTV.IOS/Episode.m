//
//  Episode.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Episode.h"
#import "ItemBase.h"

@implementation Episode

@synthesize ProgramPurchased, Rating, ReleaseDate, TrailerFileName, ProgramPrice, Price, ProgramExpiresIn, ProgramId, Presenter, ExpiresIn, Guest, Director, Duration, Duration2, CanBuyEpisode, Category, Language, Type, Description, Logo, Title, Id, Thumbnail, ProgramTitle, Season, Awards;

-(id) copyWithZone:(NSZone *)zone {
    Episode *copy = [super copyWithZone:zone];
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
        copy.ProgramPurchased = [self.ProgramPurchased copyWithZone:zone];
        copy.Duration2 = [self.Duration2 copyWithZone:zone];
        copy.CanBuyEpisode = [self.CanBuyEpisode copyWithZone:zone];
        copy.ProgramTitle = [self.ProgramTitle copyWithZone:zone];
        copy.ProgramPurchased = [self.ProgramPurchased copyWithZone:zone];
        copy.Thumbnail = [self.Thumbnail copyWithZone:zone];
        copy.Description = [self.Description copyWithZone:zone];
        copy.Logo = [self.Logo copyWithZone:zone];
        copy.Title = [self.Title copyWithZone:zone];
        copy.Price = [self.Price copyWithZone:zone];
        copy.Awards = [self.Awards copyWithZone:zone];
        copy.Season = [self.Season   copyWithZone:zone];
    }
    return copy;
}
@end