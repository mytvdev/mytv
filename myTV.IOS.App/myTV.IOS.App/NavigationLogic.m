//
//  NavigationLogic.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "NavigationLogic.h"

@implementation NavigationLogic

@synthesize mainview;

- (id)init {
    self = [super init];
    logicItems = [[NSMutableDictionary alloc] init];
    return self;
}

- (void) addNavigationItem:(NavigationItem *)item {
    [logicItems setValue:item forKey:item.key];
}

- (void) startHandlingNavigation {
    if (!isListening) {
        isListening = YES;
        
    }
}

@end
