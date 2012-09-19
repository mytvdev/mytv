//
//  ProgramSubViewResponder.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/17/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"

@interface ProgramSubViewResponder : SubViewResponder
{
    DataFetcher *programFetcher;
    DataFetcher *programImageFetcher;
}

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblProgramName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgProgram;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *episodeScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *relatedVODScrollView;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;

@end
