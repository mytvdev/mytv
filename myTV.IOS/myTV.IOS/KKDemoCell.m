//
//  KKDemoCell.m
//  myTV.IOS
//
//  Created by Johnny on 9/14/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "KKDemoCell.h"

@implementation KKDemoCell

@synthesize label = _label;
@synthesize button = _button;
@synthesize cSubView;

@synthesize delegate = _delegate;
@synthesize indexCellPath = _indexCellPath;

@synthesize isBackButton;

- (id) initWithCells:(BOOL)SetIsCountryCell IsCountryGenreCell:(BOOL)SetIsCountryGenreCell IsCountryProgramTypeCell:(BOOL)SetIsCountryProgramTypeCell IsGenreCell:(BOOL)SetIsGenreCell SetIsGenreProgramTypeCell:(BOOL)SetIsGenreProgramTypeCell {
    isCountryCell = SetIsCountryCell;
    isCountryGenreCell = SetIsCountryGenreCell;
    isCountryProgramTypeCell = SetIsCountryProgramTypeCell;
    isGenreCell = SetIsGenreCell;
    isGenreProgramTypeCell = SetIsGenreProgramTypeCell;
    
    _button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
    _button.backgroundColor = [UIColor clearColor];
    _button.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
    
    if (isGenreCell | isCountryGenreCell)
        [_button addTarget:self action:@selector(fillProgramTypes:) forControlEvents:UIControlEventTouchDown];
    else if (isCountryCell)
        [_button addTarget:self action:@selector(fillGenres:) forControlEvents:UIControlEventTouchDown];
    [self.contentView addSubview:_button];
    
    return self;
}

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

- (void)fillProgramTypes:(id)sender
{
    [self.delegate fillProgramTypes:self];
}

- (void)fillGenres:(id)sender
{
    [self.delegate fillGenres:self];
}

- (void)ReloadGenres:(id)sender
{
    [self.delegate ReloadGenres:self];
}

@end
