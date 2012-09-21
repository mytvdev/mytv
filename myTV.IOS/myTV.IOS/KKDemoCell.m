//
//  KKDemoCell.m
//  myTV.IOS
//
//  Created by Johnny on 9/14/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "KKDemoCell.h"

@implementation KKDemoCell

@synthesize label = _label;
@synthesize button = _button;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(1.f, 1.f, self.frame.size.width, 20.f)];
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = UITextAlignmentCenter;
        _label.textColor = [UIColor whiteColor];
        _label.numberOfLines = 2;
        _label.font = [UIFont fontWithName:@"Arial" size:12];
        _label.lineBreakMode = UILineBreakModeWordWrap;

        _label.adjustsFontSizeToFitWidth = YES;
        [self.contentView addSubview:_label];
        
        _button = [[UIButton alloc] initWithFrame:CGRectMake(1.f, 1.f, self.frame.size.width, 20.f)];
        _button.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_button];
    }
    
    return self;
}

@end
