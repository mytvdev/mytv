//
//  IPadViewController.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTVViewController.h"

@interface IPadViewController : MyTVViewController
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *homeButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *vodButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *myVODButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *dealsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *loginButton;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *searchTextfield;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainSubView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *liveButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *rootView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *categoriesButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *categoriesCloseButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *categoriesSubView;

- (IBAction)goHome:(id)sender;
- (IBAction)goToVodCatalog:(id)sender;
- (IBAction)goToMyVOD:(id)sender;
- (IBAction)goToHotDeals:(id)sender;
- (IBAction)goToLogin:(id)sender;
- (IBAction)goToSearch:(id)sender;
- (IBAction)goToLive:(id)sender;
- (IBAction)goToCategories:(id)sender;
- (IBAction)goToCloseCategories:(id)sender;

@end
