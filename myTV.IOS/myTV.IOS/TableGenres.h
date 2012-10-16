#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "CustomCell.h"
#import "ProgramTypePrograms.h"

@class IPadViewController;

@interface TableGenres : UITableViewController<SectionHeaderViewDelegate, SectionViewDelegate> {
    BOOL hasLoadedGenresData;
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
//Genres@property (nonatomic, strong) NSArray *fillerData;
@property (readonly) DataFetcher *genresFetcher;

- (id)initWithStyleAndGenres:(UITableViewStyle)style genres:(NSArray *)Genres;

@end
