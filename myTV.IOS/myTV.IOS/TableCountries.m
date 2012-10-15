#import "TableCountries.h"
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "MBProgressHUD.h"

#define DEFAULT_ROW_HEIGHT 26
#define HEADER_HEIGHT 26

@implementation TableCountries

@synthesize sectionArray, openSectionIndex;
@synthesize fillerData = _fillerData;
@synthesize countriesFetcher = _countriesFetcher;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        if(!hasLoadedCountriesData) {
            [MBProgressHUD showHUDAddedTo:self.tableView animated:YES];
            [RestService RequestCountries:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *countries, NSError *error)
             {
                 if(countries != nil && error == nil)
                 {
                     _fillerData = countries;
                     
                     self.sectionArray=[[NSMutableArray alloc]init];
                     for (Country *country in countries) {
                         SectionView *sectionCountry = [[SectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, DEFAULT_ROW_HEIGHT) title:@"" delegate:self];
                         sectionCountry.sectionHeader = country.Title;
                         sectionCountry.sectionRows=[[NSMutableArray alloc]init];
                         sectionCountry.sectionType = @"country";
                         for (Genre *genre in country.genres) {
                             SectionView *sectionGenre = [[SectionView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, DEFAULT_ROW_HEIGHT) title:@"" delegate:self];
                             sectionGenre.sectionHeader = genre.Title;
                             sectionGenre.sectionRows=[[NSMutableArray alloc]init];
                             sectionGenre.sectionType = @"genre";
                             for (ProgramType *programtype in genre.programTypes) {
                                 UIImage *redButtonImage = [UIImage imageNamed:@"lightbg.png"];
                                 UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
                                 redButton.frame = CGRectMake(0, 0, 112.0, 26.0);
                                 [redButton setBackgroundImage:redButtonImage forState:UIControlStateNormal];
                                 [redButton.titleLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
                                 [redButton setTitle:programtype.Title forState:UIControlStateNormal];
                                 [sectionGenre.sectionRows addObject:redButton];
                             }
                             [sectionCountry.sectionRows addObject:sectionGenre];
                         }
                         [self.sectionArray addObject:sectionCountry];
                     }
                 }
                 hasLoadedCountriesData = YES;
                 [MBProgressHUD hideHUDForView:self.tableView animated:YES];
             } synchronous:YES];
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
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - Table view data source
-(UIView*)tableView:(UITableView*)tableView viewForHeaderInSection:(NSInteger)section {
    
    /*
     Create the section header views lazily.
     */
	SectionView *aSection = [sectionArray objectAtIndex:section];
    if (!aSection.sectionHeaderView) {
        aSection.sectionHeaderView = [[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, HEADER_HEIGHT) title:aSection.sectionHeader section:section delegate:self];
    }
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    NSLog(@"%@",indexPath);
    SectionView *aSection=[sectionArray objectAtIndex:indexPath.section];
    UITableViewCell *cell = nil;
    static NSString *CellIdentifier = @"Cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (aSection.sectionType == @"country") {
        SectionView *secView = ((SectionView *)([aSection.sectionRows objectAtIndex:indexPath.row]));
        SectionHeaderView *secHView =[[SectionHeaderView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.tableView.bounds.size.width, HEADER_HEIGHT) title:secView.sectionHeader section:indexPath.row delegate:self];
        [cell.contentView addSubview:secHView];
    }
    else
    {
        // Configure the cell...
        cell.textLabel.text = ((UIButton *)([aSection.sectionRows objectAtIndex:indexPath.row])).titleLabel.text;
        [cell.textLabel setFont:[UIFont boldSystemFontOfSize:12.0]];
    
        UIImageView *brickAnim = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"lightbg.png"]];
        brickAnim.frame = cell.frame;
    
        cell.backgroundView = brickAnim;
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return DEFAULT_ROW_HEIGHT;
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
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SectionView *aSection=[sectionArray objectAtIndex:indexPath.section];
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Play Channel" message:[NSString stringWithFormat:@"Do you want to check %@?", aSection.sectionHeader] delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [view show];
}

@end
