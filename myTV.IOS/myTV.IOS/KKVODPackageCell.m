//
//  KKVODPackageCell.m
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "KKVODPackageCell.h"

@implementation KKVODPackageCell

@synthesize vodPackage = _vodPackage;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

-(void)bindVODPackage:(VODPackage *)vodPackage
{
    int xPos = 14;
    /*ChannelControlResponder *responder = [[ChannelControlResponder alloc] init];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
    UIView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
    xPos  += view.frame.size.width + ChannelControl_Space;
    [self.contentView addSubview:view];
    if([responder respondsToSelector:@selector(bindData:)]) {
        [responder performSelector:@selector(bindData:) withObject:channel];
    }*/
}

@end
