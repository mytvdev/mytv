//
//  Episode.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemBase.m"

@interface Episode : ItemBase
{
    char Duration;
    char Duration2;
    char Director;
    char Guest;
    char Category;
    char Price;
    char ProgramPrice;
    char Rating;
    char ProgramId;
    char ReleaseDate;
    char ExpiresIn;
    char ProgramExpiresIn;
    char ProgramPurchased;
    char CanBuyEpisode;
    char TrailerFileName;
    char Presenter;
}


@end
