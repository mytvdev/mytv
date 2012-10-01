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

-(id)init {
    self = [super init];
    if(self) {
        programVODCache = [[NSMutableDictionary alloc] init];
        episodeCache = [[NSMutableDictionary alloc] init];
        programCache = [[NSMutableDictionary alloc] init];
    }
    return self;
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

- (DataFetcher *)RequestGetProgramVOD:(NSString *)programId usingCallback:(RSGetVOD)callback {
    NSArray *items = [programVODCache objectForKey:programId];
    if(items != nil) {
        callback([[NSArray alloc] initWithArray:items copyItems:YES], nil);
        return nil;
    }
    else {
        return [RestService RequestGetVOD:MyTV_RestServiceUrl ofProgram:programId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            if(array != nil && error == nil) {
                [programVODCache setValue:array forKey:programId];
                [self performSelector:@selector(ClearProgramVODCache:) withObject:programId afterDelay:self.cacheDuration];
                NSArray *copy = [[NSArray alloc] initWithArray:array copyItems:YES];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearProgramVODCache:(NSString *)programId {
    [programVODCache removeObjectForKey:programId];
}

- (DataFetcher *)RequestGetProgram:(NSString *)programId usingCallback:(RSGetProgram)callback {
    MyTVProgram *program = [programCache objectForKey:programId];
    if(program != nil) {
        callback([program copy], nil);
        return nil;
    }
    else {
        return [RestService RequestGetProgram:MyTV_RestServiceUrl ofId:programId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(MyTVProgram *program, NSError *error){
            if(program != nil && error == nil) {
                [programCache setValue:program forKey:programId];
                [self performSelector:@selector(ClearProgramVODCache:) withObject:programId afterDelay:self.cacheDuration];
                MyTVProgram *copy = [program copy];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearProgramCache:(NSString *)programId {
        [programCache removeObjectForKey:programId];
}

- (DataFetcher *)RequestGetEpisode:(NSString *)episodeId usingCallback:(RSGetEpisode)callback {
    Episode *episode = [episodeCache objectForKey:episodeId];
    if(episode != nil) {
        callback([episode copy], nil);
        return nil;
    }
    else {
        return [RestService RequestGetEpisode:MyTV_RestServiceUrl ofId:episodeId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(Episode *episode, NSError *error){
            if(episode != nil && error == nil) {
                [episodeCache setValue:episode forKey:episodeId];
                [self performSelector:@selector(ClearProgramVODCache:) withObject:episodeId afterDelay:self.cacheDuration];
                Episode *copy = [episode copy];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearEpisodeCache:(NSString *)episodeId {
    [episodeCache removeObjectForKey:episodeId];
}

- (DataFetcher *)RequestGetVODPackage:(NSString *)vodPackageId usingCallback:(RSGetVODPackage)callback {
    VODPackage *vodPackage = [vodPackageCache objectForKey:vodPackageId];
    if(vodPackage != nil) {
        callback([vodPackage copy], nil);
        return nil;
    }
    else {
        return [RestService RequestGetVODPackage:MyTV_RestServiceUrl withVODPackageId:vodPackageId ofBouquet:@"1" withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(VODPackage *vodpackage, NSError *error){
            if(vodpackage != nil && error == nil) {
                [vodPackageCache setValue:vodpackage forKey:vodPackageId];
                [self performSelector:@selector(ClearProgramVODCache:) withObject:vodPackageId afterDelay:self.cacheDuration];
                VODPackage *copy = [vodpackage copy];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearVODPackageCache:(NSString *)vodPackageId {
    [vodPackageCache removeObjectForKey:vodPackageId];
}

- (DataFetcher *)RequestGetVODPackageChannels:(NSString *)vodPackageId usingCallback:(RSGetChannel)callback {
    NSArray *items = [vodPackageChannelCache objectForKey:vodPackageId];
    if(items != nil) {
        callback([[NSArray alloc] initWithArray:items copyItems:YES], nil);
        return nil;
    }
    else {
        return [RestService RequestGetVODPackageChannels:MyTV_RestServiceUrl ofVODPackageId:vodPackageId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error) {
            if(array != nil && error == nil) {
                [vodPackageChannelCache setValue:array forKey:vodPackageId];
                [self performSelector:@selector(ClearVODPackageChannelsCache:) withObject:vodPackageId afterDelay:self.cacheDuration];
                NSArray *copy = [[NSArray alloc] initWithArray:array copyItems:YES];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearVODPackageChannelsCache:(NSString *)vodPackageId {
    [vodPackageChannelCache removeObjectForKey:vodPackageId];
}

- (DataFetcher *)RequestGetVODPackagePrograms:(NSString *)vodPackageId usingCallback:(RSGetChannel)callback {
    NSArray *items = [vodPackageProgramCache objectForKey:vodPackageId];
    if(items != nil) {
        callback([[NSArray alloc] initWithArray:items copyItems:YES], nil);
        return nil;
    }
    else {
        return [RestService RequestGetVODPackagePrograms:MyTV_RestServiceUrl ofVODPackageId:vodPackageId withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error) {
            if(array != nil && error == nil) {
                [vodPackageChannelCache setValue:array forKey:vodPackageId];
                [self performSelector:@selector(ClearVODPackageProgramsCache:) withObject:vodPackageId afterDelay:self.cacheDuration];
                NSArray *copy = [[NSArray alloc] initWithArray:array copyItems:YES];
                callback(copy, nil);
            }
        }];
    }
}

- (void) ClearVODPackageProgramsCache:(NSString *)vodPackageId {
    [vodPackageProgramCache removeObjectForKey:vodPackageId];
}

-(DataFetcher *) RequestGetMyTVPackages:(RSGetPackages)callback
{
    if(mytvPackages == nil) {
        return [RestService RequestGetPackages:MyTV_RestServiceUrl withDeviceId:[[UIDevice currentDevice] uniqueDeviceIdentifier] andDeviceTypeId:MyTV_DeviceTypeId usingCallback:^(NSArray *array, NSError *error){
            if(array != nil && error == nil) {
                mytvPackages = array;
                NSArray *copy = [[NSArray alloc] initWithArray:mytvPackages copyItems:YES];
                callback(copy, nil);
                [self performSelector:@selector(ClearMyTVPackagesCache) withObject:nil afterDelay:self.cacheDuration];
            }
            else {
                callback(array, error);
            }
        }];
    }
    else {
        callback([[NSArray alloc] initWithArray:mytvPackages copyItems:YES], nil);
        return nil;
    }
}

- (void) ClearMyTVPackagesCache{
    mytvPackages = nil;
}

@end
