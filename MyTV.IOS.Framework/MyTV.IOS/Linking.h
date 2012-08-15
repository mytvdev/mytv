//
//  Linking.h
//  MyTV.IOS
//
//  Created by Johnny on 8/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Linking : NSObject
{
    int CustomerId;
    int PinCode;
    int BillingId;
}

- (void) SetCustomerId: (int) x;
- (void) SetPinCode: (int)x;
- (void) SetBillingId: (int)x;

- (int) GetCustomerId;
- (int) GetPinCode;
- (int) GetBillingId;

@end
