//
//  ProgramType.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/31/12.
//
//

#import <Foundation/Foundation.h>
#import "ItemBase.h"

@interface ProgramType : ItemBase

@property NSString *genreId;
@property (nonatomic, strong) NSMutableArray *programs;

@end
