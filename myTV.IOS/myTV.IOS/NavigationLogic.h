//
//  NavigationLogic.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NavigationItem.h"

@interface NavigationLogic : NSObject
{
    NSMutableDictionary *logicItems;
    NSMutableArray *nibs;
    BOOL isListening;
    id navigationObserver;
    id navBackObserver;
    NSMutableArray *navigationData;
}

@property UIView *mainview;
@property UIView *categoriesMainview;
@property UIView *countriesMainview;
@property NavigationItem *activeItem; 

- (id) init;
- (void) addNavigationItem:(NavigationItem *)item;
- (void) startHandlingNavigation;
- (NSDictionary *) getNavigationItems;

@end
