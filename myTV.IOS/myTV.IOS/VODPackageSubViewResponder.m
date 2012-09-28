//
//  VODPackageSubViewResponder.m
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "VODPackageSubViewResponder.h"

@implementation VODPackageSubViewResponder

@synthesize txtPinCode;
@synthesize lblPriceOrExpiry;
@synthesize btnPurchase;
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
                [self.lblPriceOrExpiry setHidden:NO];
                currentvodPackage = vodPackage;
                
                lblvodPackageName.text = (vodPackage.Title != nil && vodPackage.Title != @"") ? vodPackage.Title : @"-";
                lblvodPackageDescription.text = (vodPackage.Description != nil && vodPackage.Description != @"") ? vodPackage.Description : @"-";
                lblPriceOrExpiry.text = [NSString stringWithFormat:@"%@%@", @"$", vodPackage.Price];
                
                vodPackageImageFetcher = [DataFetcher Get:vodPackage.Thumbnail usingCallback:^(NSData *data, NSError *error){
                    if(data != nil && error == nil) {
                        imgvodPackage.image  = [[UIImage alloc] initWithData:data];
                    }
                    vodPackageImageFetcher = nil;
                }];
                [self fillRelatedVODPackages];
                [self fillVODPackageChannels:idvalue];
                [self fillVODPackagePrograms:idvalue];
                [RestService RequestIsPurchased:MyTV_RestServiceUrl thisVodPackage:idvalue withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(PurchaseInformation* pi, NSError *error)
                {
                    if(error == nil && pi != nil && pi.isPurchased == YES) {
                        //[self.btnPurchase setImage:[UIImage imageNamed:@"playAll.png"] forState:UIControlStateNormal];
                        //[self.btnPurchase setImage:[UIImage imageNamed:@"playAll-Over.png"] forState:UIControlStateHighlighted];
                        [self.btnPurchase setHidden:NO];
                        isPurchased = YES;
                    }
                    else {
                        isPurchased = NO;
                        if ([vodPackage.Price floatValue] > 0) {
                            [self.btnPurchase setImage:[UIImage imageNamed:@"buyProgram.png"] forState:UIControlStateNormal];
                            [self.btnPurchase setImage:[UIImage imageNamed:@"buyProgram-Over.png"] forState:UIControlStateHighlighted];
                            [self.btnPurchase setHidden:NO];
                        }
                    }
                 }];
            }
            [MBProgressHUD hideHUDForView:self.mainView animated:NO];
        }];
    }
}

- (void) fillRelatedVODPackages
{
    VODPackageSubViewResponder *subview = self;
    for(UIView *view in[subview.relatedvodPackageScrollView subviews]) {
        [view removeFromSuperview];
    }
    
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:self.relatedvodPackageScrollView animated:YES];
    [RestService RequestGetVODPackages:MyTV_RestServiceUrl ofBouquet:@"1" withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *vodPackages, NSError *error)
     {
         int xPos = 14;
         if (vodPackages != nil && vodPackages.count > 0)
         {
             for (ItemBase *vod in vodPackages) {
                 VODPackageControlResponder *responder = [[VODPackageControlResponder alloc] init];
                 NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"VODPackageControl" owner:responder options:nil];
                 UIView *view = [array objectAtIndex:0];
                 view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                 xPos = xPos + view.frame.size.width + 14;
                 [subview.relatedvodPackageScrollView addSubview:view];
                 if([responder respondsToSelector:@selector(bindData:)]) {
                     [responder performSelector:@selector(bindData:) withObject:vod];
                 }
             }
             subview.relatedvodPackageScrollView.contentSize = CGSizeMake(xPos, subview.relatedvodPackageScrollView.frame.size.height);
             subview.relatedvodPackageScrollView.delegate = subview;
         }
         [loader hide:YES];
     }];
}

- (void) fillVODPackageChannels:(NSString *)vodPId {
    VODPackageSubViewResponder *subview = self;
    
    for(UIView *view in[subview.channelScrollView subviews]) {
        [view removeFromSuperview];
    }
    MBProgressHUD *loader = [MBProgressHUD showHUDAddedTo:subview.channelScrollView animated:YES];
    vodPackageChannelsFetcher = [[RestCache CommonProvider] RequestGetVODPackageChannels:vodPId usingCallback:^(NSArray *array, NSError *error){
        int xPos = 14;
        if (array != nil && array.count > 0)
        {
            for (ItemBase *vod in array) {
                VODControlResponder *responder = [[VODControlResponder alloc] init];
                NSArray *array = [[NSBundle mainBundle] loadNibNamed:@"ChannelControl" owner:responder options:nil];
                UIView *view = [array objectAtIndex:0];
                view.frame = CGRectMake(xPos, 0, view.frame.size.width, view.frame.size.height);
                xPos = xPos + view.frame.size.width + 14;
                [subview.channelScrollView addSubview:view];
                if([responder respondsToSelector:@selector(bindData:)]) {
                    [responder performSelector:@selector(bindData:) withObject:vod];
                }
            }
            subview.channelScrollView.contentSize = CGSizeMake(xPos, subview.relatedvodPackageScrollView.frame.size.height);
            subview.channelScrollView.delegate = subview;
        }
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
        subview.programScrollView.contentSize = CGSizeMake(xPos, subview.relatedvodPackageScrollView.frame.size.height);
        subview.programScrollView.delegate = subview;
        [loader hide:YES];
    }];
}

- (IBAction)BuyVODPackage:(id)sender {
    if(!isPurchased) {
        [btnPurchase setHidden:YES];
        [txtPinCode setHidden:NO];
        txtPinCode.text = @"";
        [txtPinCode becomeFirstResponder];
    }
}

-(void) textFieldDidEndEditing:(UITextField *)textField {
    if(textField == self.txtPinCode) {
        if (txtPinCode.isFirstResponder) {
            [textField resignFirstResponder];
            [txtPinCode setHidden:YES];
            [btnPurchase setHidden:NO];
        }
    }
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField {
    if (textField == self.txtPinCode) {
        [txtPinCode setHidden:YES];
        [btnPurchase setHidden:NO];
        return  YES;
    }
    return NO;
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.txtPinCode) {
        [textField resignFirstResponder];
        [btnPurchase setEnabled:NO];
        if(isPurchased) {
            //[self playcode]
        }
        else {
            [self buyVODPackage];
        }
        
        
        return YES;
    }
    return NO;
}

-(void) buyVODPackage {
    VODPackageSubViewResponder *subview = self;
    RSLinkingCallBack callback = ^(Linking *data, NSError *error){
        if(error == nil && data != nil) {
            NSString *pid = [NSString stringWithFormat:@"%d", currentvodPackage.Id];
            NSString *bid = [NSString stringWithFormat:@"%d", data.BillingId];
            [RestService BuyRequest:MyTV_RestServiceUrl VODPackage:pid usingBilling:bid withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSString *status, NSError *error) {
                if(error == nil && status != nil) {
                    if([status compare:@"success"] == NSOrderedSame) {
                        isPurchased = YES;
                        //[self.btnPurchase setImage:[UIImage imageNamed:@"playAll.png"] forState:UIControlStateNormal];
                        //[self.btnPayOrPlay setImage:[UIImage imageNamed:@"playAll-Over.png"] forState:UIControlStateHighlighted];
                        [self fillRelatedVODPackages];
                        [self.btnPurchase setHidden:YES];
                    }
                    else {
                        UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Attention" message:[NSString stringWithFormat:@"Purchase failed: %@", status] delegate:subview cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                        [view show];
                    }
                }
                [self.btnPurchase setEnabled:YES];
            }];
        }
        else {
            UIAlertView *message = [[UIAlertView alloc] initWithTitle:@"Attention" message:@"You must login with your account first" delegate:subview cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            [message show];
        }
    };
    
    [RestService SendLinkingRequest:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:callback synchronous:NO];
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    [[NSNotificationCenter defaultCenter] postNotificationName:MyTV_Event_ChangeView object:nil userInfo:@ { MyTV_ViewArgument_View: MyTV_View_Login }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    return (newLength > 5) ? NO : YES;
}

@end
