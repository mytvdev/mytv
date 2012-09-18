//
//  KKChannelCell.h
//  myTV.IOS
//
//  Created by Johnny on 9/18/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <KKGridView/KKGridView.h>
#import "ChannelControlResponder.h"

@interface KKChannelCell : KKGridViewCell
@property (nonatomic, strong) Channel *channel;
@end
