//
//  KKVODPackageCell.h
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <KKGridView/KKGridView.h>
#import "VODPackageControlResponder.h"

@interface KKVODPackageCell : KKGridViewCell

@property (nonatomic, strong) VODPackage *vodPackage;

@end
