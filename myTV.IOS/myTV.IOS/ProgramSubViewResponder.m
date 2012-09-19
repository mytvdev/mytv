//
//  ProgramSubViewResponder.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/17/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "ProgramSubViewResponder.h"

@implementation ProgramSubViewResponder
@synthesize lblProgramName;
@synthesize imgProgram;
@synthesize episodeScrollView;
@synthesize relatedVODScrollView;
@synthesize mainView;

-(void)bindData:(NSObject *)data {
    NSDictionary *dict = (NSDictionary *)data;
    NSString *idvalue = [dict objectForKey:MyTV_ViewArgument_Id];
    if(idvalue != nil) {
        [MBProgressHUD showHUDAddedTo:self.mainView animated:YES];
        programFetcher = [RestService RequestGetProgram:MyTV_RestServiceUrl ofId:idvalue withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(MyTVProgram *program, NSError *error){
            if(program != nil && error == nil) {
                lblProgramName.text = program.Title;
                programImageFetcher = [DataFetcher Get:program.Thumbnail usingCallback:^(NSData *data, NSError *error){
                    if(data != nil && error == nil) {
                        imgProgram.image  = [[UIImage alloc] initWithData:data];
                    }
                    programImageFetcher = nil;
                }];
            }
            [MBProgressHUD hideHUDForView:self.mainView animated:NO];
        }];
    }
}

@end
