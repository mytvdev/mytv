//
//  SearchSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 10/10/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKSearchCell.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"

#define SearchControl_Space 1
#define SearchControl_Width 450
#define SearchControl_Height 115

@interface SearchSubViewResponder : SubViewResponder

@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *SearchScrollView;
@property (readonly) DataFetcher *searchFetcher;

@end
