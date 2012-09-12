//
//  KKDemoCell.m
//  TestKKGrid
//
//  Created by Johnny on 9/12/12.
//  Copyright (c) 2012 Johnny. All rights reserved.
//

#import "KKDemoCell.h"

@implementation KKDemoCell

@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, 14.f)];
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    
    return self;
}

@end
