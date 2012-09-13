#import "KKDemoCell.h"

@implementation KKDemoCell

@synthesize label = _label;

- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if ((self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier])) {
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, self.frame.size.width, self.frame.size.height)];
        _label.backgroundColor = [UIColor lightGrayColor];
        _label.textAlignment = UITextAlignmentCenter;
        [self.contentView addSubview:_label];
    }
    
    return self;
}

@end
