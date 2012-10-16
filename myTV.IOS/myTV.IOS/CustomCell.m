//
//  CustomCell.m
//  myTV.IOS
//
//  Created by Johnny on 10/15/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "CustomCell.h"

@implementation CustomCell

@synthesize arrayPrograms;
@synthesize arrayProgramTypes;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
