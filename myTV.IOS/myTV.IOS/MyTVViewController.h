//
//  MyTVViewController.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationLogic.h"
#import "MyTVPlayer.h"

@interface MyTVViewController : UIViewController

@property NavigationLogic *navigationLogic;
@property MyTVPlayer *player;

@end
