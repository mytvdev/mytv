//
//  RestService.h
//  MyTV.IOS
//
//  Created by Omar Ayoub-Salloum on 8/23/12.
//
//

#import <Foundation/Foundation.h>
#import "Logging.h"
#import "DataFetcher.h"
#import "Linking.h"
#import "Channel.h"

typedef void (^RSLinkingCallBack) (Linking*, NSError*);
typedef void (^RSGetVodUrlCallBack) (NSString*, NSError*);
typedef RSGetVodUrlCallBack RSGetChannelURlCallback;
typedef void (^RSGetProgramUrlsCallBack)(NSArray /* NSString */ *, NSError*);
typedef void (^RSGetAllChannelCallBack) (NSArray /* Channel */ *, NSError*);
typedef RSGetAllChannelCallBack RSGetChannelCallBack;

@interface RestService : NSObject

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId andCallback:(NSObject *)callbackObject usingSelector:(SEL)callbackSelector;

+(void)SendLinkingRequest:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSLinkingCallBack)callback;

+(void)RequestGetVODUrl:(NSString *)baseUrl ofVideo:(NSString *)videoId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetVodUrlCallBack)callback;

+(void)RequestGetChannelUrl:(NSString *)baseUrl ofChannel:(NSString *)channelId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelURlCallback)callback;

+(void)RequestGetProgramEpisodesUrls:(NSString *)baseUrl ofProgram:(NSString *)programId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetProgramUrlsCallBack)callback;

+(void)RequestGetAllChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetAllChannelCallBack)callback;

+(void)RequestGetSubscribedChannels:(NSString *)baseUrl withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;

+(void)RequestGetChannels:(NSString *)baseUrl ofPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;

+(void)RequestGetChannels:(NSString *)baseUrl ofVODPackage:(NSString *)packageId withDeviceId:(NSString *)deviceId andDeviceTypeId:(NSString *)deviceTypeId usingCallback:(RSGetChannelCallBack)callback;



@end
