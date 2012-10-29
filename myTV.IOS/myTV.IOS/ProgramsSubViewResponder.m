//  MyVODSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "ProgramsSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation ProgramsSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize arrayPrograms = _arrayPrograms;
@synthesize myvodKKGridView;
@synthesize myvodView;
@synthesize myvodFetcher = _myvodFetcher;
//@synthesize imageDisplay;

- (void)viewDidLoad
{
    //[super viewDidLoad];
}

-(void)bindData:(NSObject *)data
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"popoverShouldDismiss" object:nil];
    
    if([[self.myvodView subviews] count] > 0) {
        [[[self.myvodView subviews] objectAtIndex:0] removeFromSuperview];
    }
    
    //[self.imageDisplay setHidden:YES];
    _fillerData = [[NSMutableArray alloc] init];
    
    myvodKKGridView = [[KKGridView alloc] initWithFrame:self.myvodView.bounds];
    myvodKKGridView.dataSource = self;
    myvodKKGridView.delegate = self;
    myvodKKGridView.scrollsToTop = YES;
    myvodKKGridView.backgroundColor = [UIColor clearColor];
    myvodKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    myvodKKGridView.cellSize = CGSizeMake(180.f, 180.f);
    myvodKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
    myvodKKGridView.allowsMultipleSelection = NO;
    myvodKKGridView.gridHeaderView = nil;
    myvodKKGridView.gridFooterView = nil;
    
    self.arrayPrograms = (NSMutableArray *)data;
    
    [self fillPrograms];
}

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return _fillerData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return [[_fillerData objectAtIndex:section] count];
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKProgramCell *cell = [KKProgramCell cellForGridView:gridView];
    MyTVProgram *program = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.program = program;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if([cell respondsToSelector:@selector(bindProgram:)])
        [cell performSelector:@selector(bindProgram:) withObject:program];
    return cell;
}

-(void) fillPrograms {
    [MBProgressHUD showHUDAddedTo:self.myvodView animated:YES];
    if(self.arrayPrograms != nil && self.arrayPrograms.count > 0)
    {
        [_fillerData addObject:self.arrayPrograms];
    }
    [myvodKKGridView reloadData];
    [self.myvodView addSubview:myvodKKGridView];
    [MBProgressHUD hideHUDForView:self.myvodView animated:NO];
}

@end
