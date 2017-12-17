//
//  CacheManager.h
//  EMC
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CacheManager : NSObject
/** 缓存目录 */
+(NSString *)createCachePath;

+(NSString *)createDocumentPath;

/**  */
+(Boolean)cacheNSDictionary:(NSDictionary *)data fileName:(NSString *)fileName;


+(NSString *)createCacheFilePath:(NSString *)fileDir;


-(NSString *)cachSize;

-(void)clearFileCallback:(void(^)(NSError *error))error;
@end
