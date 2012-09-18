//
//  MyVODSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "MyVODSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation MyVODSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize myvodKKGridView;
@synthesize myvodView;
@synthesize myvodFetcher = _myvodFetcher;

- (void)viewDidLoad
{
    [self fillMyVOD];
}

-(NSUInteger)numberOfSectionsInGridView:(KKGridView *)gridView
{
    return _fillerData.count;
}

- (NSUInteger)gridView:(KKGridView *)gridView numberOfItemsInSection:(NSUInteger)section
{
    return [[_fillerData objectAtIndex:section] count];
}

- (KKGridViewCell *)gridView:(KKGridView *)gridView cellForItemAtIndexPath:(KKIndexPath *)indexPath
{
    KKGridViewCell *cell = [KKGridViewCell cellForGridView:gridView];
    return cell;
}

-(void) fillMyVOD {
    if(!hasLoadedMyVODData) {
        MyVODSubViewResponder *subview = self;
        _myvodFetcher = [RestService RequestGetMyVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            int xPos = 14;
            for (Episode *episode in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + 14;
                [subview.myvodView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:episode];
                }
            }
            //subview.vodFeaturedScrollView.contentSize = CGSizeMake(xPos, subview.vodFeaturedScrollView.frame.size.height);
            hasLoadedMyVODData = YES;
        }];
    }
}

-(void) cancelMyVODFetcher {
    if(_myvodFetcher != nil) {
        [_myvodFetcher cancelPendingRequest];
        _myvodFetcher = nil;
    }
}

@end
