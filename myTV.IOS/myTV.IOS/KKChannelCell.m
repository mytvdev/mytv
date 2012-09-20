//
//  KKChannelCell.m
//  myTV.IOS
//
//  Created by Johnny on 9/18/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "KKChannelCell.h"

@implementation KKChannelCell

@synthesize channel = _channel;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

-(void)bindChannel:(Channel *)channel
{
    int xPos = ChannelControl_Space;
    ChannelControlResponder *responder = [[ChannelControlResponder alloc] init];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
    UIView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
    xPos = xPos + view.frame.size.width + ChannelControl_Space;
    [self.contentView addSubview:view];
    if([responder respondsToSelector:@selector(bindData:)]) {
        [responder performSelector:@selector(bindData:) withObject:channel];
    }
}

@end
