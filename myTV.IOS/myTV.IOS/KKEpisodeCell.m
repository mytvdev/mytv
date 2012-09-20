//
//  KKEpisodeCell.m
//  myTV.IOS
//
//  Created by Johnny on 9/18/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "KKEpisodeCell.h"

@implementation KKEpisodeCell

@synthesize episode = _episode;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]))
    {
        
    }
    
    return self;
}

-(void)bindEpisode:(Episode *)episode
{
    int xPos = 14;
    MyVODControlResponder *responder = [[MyVODControlResponder alloc] init];
    NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VODControl" owner:responder options:nil];
    UIView *view = [array objectAtIndex:0];
    view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
    xPos = xPos + view.frame.size.width + 14;
    [self.contentView addSubview:view];
    if([responder respondsToSelector:@selector(bindData:)]) {
        [responder performSelector:@selector(bindData:) withObject:episode];
    }
}

@end
