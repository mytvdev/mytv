#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "CustomCell.h"
#import "ProgramTypePrograms.h"
#import "ProgramTypesSubViewResponder.h"

@class IPadViewController;

@interface TableGenres : UITableViewController<SectionHeaderViewDelegate, SectionViewDelegate> {
    BOOL hasLoadedGenresData;
    UIPopoverController *popoverController;
    ProgramTypesSubViewResponder *myCatPopOver;
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
//Genres@property (nonatomic, strong) NSArray *fillerData;
@property (readonly) DataFetcher *genresFetcher;

@property (nonatomic, retain) UIPopoverController *popoverController;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *popButton;
@property (nonatomic, retain) ProgramTypesSubViewResponder *myCatPopOver;

- (id)initWithStyleAndGenres:(UITableViewStyle)style genres:(NSArray *)Genres;

@end
