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

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        if (isBackButton) {
            _button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 24.f, 24.f)];
            _button.backgroundColor = [UIColor clearColor];
            _button.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [_button addTarget:self action:@selector(ReloadGenres:) forControlEvents:UIControlEventTouchDown];
            //UIImage *backButtonImage = [UIImage imageNamed:@"backward.png"];
            //[_button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
        }
        else
        {
            _button = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
            _button.backgroundColor = [UIColor clearColor];
            _button.titleLabel.font = [UIFont fontWithName:@"Arial" size:12];
            [_button addTarget:self action:@selector(fillProgramTypes:) forControlEvents:UIControlEventTouchDown];
        }
        [self.contentView addSubview:_button];
    }
    
    return self;
}

- (void)fillProgramTypes:(id)sender
{
    [self.delegate fillProgramTypes:self];
}

- (void)ReloadGenres:(id)sender
{
    [self.delegate ReloadGenres:self];
}

@end
