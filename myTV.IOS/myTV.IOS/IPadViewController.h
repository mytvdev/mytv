//
//  IPadViewController.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyTVViewController.h"
#import "CategoriesSubViewResponder.h"
#import "CountriesSubViewResponder.h"
#import "RestCache.h"

@interface IPadViewController : MyTVViewController <UIApplicationDelegate>
{
    UITabBar *tabBar;
    UIPopoverController *popoverController;
    IBOutlet UIBarButtonItem *popButton;
    CategoriesSubViewResponder *myCatPopOver;
    CountriesSubViewResponder *myCountPopOver;
    NSArray *genres;
    NSArray *countries;
}

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *popButton;
@property (nonatomic, retain) CategoriesSubViewResponder *myCatPopOver;
@property (nonatomic, retain) CountriesSubViewResponder *myCountPopOver;
@property (nonatomic, retain) IBOutlet UITabBar *tabBar;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *homeButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *vodButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *myVODButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *dealsButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *loginButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *searchButton;
@property (unsafe_unretained, nonatomic) IBOutlet UITextField *searchTextfield;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainSubView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *liveButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *rootView;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *categoriesButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *countriesButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *backButton;

@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, retain) KKGridView *episodesKKGridView;

- (IBAction)goHome:(id)sender;
- (IBAction)goToVodCatalog:(id)sender;
- (IBAction)goToMyVOD:(id)sender;
- (IBAction)goToHotDeals:(id)sender;
- (IBAction)goToLogin:(id)sender;
- (IBAction)goToSearch:(id)sender;
- (IBAction)goToLive:(id)sender;
- (IBAction)goToCategories:(id)sender;
- (IBAction)goToCountries:(id)sender;
- (IBAction)gotoBack:(id)sender;

@end
