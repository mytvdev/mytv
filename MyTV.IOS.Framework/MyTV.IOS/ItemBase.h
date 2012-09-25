//
//  ItemBase.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemBase : NSObject <NSCopying>

@property int Id;
@property NSString *Title, *Description, *Type, *Logo;


@end
