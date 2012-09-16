//
//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "CategoriesSubViewResponder.h"

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize categoriesSubView;
@synthesize categoriesKKGridView;
@synthesize genreFetcher = _genreFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    //NSMutableArray *array = [[NSMutableArray alloc] init];
    //for (NSUInteger j = 1; j <= 10; j++)
   // {
    //    [array addObject:[NSString stringWithFormat:@"%u", j]];
    //}
    
    //[_fillerData addObject:array];
    
    [self fillGenres];
    
    
    categoriesKKGridView = [[KKGridView alloc] initWithFrame:self.categoriesSubView.bounds];
    categoriesKKGridView.dataSource = self;
    categoriesKKGridView.delegate = self;
    categoriesKKGridView.scrollsToTop = YES;
    //categoriesKKGridView.backgroundColor = [UIColor darkGrayColor];
    categoriesKKGridView.backgroundColor = [UIColor clearColor];
    categoriesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    categoriesKKGridView.cellSize = CGSizeMake(108.f, 40.f);
    categoriesKKGridView.cellPadding = CGSizeMake(0.f, 15.f);
    categoriesKKGridView.allowsMultipleSelection = NO;
    categoriesKKGridView.gridHeaderView = nil;
    categoriesKKGridView.gridFooterView = nil;
    [categoriesKKGridView reloadData];
    [self.categoriesSubView addSubview:categoriesKKGridView];
}

#pragma mark - KKGridViewDataSource

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return _fillerData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return [[_fillerData objectAtIndex:section] count];
}

//- (NSString *)gridView:(KKGridView *)gridView titleForHeaderInSection:(NSUInteger)section
//{
//    return [NSString stringWithFormat:@"%u", section + 1];
//}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKDemoCell *cell = [KKDemoCell cellForGridView:gridView];
    cell.label.text = [NSString stringWithFormat:@"%u", indexPath.index];
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    //CGFloat percentage = (CGFloat)indexPath.index / (CGFloat)[[_fillerData objectAtIndex:indexPath.section] count];
    //cell.contentView.backgroundColor = [UIColor colorWithWhite:percentage alpha:1.f];
    return cell;
}

-(void) fillGenres {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    _genreFetcher = [RestService RequestGenres:@"http://www.my-tv.us/mytv.restws.new/RestService.ashx?" withDeviceId:@"iosdevice1" andDeviceTypeId:@"5" usingCallback:^(NSArray *genres, NSError *error)
    {
        for (Genre *genre in genres) {
            //ChannelControlResponder *responder = [[ChannelControlResponder alloc] init];
            //NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
            //UIView *view = [array objectAtIndex:0];
            //view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
            //xPos = xPos + view.frame.size.width + ChannelControl_Space;
            //[subview.channelScrollView addSubview:view];
            //if([responder respondsToSelector:@selector(bindData:)]) {
            //    [responder performSelector:@selector(bindData:) withObject:channel];
            //}
            [array addObject:genre.Title];
        }
    }];
    
    [_fillerData addObject:array];
}

@end
