//
//  ItemBase.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemBase : NSObject
{
    int Id;
    char Title;
    char Description;
    char Type;
    char Logo;
}

- (void) SetId: (int) x;
- (void) SetTitle: (char) x;
- (void) SetDescription: (char) x;
- (void) SetType: (char) x;
- (void) SetLogo: (char) x;

- (int) GetId;
- (char) GetTitle;
- (char) GetDescription;
- (char) GetType;
- (char) GetLogo;

@end
