//
//  VODPackageControlResponderViewController.h
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "SubViewResponder.h"
#import "DataFetcher.h"
#import "RestService.h"

@interface VODPackageControlResponder : SubViewResponder

@property VODPackage *vodPackage;

@property DataFetcher *imageFetcher;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageDisplay;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelDisplay;
@property UITapGestureRecognizer *recognizer;

@end
