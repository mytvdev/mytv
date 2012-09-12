//
//  CategorieSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Johnny on 9/10/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "CategorieSubViewResponder.h"

@implementation CategorieSubViewResponder

- (IBAction)blueButtonPressed
{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Blue View Button Pressed"
                          message:@"You pressed the button on the blue view"
                          delegate:nil cancelButtonTitle:@"Yep, I did."
                          otherButtonTitles:nil];
    [alert show];
}

@end
