//
//  KKProgramCell.m
//  myTV.IOS
//
//  Created by Johnny on 10/15/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "KKProgramCell.h"

@implementation KKProgramCell

@synthesize program = _program;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

-(void)bindProgram:(MyTVProgram *)program
{
    int xPos = 14;
    MyVODControlResponder *responder = [[MyVODControlResponder alloc] init];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VODControl" owner:responder options:nil];
    UIView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
    xPos = xPos + view.frame.size.width + 14;
    [self.contentView addSubview:view];
    if([responder respondsToSelector:@selector(bindData:)]) {
        [responder performSelector:@selector(bindData:) withObject:program];
    }
}
@end
