//
//  RestCache.h
//  myTV.IOS
//
//  Created by Omar Ayoub-Salloum on 9/25/12.
//  Copyright (c) 2012 Omar Ayoub-Salloum. All rights reserved.
//

#import "RestService.h"

@interface RestCache : RestService {
    NSArray *featuredVOD;
    NSMutableDictionary *programVODCache;
}
@property NSUInteger cacheDuration;

+(RestCache *) CommonProvider;

-(DataFetcher *) RequestFeaturedVOD:(RSGetVOD)callback;;

-(DataFetcher *) RequestGetProgramVOD:(NSString *)programId usingCallback:(RSGetVOD)callback;

@end
