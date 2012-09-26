//
//  VODPackage.h
//  MyTV.IOS
//
//  Created by myTV Inc. on 8/29/12.
//
//

#import <Foundation/Foundation.h>

@interface VODPackage : NSObject

@property int Id;
@property NSString *Title, *Description, *Price, *Thumbnail, *StartDate, *EndDate, *VODPackageTypeId;

@end
