#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "SectionView.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"

@interface TableGenres : UITableViewController<SectionHeaderViewDelegate, SectionViewDelegate> {
    BOOL hasLoadedGenresData;
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSArray *fillerData;
@property (readonly) DataFetcher *genresFetcher;

@end
