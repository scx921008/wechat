//
//  HTTPTools.m
//  weibo
//
//  Created by sangcixiang on 17/1/3.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "HTTPTools.h"
#import "LoginViewController.h"
#import "NavigationController.h"



@implementation HTTPTools

+(AFHTTPSessionManager *)manager{
    AppDelegate *app = sharedApp;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setValue:app.longitude forHTTPHeaderField:@"longitude"];
    [manager.requestSerializer setValue:app.latitude forHTTPHeaderField:@"latitude"];
    [manager.requestSerializer setValue:app.system forHTTPHeaderField:@"system"];
    [manager.requestSerializer setValue:app.location forHTTPHeaderField:@"location"];
    [manager.requestSerializer setValue:[AccountModel sharedAccount].token forHTTPHeaderField:@"token"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    return manager;
}

+(void)GET:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))err{
    
    AFHTTPSessionManager *manager = [HTTPTools manager];
    [manager GET:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);
    }];
}

+(void)POST:(NSString *)url parameters:(NSMutableDictionary *)parameters success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))err{
    AFHTTPSessionManager *manager = [HTTPTools manager];
    [manager POST:url parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        err(error);
        NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
        NSInteger statusCode = response.statusCode;
        if (statusCode == 0) {
        }else if (statusCode == 401){
            
        }else if (statusCode == 500){
        }else if (statusCode == 408){
        }else{
        }
    }];
}

+(void)POST:(NSString *)url parameters:(NSMutableDictionary *)parameters imageDatas:(NSArray *)images success:(void (^)(NSDictionary *))success failure:(void (^)(NSError *))failure{
    
    AFHTTPSessionManager *manager = [HTTPTools manager];
    
    [manager POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        int i = 0;
        for (NSData *data in images) {
            NSString *fileName = [NSString stringWithFormat:@"image%d.png",i];
            NSString *name = [NSString stringWithFormat:@"image%d",i];
            [formData appendPartWithFileData:data name:name fileName:fileName mimeType:@"image/jpeg"];
            i++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        failure(error);
    }];
}


+(void)addNetworkEvent:(void (^)(NetworkType))networkType changeNetwork:(void (^)(NetworkType))changeType{
    
    networkType([HTTPTools getNetWorkStates]);
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    
    // 2.设置网络状态改变后的处理
    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                changeType(NetworkTypeUnknown);
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                changeType(NetworkTypeNone);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                changeType(NetworkTypeViaWWAN);
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                changeType(NetworkTypeWIFI);
                break;
        }
    }];
}

+ (NetworkType)getNetWorkStates{
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"]valueForKeyPath:@"foregroundView"]subviews];
    int netType = 0;
    NetworkType networkType = 0;
    for (id child in children) {
        if ([child isKindOfClass:NSClassFromString(@"UIStatusBarDataNetworkItemView")]) {
            netType = [[child valueForKeyPath:@"dataNetworkType"]intValue];
            switch (netType) {
                case 0:
                    networkType = NetworkTypeNone;
                    break;
                case 1:
                case 2:
                case 3:
                    networkType = NetworkTypeViaWWAN;
                    break;
                case 5:
                    networkType = NetworkTypeWIFI;
                    break;
                default:
                    break;
                
            }
        }
        //根据状态选择
    }
    return networkType;
}



@end
