//
//  NavigationItem.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationItem : NSObject

@property (readonly) NSString *key;
@property (readonly) Class subViewResponder;
@property (readonly) NSString *nibFilename;
@property (unsafe_unretained) UIButton *activationButton;
@property (readonly) UIImage *activeImage;
@property (readonly) UIImage *image;
@property UIView *viewInstance;
@property NSObject *responderInstance;

- (id) initWithKey:(NSString *)key forNib:(NSString *)nib usingClass:(Class)className button:(UIButton *)button displayImage:(UIImage *)image displayActiveImage:(UIImage *)activeImage;

@end
