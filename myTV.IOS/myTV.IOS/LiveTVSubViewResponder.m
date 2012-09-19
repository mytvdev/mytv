//
//  LiveTVSubViewResponder.m
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "LiveTVSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation LiveTVSubViewResponder

@synthesize fillerData = _fillerData;
@synthesize channelsKKGridView;
@synthesize channelsView;
@synthesize channelFetcher = _channelFetcher;

- (void)viewDidLoad
{
    _fillerData = [[NSMutableArray alloc] init];
    
    if(!hasLoadedChannelsData) {
        [self fillChannels];
        
        //channelsKKGridView = [[KKGridView alloc] initWithFrame:self.channelsView.bounds];
        channelsKKGridView = [[KKGridView alloc] initWithFrame:CGRectMake(20, 20, 970, 550)];
        channelsKKGridView.dataSource = self;
        channelsKKGridView.delegate = self;
        channelsKKGridView.scrollsToTop = YES;
        channelsKKGridView.backgroundColor = [UIColor lightGrayColor];
        channelsKKGridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        channelsKKGridView.cellSize = CGSizeMake(190.f, 185.f);
        channelsKKGridView.cellPadding = CGSizeMake(0.f, 0.f);
        channelsKKGridView.allowsMultipleSelection = NO;
        channelsKKGridView.gridHeaderView = nil;
        channelsKKGridView.gridFooterView = nil;
        
        [channelsKKGridView performSelectorOnMainThread:@selector(reloadData)
                                               withObject:nil
                                            waitUntilDone:NO];
        
        
        [self.channelsView addSubview:channelsKKGridView];
        hasLoadedChannelsData = YES;
    }
    
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
    KKChannelCell *cell = [KKChannelCell cellForGridView:gridView];
    Channel *channel = [[_fillerData objectAtIndex:0] objectAtIndex:(CGFloat)indexPath.index];
    cell.channel = channel;
    cell.contentView.backgroundColor = [UIColor clearColor];
    cell.selectedBackgroundView.backgroundColor = [UIColor clearColor];
    if([cell respondsToSelector:@selector(bindChannel:)]) {
        [cell performSelector:@selector(bindChannel:) withObject:channel];
    }
    return cell;
}

-(void) fillChannels {
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    [MBProgressHUD showHUDAddedTo:self.channelsView animated:YES];
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error) {
        if(linking != nil && error == nil) {
            [RestService RequestGetSubscribedChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *channels, NSError *error)
            {
                if(channels != nil && error == nil)
                {
                    for (Channel *channel in channels) {
                        [array addObject:channel];
                    }
                    [_fillerData addObject:array];
                }
            } synchronous:YES];
        }
        else {
            [RestService RequestGetAllChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *channels, NSError *error)
            {
                if(channels != nil && error == nil)
                {
                    for (Channel *channel in channels) {
                        [array addObject:channel];
                    }
                    [_fillerData addObject:array];
                }
            } synchronous:YES];
        }
        [MBProgressHUD hideHUDForView:self.channelsView animated:YES];
    } synchronous:YES];
}

@end
