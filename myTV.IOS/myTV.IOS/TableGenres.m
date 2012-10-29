#import "TableGenres.h"
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "MBProgressHUD.h"
#import "IPadViewController.h"

#define DEFAULT_ROW_HEIGHT 26
#define HEADER_HEIGHT 26


@implementation TableGenres

@synthesize sectionArray, openSectionIndex;
//@synthesize fillerData = _fillerData;
@synthesize genresFetcher = _genresFetcher;
@synthesize popoverController, popButton, myCatPopOver;

int startDeceleratingPosition;

- (id)initWithStyleAndGenres:(UITableViewStyle)style genres:(NSArray *)Genres
{
    self = [super initWithStyle:style];
    if (self) {
        self.tableView.bounces = NO;
        self.tableView.scrollEnabled = NO;
        if(Genres == nil) {
            [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
            [RestService RequestGenres:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *genres, NSError *error)
             {
                if(genres != nil && error == nil)
                 {
                     //_fillerData = genres;
        
                     self.sectionArray=[[NSMutableArray alloc]init];
                     //for (Genre *genre in genres) {
                         SectionView *section = [[SectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, DEFAULT_ROW_HEIGHT) title:@"" delegate:self];
        
                         /*section.sectionHeader = genre.Title;
                         section.sectionRows=[[NSMutableArray alloc]init];
                         for (ProgramType *programtype in genre.programTypes) {
                             ProgramTypePrograms *ptp = [[ProgramTypePrograms alloc] init];
                             ptp.ProgramTypeTitle = programtype.Title;
                             ptp.arrayPrograms = programtype.programs;
                             [section.sectionRows addObject:ptp];
                         }
                         [self.sectionArray addObject:section];*/
                     
                     section.sectionHeader = @"Genres";
                     section.sectionRows=[[NSMutableArray alloc]init];
                     for (Genre *genre in Genres){
                         GenreProgramTypes *ptp = [[GenreProgramTypes alloc] init];
                         ptp.genreTitle = genre.Title;
                         ptp.arrayProgramTypes = genre.programTypes;
                         [section.sectionRows addObject:ptp];
                     }
                     [self.sectionArray addObject:section];
                     //}
                 }
                 hasLoadedGenresData = YES;
                 [MBProgressHUD hideHUDForView:self.tableView animated:YES];
             } synchronous:YES];
       }
       else
        {
            self.sectionArray=[[NSMutableArray alloc]init];
            //for (Genre *genre in Genres) {
                SectionView *section = [[SectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, DEFAULT_ROW_HEIGHT) title:@"" delegate:self];
                
                /*section.sectionHeader = genre.Title;
                section.sectionRows=[[NSMutableArray alloc]init];
                for (ProgramType *programtype in genre.programTypes) {
                    ProgramTypePrograms *ptp = [[ProgramTypePrograms alloc] init];
                    ptp.ProgramTypeTitle = programtype.Title;
                    ptp.arrayPrograms = programtype.programs;
                    [section.sectionRows addObject:ptp];
                }
                [self.sectionArray addObject:section];*/
                
                section.sectionHeader = @"Genres";
                section.sectionRows=[[NSMutableArray alloc]init];
                for (Genre *genre in Genres){
                    GenreProgramTypes *ptp = [[GenreProgramTypes alloc] init];
                    ptp.genreTitle = genre.Title;
                    ptp.arrayProgramTypes = genre.programTypes;
                    [section.sectionRows addObject:ptp];
                }
                [self.sectionArray addObject:section];
            //}
        }
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.sectionHeaderHeight = HEADER_HEIGHT;
    self.openSectionIndex = NSNotFound;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self.popoverController dismissPopoverAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    //NSLog(@"Will begin dragging");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"Did Scroll");
    //NSLog([NSString stringWithFormat:@"%d", scrollView.contentOffset.y]);
}

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    startDeceleratingPosition = scrollView.contentOffset.y;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    //NSLog(@"scrollViewWillEndDragging");
    //CGFloat unguidedOffsetY = targetContentOffset->y;
    //NSLog(@"Remainder: %d", scrollView.contentOffset.y);
    
    /*CGFloat guidedOffsetY;
    
    if (unguidedOffsetY > kFirstStateTableViewOffsetHeight) {
        int remainder = lroundf(unguidedOffsetY) % lroundf(kStateTableCell_Height_Unrotated);
        NSLog(@"Remainder: %d", remainder);
        if (remainder < (kStateTableCell_Height_Unrotated/2)) {
            guidedOffsetY = unguidedOffsetY - remainder;
        }
        else {
            guidedOffsetY = unguidedOffsetY - remainder + kStateTableCell_Height_Unrotated;
        }
    }
    else {11
        guidedOffsetY = 0;
    }*/
    
    //targetContentOffset->y = scrollView.contentOffset.y;

}


#pragma mark - Table view data source
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    /*
     Create the section header views lazily.
     */
	SectionView *aSection=[sectionArray objectAtIndex:section];
    if (!aSection.sectionHeaderView) {
        aSection.sectionHeaderView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, HEADER_HEIGHT) title:aSection.sectionHeader section:section delegate:self];
        
    }
    [aSection.sectionHeaderView toggleOpenWithUserAction:YES];
    return aSection.sectionHeaderView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    
    return [self.sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    SectionView *aSection=[sectionArray objectAtIndex:section];
    // Return the number of rows in the section.
    return aSection.open ? [aSection.sectionRows count]:0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_ROW_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%@",indexPath);
    SectionView *aSection=[sectionArray objectAtIndex:indexPath.section];
    static NSString *CellIdentifier = @"CustomCell";
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    //cell.frame.size = CGSizeMake(Genres_Width, Genres_Height);
    cell.arrayProgramTypes = ((GenreProgramTypes *)([aSection.sectionRows objectAtIndex:indexPath.row])).arrayProgramTypes;
    cell.textLabel.text = ((GenreProgramTypes *)([aSection.sectionRows objectAtIndex:indexPath.row])).genreTitle;
    [cell.textLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    
    UIImageView *brickAnim = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightbg.png"]];
    brickAnim.frame = cell.frame;
    
    cell.backgroundView = brickAnim;
                 
    return cell;
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionOpened:(NSInteger)sectionOpened {
    
    SectionView *aSection=[sectionArray objectAtIndex:sectionOpened];
    aSection.open=YES;
    
    /*
     Create an array containing the index paths of the rows to insert: These correspond to the rows for each quotation in the current section.
     */
    NSInteger countOfRowsToInsert = [aSection.sectionRows count];
    NSMutableArray *indexPathsToInsert = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < countOfRowsToInsert; i++) {
        [indexPathsToInsert addObject:[NSIndexPath indexPathForRow:i inSection:sectionOpened]];
    }
    
    /*
     Create an array containing the index paths of the rows to delete: These correspond to the rows for each quotation in the previously-open section, if there was one.
     */
    NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
    
    NSInteger previousOpenSectionIndex = self.openSectionIndex;
    if (previousOpenSectionIndex != NSNotFound) {
        SectionView *previousOpenSection=[sectionArray objectAtIndex:previousOpenSectionIndex];
        previousOpenSection.open=NO;
        [previousOpenSection.sectionHeaderView toggleOpenWithUserAction:NO];
        NSInteger countOfRowsToDelete = [previousOpenSection.sectionRows count];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:previousOpenSectionIndex]];
        }
    }
    
    // Style the animation so that there's a smooth flow in either direction.
    UITableViewRowAnimation insertAnimation;
    UITableViewRowAnimation deleteAnimation;
    if (previousOpenSectionIndex == NSNotFound || sectionOpened < previousOpenSectionIndex) {
        insertAnimation = UITableViewRowAnimationTop;
        deleteAnimation = UITableViewRowAnimationBottom;
    }
    else {
        insertAnimation = UITableViewRowAnimationBottom;
        deleteAnimation = UITableViewRowAnimationTop;
    }
    
    // Apply the updates.
    [self.tableView beginUpdates];
    [self.tableView insertRowsAtIndexPaths:indexPathsToInsert withRowAnimation:insertAnimation];
    [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:deleteAnimation];
    [self.tableView endUpdates];
    self.openSectionIndex = sectionOpened;
    
    CGRect frame = self.tableView.frame;
    frame.size.height += (countOfRowsToInsert * DEFAULT_ROW_HEIGHT);
    self.view.frame = frame;
    
    CGPoint scrollPoint = frame.origin;
    scrollPoint.y = (self.openSectionIndex * DEFAULT_ROW_HEIGHT);
    [self.tableView setContentOffset:scrollPoint animated:YES];
}

-(void)sectionHeaderView:(SectionHeaderView*)sectionHeaderView sectionClosed:(NSInteger)sectionClosed {
    
    /*
     Create an array of the index paths of the rows in the section that was closed, then delete those rows from the table view.
     */
	SectionView *aSection = [self.sectionArray objectAtIndex:sectionClosed];
	
    aSection.open = NO;
    
    NSInteger countOfRowsToDelete = [self.tableView numberOfRowsInSection:sectionClosed];
    
    if (countOfRowsToDelete > 0) {
        NSMutableArray *indexPathsToDelete = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < countOfRowsToDelete; i++) {
            [indexPathsToDelete addObject:[NSIndexPath indexPathForRow:i inSection:sectionClosed]];
        }
        [self.tableView deleteRowsAtIndexPaths:indexPathsToDelete withRowAnimation:UITableViewRowAnimationTop];
    }
    self.openSectionIndex = NSNotFound;
    
    CGRect frame = self.tableView.frame;
    frame.size.height -= (countOfRowsToDelete * DEFAULT_ROW_HEIGHT);
    self.view.frame = frame;
    
    CGPoint scrollPoint = frame.origin;
    scrollPoint.y = 0;
    [self.tableView setContentOffset:scrollPoint animated:YES];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //CustomCell *cell = (CustomCell *)([tableView cellForRowAtIndexPath:indexPath]);
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:cell.arrayPrograms userInfo:@{ MyTV_ViewArgument_View : MyTV_View_Programs }];
    
    CustomCell *cell = (CustomCell *)([tableView cellForRowAtIndexPath:indexPath]);
    
    myCatPopOver = [[ProgramTypesSubViewResponder alloc] initWithNibNameAndProgramTypes:@"ProgramTypesSubView" bundle:nil programtypes:cell.arrayProgramTypes];
    popoverController = [[UIPopoverController alloc] initWithContentViewController:myCatPopOver];
    popoverController.popoverContentSize = CGSizeMake(112.f, 300.f);
    
    //present the popover view non-modal with a
    //refrence to the button pressed within the current view
    [self.popoverController presentPopoverFromRect:cell.frame
                                            inView:self.view
                          permittedArrowDirections:UIPopoverArrowDirectionAny
                                          animated:YES];
}

@end
