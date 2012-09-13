//
//  CategoriesSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "CategoriesSubViewResponder.h"

@interface CategoriesSubViewResponder ()

@end

@implementation CategoriesSubViewResponder

@synthesize fillerData = _fillerData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSUInteger j = 0; j < 10; j++) {
        [array addObject:[NSString stringWithFormat:@"%u", j]];
    }
    
    [_fillerData addObject:array];
    
    UIScrollView *view = [[UIScrollView alloc]
                          initWithFrame:[[UIScreen mainScreen] bounds]];
    
	int row = 0;
	int column = 0;
	for(int i = 0; i < _fillerData.count; ++i) {
        
		UIImage *thumb = [_fillerData objectAtIndex:i];
		UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
		button.frame = CGRectMake(column*100+24, row*80+10, 64, 64);
		[button setImage:thumb forState:UIControlStateNormal];
		[button addTarget:self
				   action:@selector(buttonClicked:)
		 forControlEvents:UIControlEventTouchUpInside];
		button.tag = i;
		[view addSubview:button];
        
		if (column == 2) {
			column = 0;
			row++;
		} else {
			column++;
		}
        
	}
    
	[view setContentSize:CGSizeMake(320, (row+1) * 80 + 10)];
	self.view = view;
    
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (IBAction)buttonClicked:(id)sender {
	//UIButton *button = (UIButton *)sender;
    //[alert @"Test"];
	//UIImage *selectedImage = [_images objectAtIndex:button.tag];
	// Do something with image!
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
