//
//  KKEpisodeCell.h
//  myTV.IOS
//
//  Created by Johnny on 9/18/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <KKGridView/KKGridView.h>
#import "VODControlResponder.h"

@interface KKEpisodeCell : KKGridViewCell

@property (nonatomic, strong) Episode *episode;

@end
