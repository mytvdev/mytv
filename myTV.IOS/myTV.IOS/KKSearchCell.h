//
//  KKSearchCell.h
//  myTV.IOS
//
//  Created by Johnny on 10/5/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <KKGridView/KKGridView.h>
#import "SearchControlResponder.h"

@interface KKSearchCell : KKGridViewCell
@property (nonatomic, strong) Episode *itemBase;
@end
