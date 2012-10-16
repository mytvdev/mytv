//
//  IPadViewController.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IPadViewController.h"
#import "IPadViews.h"
#import "MBProgressHUD.h"
#import "LoadingView.h"

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
@synthesize countriesButton;
@synthesize searchButton;

@synthesize fillerData = _fillerData;
@synthesize episodesKKGridView;

@synthesize popoverController, popButton, myCatPopOver, myCountPopOver;

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
    
    NavigationItem *item = [[NavigationItem alloc] initWithKey:MyTV_View_Home forNib:@"HomeSubView" usingClass:[HomeSubViewResponder class] button:homeButton displayImage:[UIImage imageNamed:@"home.jpg"] displayActiveImage:[UIImage imageNamed:@"home-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_LiveTV forNib:@"LiveTVSubView" usingClass:[LiveTVSubViewResponder class] button:liveButton displayImage:[UIImage imageNamed:@"liveTV.jpg"] displayActiveImage:[UIImage imageNamed:@"liveTV-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_VODCatalog forNib:@"VODSubView" usingClass:[VODSubViewResponder class] button:vodButton displayImage:[UIImage imageNamed:@"catalog.jpg"] displayActiveImage:[UIImage imageNamed:@"catalog-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];

    item = [[NavigationItem alloc] initWithKey:MyTV_View_MyVOD forNib:@"MyVODSubView" usingClass:[MyVODSubViewResponder class] button:myVODButton displayImage:[UIImage imageNamed:@"myvod.jpg"] displayActiveImage:[UIImage imageNamed:@"myvod-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_HotDeals forNib:@"DealsSubView" usingClass:[DealsSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"deals.jpg"] displayActiveImage:[UIImage imageNamed:@"deals-Over.jpg"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Login forNib:@"LoginSubView" usingClass:[LoginSubViewResponder class] button:loginButton displayImage:[UIImage imageNamed:@"login.png"] displayActiveImage:[UIImage imageNamed:@"login-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Search forNib:@"SearchSubView" usingClass:[SearchSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Programs forNib:@"ProgramsSubView" usingClass:[ProgramsSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Episode forNib:@"EpisodeSubView" usingClass:[EpisodeSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Program forNib:@"ProgramSubView" usingClass:[ProgramSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_VODPackage forNib:@"VODPackageSubView" usingClass:[VODPackageSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"categories" forNib:@"CategoriesSubView" usingClass:[CategoriesSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"catgoriesOpen.png"] displayActiveImage:[UIImage imageNamed:@"catgoriesOpen-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_ProgramTypes forNib:@"ProgramTypesSubView" usingClass:[ProgramTypesSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"countries" forNib:@"CountriesSubView" usingClass:[CountriesSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"countriesOpen.png"] displayActiveImage:[UIImage imageNamed:@"countriesOpen-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    self.navigationLogic.mainview = self.mainSubView;
    
    [self.navigationLogic startHandlingNavigation];
    
    [RestService RequestGenres:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error)
     {
         if(array != nil && error == nil)
         {
             genres = array;
         }
     } synchronous:NO];
    
    [RestService RequestCountries:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error)
     {
         if(array != nil && error == nil)
         {
             countries = array;
         }
     } synchronous:NO];
    
    //load homeview by default
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : @"home" }];
    
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
    [self setCategoriesButton:nil];
    [self setCountriesButton:nil];
    [self setSearchButton:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return(interfaceOrientation==UIInterfaceOrientationLandscapeLeft) || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

- (IBAction)goHome:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_Home }];
}

- (IBAction)goToVodCatalog:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_VODCatalog}];
}

- (IBAction)goToMyVOD:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_MyVOD }];
}

- (IBAction)goToHotDeals:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View :  MyTV_View_HotDeals}];
}

- (IBAction)goToLogin:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_Login }];
}

- (IBAction)goToSearch:(id)sender {
    [self.searchTextfield resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:self.searchTextfield.text userInfo:@{ MyTV_ViewArgument_View : MyTV_View_Search }];
}

- (IBAction)goToLive:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_LiveTV }];
}

- (IBAction)goToCategories:(id)sender {
    myCatPopOver = [[CategoriesSubViewResponder alloc] initWithNibNameAndGenres:@"CategoriesSubView" bundle:nil genres:genres];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myCatPopOver];
    popoverController.popoverContentSize = CGSizeMake(112.f, 300.f);
    
    //present the popover view non-modal with a
    //refrence to the button pressed within the current view
    [self.popoverController presentPopoverFromRect:self.categoriesButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
}

- (IBAction)goToCountries:(id)sender {
    myCountPopOver = [[CountriesSubViewResponder alloc] initWithNibNameAndCountries:@"CountriesSubView" bundle:nil countries:countries];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myCountPopOver];
    popoverController.popoverContentSize = CGSizeMake(112.f, 300.f);
    
    //present the popover view non-modal with a
    //refrence to the button pressed within the current view
    [self.popoverController presentPopoverFromRect:self.countriesButton.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
}

-(BOOL) disablesAutomaticKeyboardDismissal {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [self.navigationLogic didReceiveMemoryWarning];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
}

@end
