//
//  IPadViewController.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IPadViewController.h"
#import "IPadViews.h"

@interface IPadViewController ()

@end

@implementation IPadViewController

@synthesize mainView;
@synthesize homeButton;
@synthesize vodButton;
@synthesize myVODButton;
@synthesize dealsButton;
@synthesize loginButton;
@synthesize searchTextfield;
@synthesize mainSubView;
@synthesize liveButton;
@synthesize rootView;
@synthesize navigationLogic;
@synthesize categoriesButton;
@synthesize categoriesCloseButton;
@synthesize categoriesSubView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationLogic = [[NavigationLogic alloc] init];
    
    NavigationItem *item = [[NavigationItem alloc] initWithKey:@"home" forNib:@"HomeSubView" usingClass:[HomeSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"livetv" forNib:@"LiveTVSubView" usingClass:[LiveTVSubViewResponder class] button:liveButton displayImage:[UIImage imageNamed:@"liveTV.jpg"] displayActiveImage:[UIImage imageNamed:@"liveTV-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:vodButton displayImage:[UIImage imageNamed:@"catalog.jpg"] displayActiveImage:[UIImage imageNamed:@"catalog-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];

    item = [[NavigationItem alloc] initWithKey:@"myvod" forNib:@"MyVODSubView" usingClass:[MyVODSubViewResponder class] button:myVODButton displayImage:[UIImage imageNamed:@"myvod.jpg"] displayActiveImage:[UIImage imageNamed:@"myvod-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"hotdeals" forNib:@"DealsSubView" usingClass:[DealsSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"deals.jpg"] displayActiveImage:[UIImage imageNamed:@"deals-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"login" forNib:@"LoginSubView" usingClass:[LoginSubViewResponder class] button:loginButton displayImage:[UIImage imageNamed:@"login.png"] displayActiveImage:[UIImage imageNamed:@"login-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"search" forNib:@"SearchSubView" usingClass:[SearchSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"categories" forNib:@"CategoriesSubView" usingClass:[CategoriesSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"catgoriesOpen.png"] displayActiveImage:[UIImage imageNamed:@"catgoriesOpen-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    self.navigationLogic.mainview = self.mainSubView;
    self.navigationLogic.categoriesMainview = self.categoriesSubView;
    
    [self.navigationLogic startHandlingNavigation];
    
    [self.categoriesSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
    
    //load homeview by default
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"home" }];
    
    
    self.player = [[MyTVPlayer alloc] init];
    self.player.mainView = self.rootView;
    
    [self.player startHandlingPlayerRequests];
}

- (void)viewDidUnload
{
    [self setHomeButton:nil];
    [self setVodButton:nil];
    [self setMyVODButton:nil];
    [self setDealsButton:nil];
    [self setMainSubView:nil];
    [self setMainView:nil];
    [self setLiveButton:nil];
    [self setRootView:nil];
    [self setCategoriesSubView:nil];
    [self setCategoriesButton:nil];
    [self setCategoriesCloseButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation==UIInterfaceOrientationLandscapeLeft);
}

- (IBAction)goHome:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"home" }];
}

- (IBAction)goToVodCatalog:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"vodcatalog" }];
}

- (IBAction)goToMyVOD:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"myvod" }];
}

- (IBAction)goToHotDeals:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"hotdeals" }];
}

- (IBAction)goToLogin:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"login" }];
}

- (void)goToSearch:(id)sender {
    [self.searchTextfield resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"search" }];
}

- (IBAction)goToLive:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"livetv" }];
}

- (IBAction)goToCategories:(id)sender {
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"categories" }];
    [self.categoriesSubView setHidden:NO];
    [self.categoriesCloseButton setHidden:NO];
}

- (IBAction)goToCloseCategories:(id)sender {
    [self.categoriesSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
}

@end
