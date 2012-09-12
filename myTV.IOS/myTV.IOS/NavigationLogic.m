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
@synthesize categorieMainview;

- (id)init {
    self = [super init];
    logicItems = [[NSMutableDictionary alloc] init];
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
        [[NSNotificationCenter defaultCenter] addObserverForName:@"ChangeMainSubView" object:nil queue:nil usingBlock:^(NSNotification *note){
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
                            if([[logic.categorieMainview subviews] count] > 0) {
                                [[[logic.categorieMainview subviews] objectAtIndex:0] removeFromSuperview];
                            }
                            
                            [logic.categorieMainview addSubview:item.viewInstance];
                            
                            if([item.responderInstance respondsToSelector:@selector(viewDidLoad)]) {
                                [item.responderInstance performSelector:@selector(viewDidLoad)];
                            }
                            
                            if(logic.categorieMainview.hidden == YES)
                                [logic.categorieMainview setHidden:NO];
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
                }
            }
            
        }];
    }
}


@end
