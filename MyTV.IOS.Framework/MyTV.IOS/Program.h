//
//  Program.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemBase.h"

@interface MyTVProgram : ItemBase <NSCopying>


@property NSString *Duration, *Director, *Guest, *Category, *Price, *ProgramPrice, *Rating, *ProgramId, *ReleaseDate, *ExpiresIn, *ProgramExpiresIn, *TrailerFileName, *Presenter, *EpisodeCount, *Language, *Season, *Award, *PackagePurchased, *ProgramPurchased, *Thumbnail;

@end
