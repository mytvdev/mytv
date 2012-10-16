//
//  CustomCell.h
//  myTV.IOS
//
//  Created by Johnny on 10/15/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCell : UITableViewCell
{
    IBOutlet NSMutableArray *arrayPrograms;
}

@property (nonatomic, retain) IBOutlet NSMutableArray *arrayPrograms;
@property (nonatomic, retain) IBOutlet NSMutableArray *arrayProgramTypes;

@end
