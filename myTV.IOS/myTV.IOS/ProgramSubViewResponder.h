//
//  ProgramSubViewResponder.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/17/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"

@interface ProgramSubViewResponder : SubViewResponder
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblProgramName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgProgram;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *episodeScrollView;

@end
