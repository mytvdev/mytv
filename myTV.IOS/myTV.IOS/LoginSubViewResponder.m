//
//  LoginSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "LoginSubViewResponder.h"

@implementation LoginSubViewResponder
@synthesize mainView;
@synthesize lblCode;
@synthesize btnNewCode;

- (void)viewDidLoad {
    [self getNewCode];
    [self performSelector:@selector(checkForLinking) withObject:nil afterDelay:2];
}

- (void)checkForLinking {
    [linkingFetcher cancelPendingRequest];
    linkingFetcher = [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *data, NSError *error){
        if (data != nil && error == nil) {
            alertSuccess = [[UIAlertView alloc] initWithTitle:@"Congrats" message:@"You have successfully linked your device." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alertSuccess show];
            
        }
        else {
            [self performSelector:@selector(checkForLinking) withObject:nil afterDelay:2];
        }
    }];
}


- (void) getNewCode {
    [codeFetcher cancelPendingRequest];
    [MBProgressHUD showHUDAddedTo:self.mainView animated:YES];
    codeFetcher = [RestService RequestGetPreregistrationCode:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSString *code, NSError *error){
        if(error != nil) {
            alertError = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"Error occured: %@", error] delegate:self cancelButtonTitle:@"Go Home" otherButtonTitles:@"Retry", nil];
            [alertError show];
        }
        else {
            lblCode.text = code;
        }
        [MBProgressHUD hideHUDForView:self.mainView animated:YES];
    }];
}

- (IBAction)getNewCode:(id)sender {
    [self getNewCode];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if(alertView == alertError) {
        if (buttonIndex == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{MyTV_ViewArgument_View: MyTV_View_Home}];
        }
        else {
            [self getNewCode];
        }
    }
    else if (alertView == alertSuccess) {
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_PopView object:nil];
    }
}

@end
