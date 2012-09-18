//
//  MyVODSubViewResponder.h
//  myTV.IOS.App
//
//  Created by Omar Ayoub-Salloum on 9/6/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "VODControlResponder.h"
#import "KKEpisodeCell.h"

@interface MyVODSubViewResponder : SubViewResponder <KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedMyVODData;
}

@property (readonly) DataFetcher *myvodFetcher;
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) KKGridView *myvodKKGridView;
@property (nonatomic, strong) IBOutlet UIView *myvodView;

@end
