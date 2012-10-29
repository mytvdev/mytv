//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "CategoriesSubViewResponder.h"
#import "TBXML.h"
#import "MBProgressHUD.h"

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize fillerProgramTypeData = _fillerProgramTypeData;
@synthesize categoriesSubView;
@synthesize categoriesKKGridView;
@synthesize genreFetcher = _genreFetcher;
@synthesize genres;
@synthesize ScrollView;

@synthesize tableVC;

- (id)initWithNibNameAndGenres:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil genres:(NSArray *)Genres
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.genres = Genres;
    }
    return self;
}

- (void)viewDidLoad
{
    
    self.tableVC=[[TableGenres alloc]initWithStyleAndGenres:UITableViewStylePlain genres:self.genres];
    [self.ScrollView addSubview:self.tableVC.view];
    
    /*if(self.genres == nil) {
        [MBProgressHUD showHUDAddedTo:self.ScrollView animated:YES];
        [RestService RequestGenres:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *arrgenres, NSError *error)
         {
             int yPos = Genres_Space;
             if(arrgenres != nil && error == nil)
             {
                 for (Genre *genre in arrgenres) {
                     self.tableVC = [[TableGenres alloc]initWithStyleAndGenres:UITableViewStylePlain genres:genre];
                     self.tableVC.view.frame = CGRectMake(0, yPos, self.tableVC.view.frame.size.width, self.tableVC.view.frame.size.height);
                     yPos = yPos + self.tableVC.view.frame.size.height + Genres_Space;
                     [self.ScrollView addSubview:self.tableVC.view];
                 }
             }
             
             self.ScrollView.contentSize = CGSizeMake(self.ScrollView.frame.size.width, yPos);
             hasLoadedGenresData = YES;
             [MBProgressHUD hideHUDForView:self.ScrollView animated:YES];
         } synchronous:YES];
    }
    else
    {
        int yPos = 0;
        for (Genre *genre in self.genres) {
            self.tableVC=[[TableGenres alloc]initWithStyleAndGenres:UITableViewStylePlain genres:genre];
            self.tableVC.view.frame = CGRectMake(0, yPos, self.tableVC.view.frame.size.width, self.tableVC.view.frame.size.height);
            yPos = yPos + self.tableVC.view.frame.size.height + 0;
            [self.ScrollView addSubview:self.tableVC.view];
        }
        self.ScrollView.contentSize = CGSizeMake(self.ScrollView.frame.size.width, yPos);
    }*/
}

@end
