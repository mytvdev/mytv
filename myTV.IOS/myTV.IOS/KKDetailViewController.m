//
//  KKDetailViewController.m
//  myTV.IOS
//
//  Created by Johnny on 9/12/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "KKDetailViewController.h"
#import "KKDemoCell.h"

@interface KKDetailViewController ()

@end

@implementation KKDetailViewController

@synthesize fillerData = _fillerData;

#pragma mark - Initialization

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = [UIColor scrollViewTexturedBackgroundColor];
    self.gridView.backgroundView = backgroundView;
    
    self.gridView.cellPadding = CGSizeMake(11.f, 5.f);
    self.title = @"";
    
    _fillerData = [[NSMutableArray alloc] init];
    for (NSUInteger i = 0; i < 20; i++) {
        NSMutableArray *array = [[NSMutableArray alloc] init];
        for (NSUInteger j = 0; j < 20; j++) {
            [array addObject:[NSString stringWithFormat:@"%u", j]];
        }
        
        [_fillerData addObject:array];
    }
    
    [self.gridView reloadData];
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

#pragma mark - Cleanup

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark - UIViewController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
