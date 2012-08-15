//
//  ItemBase.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ItemBase.h"

@implementation ItemBase

- (void) SetId: (int) x;
{
    Id = x;
}

- (void) SetTitle: (char) x;
{
    Title = x;
}

- (void) SetDescription: (char) x;
{
    Description = x;   
}

- (void) SetType: (char) x;
{
    Type = x;
}

- (void) SetLogo: (char) x;
{
    Logo = x;
}

- (int) GetId;
{
    return Id;
}

- (char) GetTitle;
{
    return Title;
}

- (char) GetDescription;
{
    return Description;
}

- (char) GetType;
{
    return Type;
}

- (char) GetLogo;
{
    return Logo;
}

@end
