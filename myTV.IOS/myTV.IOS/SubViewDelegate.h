//
//  SubViewDelegate.h
//  myTV.IOS
//
//  Created by myTV Inc. on 9/12/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewResponder.h"

@protocol SubViewDelegate <NSObject>

@optional

-(void)viewDidLoad;
-(void)viewDidUnload;
-(void)abortOperatons;
-(void)bindData:(NSObject *)data;

@end
