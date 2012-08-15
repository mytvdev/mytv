//
//  Program.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemBase.m"

@interface Program : ItemBase
{
    char Duration;
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
    char TrailerFileName;
    char Presenter;
    char EpisodeCount;
    char Language;
    char Season;
    char Award;
    char PackagePurchased;
}

-(void) SetDuration: (char) x;
-(void) SetDirector: (char) x;
-(void) SetGuest: (char) x;
-(void) SetCategory: (char) x;
-(void) SetPrice: (char) x;
-(void) SetProgramPrice: (char) x;
-(void) SetRating: (char) x;
-(void) SetProgramId: (char) x;
-(void) SetReleaseDate: (char) x;
-(void) SetExpiresIn: (char) x;
-(void) Set: (char) x;

@end
