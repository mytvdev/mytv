//
//  KKSearchCell.m
//  myTV.IOS
//
//  Created by Johnny on 10/5/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "KKSearchCell.h"

@implementation KKSearchCell

@synthesize itemBase = _itemBase;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

-(void)bindItemBase:(Episode *)itemBase
{
    int xPos = 14;
    SearchControlResponder *responder = [[SearchControlResponder alloc] init];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"SearchControl" owner:responder options:nil];
    UIView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
    xPos  += view.frame.size.width + 14;
    [self.contentView addSubview:view];
    if([responder respondsToSelector:@selector(bindData:)]) {
        [responder performSelector:@selector(bindData:) withObject:itemBase];
    }
}

@end
