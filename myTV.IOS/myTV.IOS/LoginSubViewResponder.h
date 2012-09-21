//
//  LoginSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"
@interface LoginSubViewResponder : SubViewResponder <
 UIAlertViewDelegate
>
{
    UIAlertView *alertError;
    UIAlertView *alertSuccess;
    DataFetcher *codeFetcher;
    DataFetcher *linkingFetcher;
}

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblCode;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnNewCode;
- (IBAction)getNewCode:(id)sender;

@end
