#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "CustomCell.h"
#import "GenreProgramTypes.h"
#import "ProgramTypesSubViewResponder.h"


@interface TableCountries : UITableViewController<SectionHeaderViewDelegate, SectionViewDelegate> {
    BOOL hasLoadedCountriesData;
    UIPopoverController *popoverController;
    ProgramTypesSubViewResponder *myCatPopOver;
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSArray *fillerData;
@property (readonly) DataFetcher *countriesFetcher;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *popButton;
@property (nonatomic, retain) ProgramTypesSubViewResponder *myCatPopOver;

- (id)initWithStyleAndCountries:(UITableViewStyle)style countries:(NSArray *)Countries;

@end