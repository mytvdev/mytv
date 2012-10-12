//
//  RestService.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/23/12.
//
//

#import <Foundation/Foundation.h>
#import "Logging.h"
#import "DataFetcher.h"
#import "Linking.h"
#import "Channel.h"
#import "VODPackage.h"
#import "Episode.h"
#import "Program.h"
#import "PurchaseInformation.h"
#import "Genre.h"
#import "ProgramType.h"
#import "MyTVPackage.h"
#import "VODPackage.h"
#import "Country.h"

typedef void (^RSLinkingCallBack) (Linking*, NSError*);
typedef void (^RSGetVodUrlCallBack) (NSString*, NSError*);
typedef RSGetVodUrlCallBack RSGetChannelURlCallback;
typedef RSGetVodUrlCallBack RSBuyRequest;
typedef void (^RSGetProgramUrlsCallBack)(NSArray /* NSString */ *, NSError*);
typedef void (^RSGetAllChannelCallBack) (NSArray /* Channel */ *, NSError*);
typedef RSGetAllChannelCallBack RSGetChannelCallBack;
typedef void (^RSGetPreregistrationCode) (NSString*, NSError*);
typedef void (^RSGetVODPackages) (NSArray /* VODPackage */ *, NSError*);
typedef void (^RSGetVODPackage) (VODPackage *, NSError *);
typedef void (^RSGetVOD) (NSArray /* Video, Program */ *, NSError*);
typedef void (^RSGetChannel) (NSArray /* Channel */ *, NSError*);
typedef void (^RSGetBoolean) (BOOL, NSError*);
typedef void (^RSGetPurchaseInforamtion) (PurchaseInformation*, NSError*);
typedef void (^RSGetEpisode) (Episode*, NSError*);
typedef void (^RSGetProgram) (MyTVProgram*, NSError*);
typedef void (^RSGetGenres) (NSArray /* Genre */ *, NSError*);
typedef void (^RSGetProgramTypes) (NSArray /* ProgramType */ *, NSError*);
typedef void (^RSGetPackages) (NSArray /* MyTVPackage, VODPackage */ *, NSError*);
typedef void (^RSGetGountries) (NSArray /* Country */ *, NSError*);

@interface RestService : NSObject


+(DataFetcher *)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback;

+(DataFetcher *)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback synchronous:(BOOL)sync;

+(DataFetcher *)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback synchronous:(BOOL)sync;

+(DataFetcher *)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback synchronous:(BOOL)sync;

+(DataFetcher *)RequestGetVODUrl:(NSString *)baseUrl ofVideo:(NSString *)videoId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVodUrlCallBack)callback;

+(DataFetcher *)RequestGetChannelUrl:(NSString *)baseUrl ofChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelURlCallback)callback;

+(DataFetcher *)RequestGetProgramEpisodesUrls:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramUrlsCallBack)callback;

+(DataFetcher *)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback;

+(DataFetcher *)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;

+(DataFetcher *)RequestGetChannels:(NSString *)baseUrl ofPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;

+(DataFetcher *)RequestGetChannels:(NSString *)baseUrl ofVODPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;

+(DataFetcher *)RequestGetPreregistrationCode:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPreregistrationCode)callback;

+(DataFetcher *)RequestGetVODPackages:(NSString *)baseUrl ofBouquet:(NSString *)bouquetId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVODPackages)callback;

+(DataFetcher *)RequestGetVODPackageChannels:(NSString *)baseUrl ofVODPackageId:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannel)callback;

+(DataFetcher *)RequestGetVODPackagePrograms:(NSString *)baseUrl ofVODPackageId:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetVODPackage:(NSString *)baseUrl withVODPackageId:(NSString *)vodPackageId ofBouquet:(NSString *)bouquetId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVODPackage)callback;

+(DataFetcher *)RequestGetMyVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetVOD:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetVODEpisodes:(NSString *)baseUrl ofVODPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetVODPrograms:(NSString *)baseUrl ofVODPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetFeaturedVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetNewReleasesVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback;

+(DataFetcher *)RequestGetMyVOD:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVOD)callback synchronous:(BOOL)sync;

+(DataFetcher *)RequestGetProgram:(NSString *)baseUrl ofId:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgram)callback;

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisEpisode:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback;

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback;

+(DataFetcher *)RequestCanPlay:(NSString *)baseUrl thisChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetBoolean)callback;

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisEpisode:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback;

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback;

+(DataFetcher *)RequestIsPurchased:(NSString *)baseUrl thisVodPackage:(NSString *)vodPackageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetPurchaseInforamtion)callback;

+(DataFetcher *)BuyRequest:(NSString *)baseUrl VOD:(NSString *)episodeId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback;

+(DataFetcher *)BuyRequest:(NSString *)baseUrl VODPackage:(NSString *)packageId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback;

+(DataFetcher *)BuyRequest:(NSString *)baseUrl Program:(NSString *)programId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback;

+(DataFetcher *)BuyRequest:(NSString *)baseUrl Package:(NSString *)packageId usingBilling:(NSString *)billingId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSBuyRequest)callback;

+(DataFetcher *)RequestGetEpisode:(NSString *)baseUrl ofId:(NSString *)episodeId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetEpisode)callback;

+(DataFetcher *)RequestGenres:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback;

+(DataFetcher *)RequestGenres:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback  synchronous:(BOOL)sync;

+(DataFetcher *)RequestProgramTypes:(NSString *)baseUrl ofGenre:(NSString *)genreId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramTypes)callback;

+(DataFetcher *)RequestGetPackages:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramTypes)callback;

+(DataFetcher *)RequestCountries:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetGenres)callback;

+(DataFetcher *)Search:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId andSearchCriteria:(NSString *)searchCriteria usingCallback:(RSGetGenres)callback;

@end
