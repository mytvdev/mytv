//
//  SubViewDelegate.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/12/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SubViewResponder.h"

@protocol SubViewDelegate <NSObject>

@optional

-(void)viewDidLoad;
-(void)viewDidUnload;
-(void)abortOperatons;

@end
