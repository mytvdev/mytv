//
//  ProgramTypesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 10/16/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "ProgramTypesSubViewResponder.h"

#define DEFAULT_ROW_HEIGHT 26
#define HEADER_HEIGHT 26

@implementation ProgramTypesSubViewResponder

@synthesize arrayProgramTypes;
@synthesize programtypesSubView;

@synthesize tableVC;

- (id)initWithNibNameAndProgramTypes:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil programtypes:(NSMutableArray *)ProgramTypes
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.arrayProgramTypes = ProgramTypes;
    }
    return self;
}

- (void)viewDidLoad
{
    self.tableVC=[[TableVC alloc]initWithProgramTypes:arrayProgramTypes];
    [self.programtypesSubView addSubview:self.tableVC.view];
}

@end
