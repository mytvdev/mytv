//
//  BIDViewController.h
//  TestKKGrid
//
//  Created by Johnny on 9/12/12.
//  Copyright (c) 2012 Johnny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <KKGridView/KKGridViewController.h>

@interface BIDViewController : KKGridViewController <UISplitViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *fillerData;

@end
