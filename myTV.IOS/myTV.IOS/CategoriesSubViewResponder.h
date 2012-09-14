//
//  CategoriesSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKDemoCell.h"

@interface CategoriesSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>

@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) IBOutlet UIView *categoriesSubView;
@property (nonatomic, strong) KKGridView *categoriesKKGridView;

@end
