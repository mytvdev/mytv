//
//  MyVODSubViewResponder.h
//  myTV.IOS.App
//
//  Created by myTV Inc. on 9/6/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKEpisodeCell.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"

@interface MyVODSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedMyVODData;
}

@property (readonly) DataFetcher *myvodFetcher;
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) KKGridView *myvodKKGridView;
@property (nonatomic, strong) IBOutlet UIView *myvodView;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageDisplay;

@end
