#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKDemoCell.h"

@interface CategoriesSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) IBOutlet UIView *categoriesSubView;
@property (nonatomic, strong) KKGridView *categoriesKKGridView;

@end
