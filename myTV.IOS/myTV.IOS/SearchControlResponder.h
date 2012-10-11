//  SearchControlResponder.h
//  myTV.IOS
//
//  Created by Johnny on 10/5/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "SubViewResponder.h"
#import "Episode.h"
#import "DataFetcher.h"
#import "RestService.h"

@interface SearchControlResponder : SubViewResponder

@property Episode *itemBase;

@property (unsafe_unretained, nonatomic) IBOutlet UIView *mainView;

@property DataFetcher *imageFetcher;

@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelDuration;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelExpiry;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *labelPrice;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageDisplay;

@property UITapGestureRecognizer *recognizer;

@property (unsafe_unretained, nonatomic) IBOutlet UIButton *priceButton;

@end
