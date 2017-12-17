//
//  HTTPTools.h
//  weibo
//
//  Created by sangcixiang on 17/1/3.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, NetworkType) {
    NetworkTypeNone       = 0,
    NetworkTypeViaWWAN    = 1,
    NetworkTypeWIFI       = 2,
    NetworkTypeUnknown    = 3
};

@interface HTTPTools : NSObject

+(void)GET:(NSString * )url
parameters:(NSMutableDictionary *)parameters
   success:(void(^)(NSDictionary *success))success
   failure:(void(^)(NSError *error))err;

+(void)POST:(NSString * )url
parameters:(NSMutableDictionary *)parameters
   success:(void(^)(NSDictionary *success))success
   failure:(void(^)(NSError *error))err;



+(void)addNetworkEvent:(void(^)(NetworkType currentType))networkType changeNetwork:(void(^)(NetworkType changeType))changeType;


@end
