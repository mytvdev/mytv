//
//  Episode.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ItemBase.h"

@interface Episode : ItemBase <NSCopying>


@property NSString *Duration, *Duration2, *Director, *Guest, *Category, *Price, *ProgramPrice, *Rating, *ProgramId, *ReleaseDate, *ExpiresIn, *ProgramExpiresIn, *ProgramPurchased, *CanBuyEpisode, *TrailerFileName, *Presenter, *Thumbnail, *Language, *ProgramTitle, *Season, *Awards;


@end
