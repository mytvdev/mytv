//
//  Channel.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject<NSCopying>

@property int Id;
@property NSString *StartDate, *EndDate, *Name, *SmallDescription, *BigDescription, *SmallLogo, *BigLogo;

@end
