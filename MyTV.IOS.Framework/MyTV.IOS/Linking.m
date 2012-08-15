//
//  Linking.m
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Linking.h"

@implementation Linking

- (void) SetCustomerId: (int) x;
{
    CustomerId = x;
}

- (void) SetPinCode: (int)x;
{
    PinCode = x;
}

- (void) SetBillingId: (int)x;
{
    BillingId = x;
}

- (int) GetCustomerId;
{
    return CustomerId;
}

- (int) GetPinCode;
{
    return PinCode;
}

- (int) GetBillingId;
{
    return BillingId;
}

@end
