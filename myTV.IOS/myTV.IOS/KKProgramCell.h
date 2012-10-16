//
//  KKProgramCell.h
//  myTV.IOS
//
//  Created by Johnny on 10/15/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <KKGridView/KKGridView.h>
#import "MyVODControlResponder.h"

@interface KKProgramCell : KKGridViewCell

@property (nonatomic, strong) MyTVProgram *program;

@end
