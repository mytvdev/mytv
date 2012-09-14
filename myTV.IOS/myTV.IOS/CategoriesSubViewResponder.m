#import "CategoriesSubViewResponder.h"

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize categoriesSubView;
@synthesize categoriesKKGridView;

-(void)viewDidLoad {
    _fillerData = [[NSMutableArray alloc] init];
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSUInteger j = 0; j < 10; j++)
    {
        [array addObject:[NSString stringWithFormat:@"%u", j]];
    }
    
    [_fillerData addObject:array];
    
    
    categoriesKKGridView = [[KKGridView alloc] initWithFrame:self.categoriesSubView.bounds];
    categoriesKKGridView.dataSource = self;
    categoriesKKGridView.delegate = self;
    
    categoriesKKGridView.scrollsToTop = YES;
    categoriesKKGridView.backgroundColor = [UIColor darkGrayColor];
    categoriesKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    categoriesKKGridView.cellSize = CGSizeMake(75.f, 75.f);
    categoriesKKGridView.cellPadding = CGSizeMake(4.f, 4.f);
    
    categoriesKKGridView.allowsMultipleSelection = NO;
    
    [categoriesKKGridView reloadData];
    
    self.categoriesSubView = categoriesKKGridView;
}


#pragma mark - KKGridViewDataSource

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
