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
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Episode forNib:@"EpisodeSubView" usingClass:[EpisodeSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:MyTV_View_Program forNib:@"ProgramSubView" usingClass:[ProgramSubViewResponder class] button:nil displayImage:nil displayActiveImage:nil];
    [self.navigationLogic addNavigationItem:item];
    
    item = [[NavigationItem alloc] initWithKey:@"categories" forNib:@"CategoriesSubView" usingClass:[CategoriesSubViewResponder class] button:dealsButton displayImage:[UIImage imageNamed:@"catgoriesOpen.png"] displayActiveImage:[UIImage imageNamed:@"catgoriesOpen-Over.png"]];
    [self.navigationLogic addNavigationItem:item];
    
    self.navigationLogic.mainview = self.mainSubView;
    self.navigationLogic.categoriesMainview = self.categoriesSubView;
    
    [self.navigationLogic startHandlingNavigation];
    
    [self.categoriesSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
    
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

- (void)goToSearch:(id)sender {
    [self.searchTextfield resignFirstResponder];
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_Search }];
}

- (IBAction)goToLive:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : MyTV_View_LiveTV }];
}

- (IBAction)goToCategories:(id)sender {
    [self.categoriesSubView setHidden:NO];
    [self.categoriesCloseButton setHidden:NO];
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    spinner.center = CGPointMake(160, 240);
    spinner.tag = 12;
    [self.categoriesSubView addSubview:spinner];
    [spinner startAnimating];
    
    //dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // This is the operation that blocks the main thread, so we execute it in a background thread
        [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : @"categories" }];
        
        // UIKit calls need to be made on the main thread, so re-dispatch there
        //dispatch_async(dispatch_get_main_queue(), ^{
        //    detailViewController.item = item;
        //    [spinner stopAnimating];
        //});
    //});
    
    [spinner stopAnimating];
}

- (IBAction)goToCloseCategories:(id)sender {
    [self.categoriesSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
}

@end
