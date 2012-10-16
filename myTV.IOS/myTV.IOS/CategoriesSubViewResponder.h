//
//  CategoriesSubViewResponder.h
//  myTV.IOS
//
//  Created by Johnny on 9/13/12.
//  Copyright (c) 2012 myTV Inc.. All rights reserved.
//

#import "SubViewResponder.h"
#import <KKGridView/KKGridView.h>
#import "KKDemoCell.h"
#import "DataFetcher.h"
#import "RestService.h"
#import "UIDevice+IdentifierAddition.h"
#import "TableGenres.h"

@interface CategoriesSubViewResponder : UIViewController <MyKKDemoCellDelegate, KKGridViewDataSource, KKGridViewDelegate>
{
    BOOL hasLoadedGenresData;
    BOOL IsLoadingProgramTypes;
}
@property (nonatomic, strong) NSMutableArray *fillerData;
@property (nonatomic, strong) NSMutableArray *fillerProgramTypeData;
@property (nonatomic, strong) IBOutlet UIView *categoriesSubView;
@property (nonatomic, strong) KKGridView *categoriesKKGridView;
@property (readonly) DataFetcher *genreFetcher;

@property (nonatomic, strong) NSArray *genres;

@property (strong, nonatomic) TableGenres *tableVC;

- (id)initWithNibNameAndGenres:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil genres:(NSArray *)Genres;

@end
