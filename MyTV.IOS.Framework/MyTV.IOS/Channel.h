//
//  Channel.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Channel : NSObject
{
    int Id;
    char StartDate;
    char EndDate;
    char Name;
    char SmallDescription;
    char BigDescription;
    char SmallLogo;
    char BigLogo;
}

- (void) SetId: (int) x;
- (void) SetStartDate: (char) x;
- (void) SetEndDate: (char) x;
- (void) SetName: (char) x;
- (void) SetSmallDescription: (char) x;
- (void) SetBigDescription: (char) x;
- (void) SetSmallLogo: (char) x;
- (void) SetBigLogo: (char) x;

- (int) GetId;
- (char) GetStartDate;
- (char) GetEndDate;
- (char) GetName;
- (char) GetSmallDescription;
- (char) GetBigDescription;
- (char) GetSmallLogo;
- (char) GetBigLogo;

@end
