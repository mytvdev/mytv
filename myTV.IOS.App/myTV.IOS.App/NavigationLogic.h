//
//  NavigationLogic.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationItem.h"

@interface NavigationLogic : NSObject
{
    NSMutableDictionary *logicItems;
    NSMutableArray *nibs;
    BOOL isListening;
}

@property UIView *mainview;
@property NavigationItem *activeItem;

- (id) init;
- (void) addNavigationItem:(NavigationItem *)item;
- (void) startHandlingNavigation;
- (NSDictionary *) getNavigationItems;

@end