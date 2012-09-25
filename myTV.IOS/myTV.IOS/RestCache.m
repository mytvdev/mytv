//
//  RestCache.m
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/25/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "RestCache.h"

@implementation RestCache

static RestCache *singleton;

+(void)initialize {
    static BOOL isInited = NO;
    if(!isInited) {
        isInited = YES;
        singleton = [[RestCache alloc] init];
        singleton.cacheDuration = 5 * 60;
    }
}

+ (RestCache *)CommonProvider {
    return singleton;
}


- (DataFetcher *)RequestFeaturedVOD:(RSGetVOD)callback {
    if(featuredVOD == nil) {
        return [RestService RequestGetFeaturedVOD:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            if(array != nil && error == nil) {
                featuredVOD = array;
                NSArray *copy = [[NSArray alloc] initWithArray:featuredVOD copyItems:YES];
                callback(copy, nil);
                [self performSelector:@selector(ClearFeaturedVODCache) withObject:nil afterDelay:self.cacheDuration];
            }
            else {
                callback(array, error);
            }
        }];
    }
    else {
        callback([[NSArray alloc] initWithArray:featuredVOD copyItems:YES], nil);
        return nil;
    }
}

- (void)ClearFeaturedVODCache {
    featuredVOD = nil;
}

@end
