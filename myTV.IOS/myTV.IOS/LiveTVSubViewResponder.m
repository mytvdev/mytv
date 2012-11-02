//
//  LiveTVSubViewResponder.m
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "LiveTVSubViewResponder.h"
#import "MBProgressHUD.h"
#import "TBXML.h"
#import "ScanHelper.h"

@implementation LiveTVSubViewResponder

@synthesize channelFetcher = _channelFetcher;
@synthesize ChannelScrollView;

- (void)viewDidLoad
{
    //if(!hasLoadedChannelsData) {
        [self fillChannels];
        LiveTVObserver = [[NSNotificationCenter defaultCenter] addObserverForName:@"SelectChannel" object:nil queue:nil usingBlock:^(NSNotification *note) {
            Channel *data = (Channel *)note.object;
            //self.lblChannelName.text = data.Name;
            //self.lblChannelDescripton.text = data.BigDescription;
        }];
    //}
    
    [self.ChannelScrollView setContentOffset:CGPointZero animated:YES];
}

 

-(void) fillChannels {    
    [MBProgressHUD showHUDAddedTo:self.ChannelScrollView animated:YES];
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Linking *linking, NSError *error) {
        if(linking != nil && error == nil) {
            [RestService RequestGetSubscribedChannels:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *channels, NSError *error)
            {
                if(channels != nil && error == nil)
                {
                    int maximumWidth = self.ChannelScrollView.frame.size.width;
                    int xPos = 0;
                    int yPos = 0;
                    for (Channel *channel in channels) {
                        if(xPos == 0) {
                            xPos = ChannelControl_Space;
                        }
                        else if ( (xPos + ChannelControl_Width + 22 + ChannelControl_Width) > maximumWidth) {
                            xPos = 5;
                            yPos = yPos + ChannelControl_Height;
                        }
                        else {
                            xPos = xPos + 134 + 22;
                        }
                        ChannelControlResponder *responder = [[ChannelControlResponder alloc] init];
                        NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                        UIView *view = [array objectAtIndex:0];
                        view.frame = CGRectMake(xPos, yPos, view.frame.size.width, view.frame.size.height);
                        [self.ChannelScrollView addSubview:view];
                        [responder bindData:channel];
                        
                    }
                    self.ChannelScrollView.contentSize = CGSizeMake(maximumWidth, yPos + ChannelControl_Height);
                }
             
                hasLoadedChannelsData = YES;
            } synchronous:NO];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"You need to link your device to activate your subscription" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [alert show];
            [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@{ MyTV_ViewArgument_View : @"home" }];
            
        }
        [MBProgressHUD hideHUDForView:self.ChannelScrollView animated:YES];
    } synchronous:NO];
}

-(void) dealloc {
    if(LiveTVObserver != nil) {
        [[NSNotificationCenter defaultCenter] removeObserver:LiveTVObserver];
    }
}
@end
