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
    NSMutableDictionary *episodeCache;
    NSMutableDictionary *programCache;
    NSMutableDictionary *vodPackageCache;
    NSMutableDictionary *vodPackageChannelCache;
    NSMutableDictionary *vodPackageProgramCache;
}
@property NSUInteger cacheDuration;

+(RestCache *) CommonProvider;

-(DataFetcher *) RequestFeaturedVOD:(RSGetVOD)callback;

-(DataFetcher *) RequestGetProgramVOD:(NSString *)programId usingCallback:(RSGetVOD)callback;

-(DataFetcher *) RequestGetProgram:(NSString *)programId usingCallback:(RSGetProgram)callback;

-(DataFetcher *) RequestGetEpisode:(NSString *)episodeId usingCallback:(RSGetEpisode)callback;

-(DataFetcher *) RequestGetVODPackage:(NSString *)vodPackageId usingCallback:(RSGetVODPackage)callback;

-(DataFetcher *) RequestGetVODPackageChannels:(NSString *)vodPackageId usingCallback:(RSGetChannel)callback;

-(DataFetcher *) RequestGetVODPackagePrograms:(NSString *)vodPackageId usingCallback:(RSGetVOD)callback;

@end
