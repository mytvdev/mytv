//
//  NavigationItem.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "NavigationItem.h"

@implementation NavigationItem

@synthesize key = _key;
@synthesize subViewResponder = _subViewResponder;
@synthesize nibFilename = _nibFilename;
@synthesize activeImage = _activeImage;
@synthesize image = _image;
@synthesize activationButton = _activationButton;
@synthesize viewInstance, responderInstance;

- (id) initWithKey:(NSString *)key forNib:(NSString *)nib usingClass:(Class)className button:(UIButton *)button displayImage:(UIImage *)image displayActiveImage:(UIImage *)activeImage {
    self = [super init];
    _key = key;
    _nibFilename = nib;
    _subViewResponder = className;
    _activationButton = button;
    _image = image;
    _activeImage = activeImage;
    return self;
}

@end
