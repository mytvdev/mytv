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
        navigationObserver =[[NSNotificationCenter defaultCenter] addObserverForName:@"ChangeMainSubView" object:nil queue:nil usingBlock:^(NSNotification *note){
            [self handleChangeMainSubView:note];
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

-(void) handleChangeMainSubView:(NSNotification *)note {
    NSString *viewName = [note.userInfo valueForKey:@"view"];
    if(viewName == nil) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Expected Observer Key" message:@"view key not found" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
    }
    else {
        NSDictionary *navItems = [self getNavigationItems];
        NavigationItem *item = [navItems valueForKey:viewName];
        if(item == nil) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"View Navigation item not defined" message:[NSString stringWithFormat:@"define NavigationItem for %@", viewName]delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
        }
        else {
            if([viewName compare:@"categories"] != NSOrderedSame) {
                [navigationData addObject:note.userInfo];
            }
            if(self.activeItem != item) {
                if(item.viewInstance == nil) {
                    item.responderInstance = [[item.subViewResponder alloc] init];
                    NSArray *views = [[NSBundle mainBundle] loadNibNamed:item.nibFilename owner:item.responderInstance options:nil];
                    UIView *view = [views objectAtIndex:0];
                    item.viewInstance = view;
                }
                if(self.activeItem != nil) {
                    if(self.activeItem.activationButton != nil && self.activeItem.activeImage != nil) {
                        [self.activeItem.activationButton setImage:self.activeItem.image forState:UIControlStateNormal];
                    }
                }
                self.activeItem = item;
                
                if ([viewName isEqualToString:@"categories"])
                {
                    [self.categoriesMainview setHidden:NO];
                    
                    if([[self.categoriesMainview subviews] count] > 0) {
                        [[[self.categoriesMainview subviews] objectAtIndex:0] removeFromSuperview];
                    }
                    [self.categoriesMainview addSubview:item.viewInstance];
                    if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                        [item.responderInstance performSelector:@selector(viewDidLoad)];
                    }
                }
                else if ([viewName isEqualToString:@"countries"])
                {
                    [self.countriesMainview setHidden:NO];
                    
                    if([[self.countriesMainview subviews] count] > 0) {
                        [[[self.countriesMainview subviews] objectAtIndex:0] removeFromSuperview];
                    }
                    [self.countriesMainview addSubview:item.viewInstance];
                    if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                        [item.responderInstance performSelector:@selector(viewDidLoad)];
                    }
                }
                else
                {
                    
                    if([[self.mainview subviews] count] > 0) {
                        [[[self.mainview subviews] objectAtIndex:0] removeFromSuperview];
                    }
                    [self.mainview addSubview:item.viewInstance];
                    if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                        [item.responderInstance performSelector:@selector(viewDidLoad)];
                    }
                    
                }
                if(item.activationButton != nil) {
                    [item.activationButton setImage:item.activeImage forState:UIControlStateNormal];
                }
            }
            
            if ([viewName isEqualToString:@"search"])
            {
                if([item.responderInstance respondsToSelector:@selector(bindData:)]){
                    [item.responderInstance performSelector:@selector(bindData:) withObject:note.object];
                }
            }
            else if ([viewName isEqualToString:@"programs"])
            {
                if([item.responderInstance respondsToSelector:@selector(bindData:)]){
                    [item.responderInstance performSelector:@selector(bindData:) withObject:note.object];
                }
            }
            else
            {
                if([note.userInfo count] > 1 && [item.responderInstance respondsToSelector:@selector(bindData:)]){
                    [item.responderInstance performSelector:@selector(bindData:) withObject:note.userInfo];
                }
            }
        }
    }
}

-(void) didReceiveMemoryWarning {
    DLog(@"Cleaning up items");
    NSDictionary *navItems = [self getNavigationItems];
    for (NSString* obj in navItems) {
        NavigationItem *item = [navItems valueForKey:obj];
        if(item != self.activeItem) {
            if(item.viewInstance != nil) {
                [item.viewInstance removeFromSuperview];
               // item.viewInstance dele
                item.viewInstance = nil;
            }
            item.responderInstance = nil;
        }
    }
    [[NSNotificationCenter defaultCenter] removeObserver:navigationObserver];
    navigationObserver =[[NSNotificationCenter defaultCenter] addObserverForName:@"ChangeMainSubView" object:nil queue:nil usingBlock:^(NSNotification *note){
        [self handleChangeMainSubView:note];
    }];
    
    
}

@end
