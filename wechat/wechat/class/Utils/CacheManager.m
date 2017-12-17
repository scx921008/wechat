//
//  CacheManager.m
//  EMC
//
//  Created by apple on 2017/3/17.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager

+(NSString *)createCachePath{
    NSFileManager *fileManager = [NSFileManager defaultManager];

    NSString *path = [PathDocument stringByAppendingPathComponent:ProjectName];
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        if([fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]){
            return path;
        }else{
            return nil;
        }
    }else{
        return path;
    }
}

+(NSString *)createDocumentPath{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSString *path = [PathDocument stringByAppendingPathComponent:ProjectName];
    if (![fileManager fileExistsAtPath:path]) {
        NSError *error = nil;
        if([fileManager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error]){
            return path;
        }else{
            return nil;
        }
    }else{
        return path;
    }
}


+(NSString *)createCacheFilePath:(NSString *)fileDir{
    return [[CacheManager createCachePath] stringByAppendingPathComponent:fileDir];
}


+(Boolean)cacheNSDictionary:(NSDictionary *)data fileName:(NSString *)fileName{
    NSString *path = [[CacheManager createCachePath] stringByAppendingPathComponent:fileName];
    if (path) {
        return [data writeToFile:path atomically:YES];
    }else{
        return NO;
    }
}


// 显示缓存大小
-(NSString *)cachSize{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    float size = [self folderSizeAtPath :cachPath];
    return [NSString stringWithFormat:@"%.1f %@",[self fileSizeInUnit:size],[self calculateUnit:size]];
}
- (float)fileSizeInUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3))
        return (float) (contentLength / (float)pow(1024, 3));
    else if(contentLength >= pow(1024, 2))
        return (float) (contentLength / (float)pow(1024, 2));
    else if(contentLength >= 1024)
        return (float) (contentLength / (float)1024);
    else
        return (float) (contentLength);
}
- (NSString *)calculateUnit:(unsigned long long)contentLength
{
    if(contentLength >= pow(1024, 3))
        return @"GB";
    else if(contentLength >= pow(1024, 2))
        return @"MB";
    else if(contentLength >= 1024)
        return @"KB";
    else
        return @"Bytes";
}

-(float) folderSizeAtPath:( NSString *) folderPath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if (![manager fileExistsAtPath :folderPath]) return 0 ;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath :folderPath] objectEnumerator ];
    NSString * fileName;
    long long folderSize = 0 ;
    while ((fileName = [childFilesEnumerator nextObject ]) != nil ){
        NSString * fileAbsolutePath = [folderPath stringByAppendingPathComponent :fileName];
        folderSize += [ self fileSizeAtPath :fileAbsolutePath];
    }
    return folderSize;
}
-(long long) fileSizeAtPath:( NSString *) filePath{
    NSFileManager * manager = [ NSFileManager defaultManager ];
    if ([manager fileExistsAtPath :filePath]){
        return [[manager attributesOfItemAtPath :filePath error : nil ] fileSize ];
    }
    return 0 ;
}

-(void)clearFileCallback:(void (^)(NSError *))error{
    NSString * cachPath = [ NSSearchPathForDirectoriesInDomains ( NSCachesDirectory , NSUserDomainMask , YES ) firstObject ];
    NSArray * files = [[ NSFileManager defaultManager ] subpathsAtPath :cachPath];
    NSError * err = nil ;
    for ( NSString * p in files) {
        
        NSString * path = [cachPath stringByAppendingPathComponent :p];
        if ([[ NSFileManager defaultManager ] fileExistsAtPath :path]) {
            [[ NSFileManager defaultManager ] removeItemAtPath :path error :&err];
        }
    }
    error(err);
}
@end
