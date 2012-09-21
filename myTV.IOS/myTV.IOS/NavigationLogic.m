//
//  NavigationLogic.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "NavigationLogic.h"

@implementation NavigationLogic

@synthesize mainview;
@synthesize categoriesMainview;
@synthesize countriesMainview;

- (id)init {
    self = [super init];
    logicItems = [[NSMutableDictionary alloc] init];
    navigationData = [[NSMutableArray alloc] init];
    return self;
}

- (void) addNavigationItem:(NavigationItem *)item {
    [logicItems setValue:item forKey:item.key];
}

- (NSDictionary *) getNavigationItems {
    return [NSDictionary dictionaryWithDictionary:logicItems];
}


- (void) startHandlingNavigation {
    if (!isListening) {
        isListening = YES;
        NavigationLogic *logic = self;
        navigationObserver =[[NSNotificationCenter defaultCenter] addObserverForName:@"ChangeMainSubView" object:nil queue:nil usingBlock:^(NSNotification *note){
            NSString *viewName = [note.userInfo valueForKey:@"view"];
            if(viewName == nil) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expected Observer Key" message:@"view key not found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                [alert show];
            }
            else {
                NSDictionary *navItems = [logic getNavigationItems];
                NavigationItem *item = [navItems valueForKey:viewName];
                if(item == nil) {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"View Navigation item not defined" message:[NSString stringWithFormat:@"define NavigationItem for %@", viewName]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                    [alert show];
                }
                else {
                    if([viewName compare:@"categories"] != NSOrderedSame) {
                        [navigationData addObject:note.userInfo];
                    }
                    if(logic.activeItem != item) {
                        if(item.viewInstance == nil) {
                            item.responderInstance = [[item.subViewResponder alloc] init];
                            NSArray *views = [[NSBundle mainBundle] loadNibNamed:item.nibFilename owner:item.responderInstance options:nil];
                            UIView *view = [views objectAtIndex:0];
                            item.viewInstance = view;
                        }
                        if(logic.activeItem != nil) {
                            if(logic.activeItem.activationButton != nil && logic.activeItem.activeImage != nil) {
                                [logic.activeItem.activationButton setImage:logic.activeItem.image forState:UIControlStateNormal];
                            }
                        }
                        logic.activeItem = item;
                        
                        if ([viewName isEqualToString:@"categories"])
                        {
                            [logic.categoriesMainview setHidden:NO];
                            
                            if([[logic.categoriesMainview subviews] count] > 0) {
                                [[[logic.categoriesMainview subviews] objectAtIndex:0] removeFromSuperview];
                            }
                            [logic.categoriesMainview addSubview:item.viewInstance];
                            if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                                [item.responderInstance performSelector:@selector(viewDidLoad)];
                            }
                        }
                        else if ([viewName isEqualToString:@"countries"])
                        {
                            [logic.countriesMainview setHidden:NO];
                            
                            if([[logic.countriesMainview subviews] count] > 0) {
                                [[[logic.countriesMainview subviews] objectAtIndex:0] removeFromSuperview];
                            }
                            [logic.countriesMainview addSubview:item.viewInstance];
                            if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                                [item.responderInstance performSelector:@selector(viewDidLoad)];
                            }
                        }
                        else
                        {
                            
                            if([[logic.mainview subviews] count] > 0) {
                                [[[logic.mainview subviews] objectAtIndex:0] removeFromSuperview];
                            }
                            [logic.mainview addSubview:item.viewInstance];
                            if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                                [item.responderInstance performSelector:@selector(viewDidLoad)];
                            }
                           
                        }
                        if(item.activationButton != nil) {
                            [item.activationButton setImage:item.activeImage forState:UIControlStateNormal];
                        }
                    }
                    if([note.userInfo count] > 1 && [item.responderInstance respondsToSelector:@selector(bindData:)]){
                        [item.responderInstance performSelector:@selector(bindData:) withObject:note.userInfo];
                    }
                }
            }
            
        }];
        
        navBackObserver = [[NSNotificationCenter defaultCenter] addObserverForName:MyTV_Event_PopView object:nil queue:nil usingBlock:^(NSNotification *note){
            [navigationData removeLastObject];
            NSDictionary *data = [navigationData objectAtIndex:([navigationData count] - 1)];
            [navigationData removeObject:data];
            [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:data];
        }];
    }
}

-(void) dealloc {
    if(navigationObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:navigationObserver];
        [[NSNotificationCenter defaultCenter] removeObject:navBackObserver];
    }
}

@end
