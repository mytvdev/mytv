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
#import "KKDetailViewController.h"
#import "KKDemoCell.h"

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
@synthesize navigationLogic;

@synthesize categoriesButton;
@synthesize categoriesMainView;
@synthesize categoriesMainSubView;
@synthesize categoriesNavigationLogic;
@synthesize categoriesCloseButton;

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
    
    /*item = [[NavigationItem alloc] initWithKey:@"categories" forNib:@"CategoriesSubView" usingClass:[KKDetailViewController class] button:categoriesButton displayImage:[UIImage imageNamed:@"categoriesOpen.png"] displayActiveImage:[UIImage imageNamed:@"categoriesOpen-Over.png"]];
    [self.navigationLogic addNavigationItem:item];*/
    
    self.navigationLogic.mainview = self.mainSubView;
    //self.navigationLogic.categorieMainview = self.categoriesMainSubView;
    [self.navigationLogic startHandlingNavigation];
    
    //load homeview by default
    [[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"home" }];
    
    [self.categoriesMainSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
}

- (void)viewDidUnload
{
    [self setHomeButton:nil];
    [self setVodButton:nil];
    [self setMyVODButton:nil];
    [self setDealsButton:nil];
    [self setMainSubView:nil];
    [self setMainView:nil];
    [self setCategoriesMainSubView:nil];
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

- (IBAction)goToCategories:(id)sender {
    /*[[NSNotificationCenter defaultCenter] postNotificationName:@"ChangeMainSubView" object:nil userInfo:@{ @"view" : @"categories" }];*/
    
    /*UIImageView *newView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,600,250)];
    UIImage *backImage = [UIImage imageNamed:@"tray.png"];
    UIImage *buttonBk = [self scaleImage:backImage toSize:CGSizeMake(600.0,250.0)];
    newView.image = buttonBk;
    
    [self.categoriesMainSubView addSubview:newView];*/
    
    KKGridView *gridView = [[KKGridView alloc] initWithFrame:self.view.bounds];
    gridView.scrollsToTop = YES;
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    gridView.cellSize = CGSizeMake(75.f, 75.f);
    gridView.cellPadding = CGSizeMake(4.f, 4.f);
    
    gridView.allowsMultipleSelection = NO;
    
    //[self.categoriesMainSubView addSubview:gridView];
    
    if(self.categoriesMainSubView.hidden == YES)
        [self.categoriesMainSubView setHidden:NO];
    
    //[self.categoriesMainSubView setHidden:NO];
    [self.categoriesCloseButton setHidden:NO];
}

- (IBAction)closeCategories:(id)sender {
    [self.categoriesMainSubView setHidden:YES];
    [self.categoriesCloseButton setHidden:YES];
}

-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize
{    
    float width = newSize.width;
    float height = newSize.height;
    
    UIGraphicsBeginImageContext(newSize);
    CGRect rect = CGRectMake(0, 0, width, height);
    
    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;
    
    width = image.size.width / divisor;
    height = image.size.height / divisor;
    
    rect.size.width  = width;
    rect.size.height = height;
    
    if(height < width)
        rect.origin.y = height / 3;
    [image drawInRect: rect];
    
    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
}

@end
