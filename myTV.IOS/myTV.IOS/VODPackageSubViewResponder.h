//
//  VODPackageSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 9/26/12.
//  Copyright (c) 2012 myTV Inc. All rights reserved.
//

#import "SubViewResponder.h"
#import "RestService.h"
#import "VODControlResponder.h"
#import "RestCache.h"
#import "VODPackageControlResponder.h"

@interface VODPackageSubViewResponder : SubViewResponder <
UIScrollViewDelegate
, UITextFieldDelegate
, UIAlertViewDelegate
>
{
    DataFetcher *vodPackageFetcher;
    DataFetcher *vodPackageImageFetcher;
    DataFetcher *relatedvodPackageFetcher;
    DataFetcher *vodPackageChannelsFetcher;
    DataFetcher *vodPackageProgramsFetcher;
    BOOL hasLoadedRelatedData;
    VODPackage *currentvodPackage;
    BOOL isPurchased;
    NSString *vodPackageId;
}

@property (unsafe_unretained, nonatomic) IBOutlet UITextField *txtPinCode;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblPriceOrExpiry;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *btnPurchase;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblvodPackageDescription;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *lblvodPackageName;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgvodPackage;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *channelContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *channelScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *programContainerView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *programScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIScrollView *relatedvodPackageScrollView;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;

- (IBAction)BuyVODPackage:(id)sender;

@end
