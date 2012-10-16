//
//  ProgramTypesSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 10/16/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import "TableVC.h"

@interface ProgramTypesSubViewResponder : UIViewController

@property (nonatomic, strong) NSMutableArray *arrayProgramTypes;
@property (nonatomic, strong) IBOutlet UIView *programtypesSubView;
@property (strong, nonatomic) TableVC *tableVC;

- (id)initWithNibNameAndProgramTypes:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil programtypes:(NSMutableArray *)ProgramTypes;

@end
