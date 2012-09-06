//
//  IPadViewController.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "IPadViewController.h"

@interface IPadViewController ()

@end

@implementation IPadViewController
@synthesize mainView;
@synthesize homeButton;
@synthesize vodButton;
@synthesize myVODButton;
@synthesize dealsButton;

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
}

- (IBAction)goToVodCatalog:(id)sender {
}

- (IBAction)goToMyVOD:(id)sender {
}

- (IBAction)goToHotDeals:(id)sender {
}
@end
