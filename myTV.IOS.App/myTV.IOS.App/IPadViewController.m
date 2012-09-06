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
@synthesize navigationLogic;

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
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"catalog.jpg"] displayActiveImage:[UIImage imageNamed:@"catalog-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];

    item = [[NavigationItem alloc] initWithKey:@"myvod" forNib:@"MyVODSubView" usingClass:[MyVODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"vodcatalog" forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
}

- (void)viewDidUnload
{
    [self setMainView:nil];
    [self setHomeButton:nil];
    [self setVodButton:nil];
    [self setMyVODButton:nil];
    [self setDealsButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation==UIInterfaceOrientationLandscapeRight);
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"search" }];
}

@end
