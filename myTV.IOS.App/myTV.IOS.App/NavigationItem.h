//
//  NavigationItem.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NavigationItem : NSObject

@property (readonly) NSString *key;
@property (readonly) Class subViewResponder;
@property (readonly) NSString *nibFilename;
@property (unsafe_unretained) UIButton *activationButton;
@property (readonly) UIImage *activeImage;
@property (readonly) UIImage *image;
@property NSObject *viewInstance;
@property NSObject *responderInstance;

- (id) initWithKey:(NSString *)key forNib:(NSString *)nib usingClass:(Class)className button:(UIButton *)button displayImage:(UIImage *)image displayActiveImage:(UIImage *)activeImage;

@end
