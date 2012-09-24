//
//  KKDemoCell.h
//  myTV.IOS
//
//  Created by Johnny on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <KKGridView/KKGridView.h>

@protocol MyKKDemoCellDelegate;

@interface KKDemoCell : KKGridViewCell
{
    BOOL isCountryCell;
    BOOL isCountryGenreCell;
    BOOL isCountryProgramTypeCell;
    BOOL isGenreCell;
    BOOL isGenreProgramTypeCell;
}

- (id) initWithCells:(BOOL)SetIsCountryCell IsCountryGenreCell:(BOOL)SetIsCountryGenreCell IsCountryProgramTypeCell:(BOOL)SetIsCountryProgramTypeCell IsGenreCell:(BOOL)SetIsGenreCell SetIsGenreProgramTypeCell:(BOOL)SetIsGenreProgramTypeCell;

#pragma mark - Properties

@property (nonatomic, unsafe_unretained) id <MyKKDemoCellDelegate> delegate;
@property (nonatomic, retain) KKIndexPath *indexCellPath;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, strong) IBOutlet UIView *cSubView;
@property (nonatomic, strong) IBOutlet UIButton *button;
@property (nonatomic, assign) BOOL isBackButton;

@end

@protocol MyKKDemoCellDelegate <NSObject>;

- (void)fillProgramTypes:(KKDemoCell *)cell;
- (void)fillGenres:(KKDemoCell *)cell;
- (void)ReloadGenres:(KKDemoCell *)cell;

@end
