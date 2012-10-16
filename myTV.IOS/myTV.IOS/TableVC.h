#import <UIKit/UIKit.h>
#import "SectionHeaderView.h"
#import "ProgramType.h"
#import "ProgramTypePrograms.h"
#import "CustomCell.h"

@interface TableVC : UITableViewController<SectionHeaderViewDelegate> {
    
    
}

@property (nonatomic, strong) NSMutableArray *sectionArray;
@property (nonatomic, assign) NSInteger openSectionIndex;
@property (nonatomic, strong) NSMutableArray *arrayProgramTypes;

- (id)initWithProgramTypes:(NSMutableArray *)ProgramTypes;

@end
