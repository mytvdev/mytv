#import <Foundation/Foundation.h>
#import "SectionHeaderView.h"

@protocol SectionViewDelegate;

@interface SectionView : UIView

@property (nonatomic, nonatomic) UILabel *titleLabel;
@property (nonatomic, nonatomic) UIButton *disclosureButton;
//@property (nonatomic, assign) NSInteger section;
@property (nonatomic, nonatomic) id <SectionViewDelegate> delegate;
@property (nonatomic, strong) SectionHeaderView *sectionHeaderView;
@property (nonatomic, strong) NSString *sectionHeader;
@property (nonatomic, strong) NSMutableArray *sectionRows;
@property (nonatomic) BOOL open;
@property (nonatomic, strong) NSString *sectionType;

-(id)initWithFrame:(CGRect)frame title:(NSString*)title delegate:(id <SectionViewDelegate>)delegate;
-(void)toggleOpenWithUserAction:(BOOL)userAction;

@end



/*
 Protocol to be adopted by the section header's delegate; the section header tells its delegate when the section should be opened and closed.
 */
@protocol SectionViewDelegate <NSObject>

@optional
-(void)sectionView:(SectionView*)sectionView sectionOpened:(NSInteger)section;
-(void)sectionView:(SectionView*)sectionView sectionClosed:(NSInteger)section;

@end
