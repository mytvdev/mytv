//
//  VODPackageSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "VODPackageSubViewResponder.h"

@implementation VODPackageSubViewResponder

@synthesize lblPriceOrExpiry;
@synthesize lblvodPackageDescription;
@synthesize lblvodPackageName;
@synthesize imgvodPackage;
@synthesize channelContainerView;
@synthesize channelScrollView;
@synthesize programContainerView;
@synthesize programScrollView;
@synthesize relatedvodPackageScrollView;
@synthesize mainView;

-(void) viewDidLoad {
    
}

-(void)bindData:(NSObject *)data {
    NSDictionary *dict = (NSDictionary *)data;
    NSString *idvalue = [dict objectForKey:MyTV_ViewArgument_Id];
    if(idvalue != nil) {
        [MBProgressHUD showHUDAddedTo:self.mainView animated:YES];
        vodPackageFetcher = [[RestCache CommonProvider] RequestGetVODPackage:idvalue usingCallback:^(VODPackage *vodPackage, NSError *error) {
            if(vodPackage != nil && error == nil) {
                vodPackageId = idvalue;
                [self.lblPriceOrExpiry setHidden:YES];
                currentvodPackage = vodPackage;
                
                lblvodPackageName.text = (vodPackage.Title != nil && vodPackage.Title != @"") ? vodPackage.Title : @"-";
                lblvodPackageDescription.text = (vodPackage.Description != nil && vodPackage.Description != @"") ? vodPackage.Description : @"-";
                
                vodPackageImageFetcher = [DataFetcher Get:vodPackage.Thumbnail usingCallback:^(NSData *data, NSError *error){
                    if(data != nil && error == nil) {
                        imgvodPackage.image  = [[UIImage alloc] initWithData:data];
                    }
                    vodPackageImageFetcher = nil;
                }];
                //[self fillRelatedVOD:idvalue];
                //[self fillVODPackageChannels:idvalue];
                [self fillVODPackagePrograms:idvalue];
                /*[RestService RequestIsPurchased:MyTV_RestServiceUrl thisProgram:idvalue withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(PurchaseInformation* pi, NSError *error){
                 if(error == nil && pi != nil && pi.isPurchased == YES) {
                 [self.btnPayOrPlay setImage:[UIImage imageNamed:@"playAll.png"] forState:UIControlStateNormal];
                 [self.btnPayOrPlay setImage:[UIImage imageNamed:@"playAll-Over.png"] forState:UIControlStateHighlighted];
                 [self.btnPayOrPlay setHidden:NO];
                 isPurchased = YES;
                 }
                 else {
                 isPurchased = NO;
                 if ([program.Price floatValue] > 0) {
                 [self.btnPayOrPlay setImage:[UIImage imageNamed:@"buyProgram.png"] forState:UIControlStateNormal];
                 [self.btnPayOrPlay setImage:[UIImage imageNamed:@"buyProgram-Over.png"] forState:UIControlStateHighlighted];
                 [self.btnPayOrPlay setHidden:NO];
                 }
                 }
                 
                 }];*/
            }
            [MBProgressHUD hideHUDForView:self.mainView animated:NO];
        }];
    }
}

- (void) fillVODPackageChannels:(NSString *)vodPId {
    VODPackageSubViewResponder *subview = self;
    
    for(UIView *view in[subview.channelScrollView subviews]) {
        [view removeFromSuperview];
    }
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.channelScrollView animated:YES];
    vodPackageChannelsFetcher = [[RestCache CommonProvider] RequestGetVODPackageChannels:vodPId usingCallback:^(NSArray *array, NSError *error){
        int xPos1 = 14;
        int xPos2 = 14;
        int pos = 0;
        for (ItemBase *vod in array) {
            VODControlResponder *responder = [[VODControlResponder alloc] init];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
            UIView *view = [array objectAtIndex:0];
            if (pos % 2 == 0) {
                view.frame = CGRectMake(xPos1, 0, view.frame.size.width, view.frame.size.height);
                xPos1 = xPos1 + view.frame.size.width + 14;
            }
            else {
                view.frame = CGRectMake(xPos2, 155, view.frame.size.width, view.frame.size.height);
                xPos2 = xPos2 + view.frame.size.width + 14;
            }
            pos++;
            [subview.channelScrollView addSubview:view];
            if([responder respondsToSelector:@selector(bindData:)]) {
                [responder performSelector:@selector(bindData:) withObject:vod];
            }
            
            
        }
        subview.channelScrollView.contentSize = CGSizeMake(xPos1, subview.relatedvodPackageScrollView.frame.size.height);
        subview.channelScrollView.delegate = subview;
        [loader hide:YES];
    }];
}

- (void) fillVODPackagePrograms:(NSString *)vodPId {
    VODPackageSubViewResponder *subview = self;
    
    for(UIView *view in[subview.programScrollView subviews]) {
        [view removeFromSuperview];
    }
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.programScrollView animated:YES];
    vodPackageProgramsFetcher = [[RestCache CommonProvider] RequestGetVODPackagePrograms:vodPId usingCallback:^(NSArray *array, NSError *error){
        int xPos = 14;
        for (ItemBase *vod in array) {
            VODControlResponder *responder = [[VODControlResponder alloc] init];
            NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
            UIView *view = [array objectAtIndex:0];
            view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
            xPos = xPos + view.frame.size.width + VODControl_Space;
            [subview.programScrollView addSubview:view];
            if([responder respondsToSelector:@selector(bindData:)]) {
                [responder performSelector:@selector(bindData:) withObject:vod];
            }
        }
        subview.channelScrollView.contentSize = CGSizeMake(xPos, subview.relatedvodPackageScrollView.frame.size.height);
        subview.channelScrollView.delegate = subview;
        [loader hide:YES];
    }];
}

@end
