//
//  BIDViewController.m
//  TestKKGrid2
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Johnny. All rights reserved.
//

#import "BIDViewController.h"
#import <KKGridView/KKGridView.h>
#import "KKDemoCell.h"

@interface BIDViewController ()

@end

@implementation BIDViewController


@synthesize fillerData = _fillerData;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    KKGridView *gridView = [[KKGridView alloc] initWithFrame:self.view.bounds];
    gridView.scrollsToTop = YES;
    gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    gridView.backgroundView = backgroundView;
    
    gridView.cellSize = CGSizeMake(75.f, 75.f);
    gridView.cellPadding = CGSizeMake(4.f, 4.f);
    
    gridView.allowsMultipleSelection = NO;
    
    _fillerData = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSUInteger j = 0; j < 10; j++) {
        [array addObject:[NSString stringWithFormat:@"%u", j]];
    }
    [_fillerData addObject:array];
    [gridView reloadData];
    
    [self.view addSubview:gridView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - KKGridView

- (NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return _fillerData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return [[_fillerData objectAtIndex:section] count];
}

- (NSString *)gridView:(KKGridView *)gridView titleForHeaderInSection:(NSUInteger)section
{
    return [NSString stringWithFormat:@"%u", section + 1];
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKDemoCell *cell = [KKDemoCell cellForGridView:gridView];
    cell.label.text = [NSString stringWithFormat:@"%u", indexPath.index];
    
    CGFloat percentage = (CGFloat)indexPath.index / (CGFloat)[[_fillerData objectAtIndex:indexPath.section] count];
    cell.contentView.backgroundColor = [UIColor colorWithWhite:percentage alpha:1.f];
    
    return cell;
}

@end
