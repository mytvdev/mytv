#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"

@interface TableGenres : UITableViewController<SectionHeaderViewDelegate> {
    BOOL hasLoadedGenresData;
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSArray *fillerData;

@end
