//
//  AccountModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/23.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "AccountModel.h"
/** 用户信息 */
#define accountPath [PathDocument stringByAppendingPathComponent:@"account.archiver"]
static AccountModel *_single;
@implementation AccountModel

+ (instancetype)sharedAccount{
    if (_single == nil) {
        _single = [[AccountModel alloc] init];
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        _single.account = [defaults objectForKey:@"account"];
        _single.token = [defaults objectForKey:@"token"];
        _single.expiry_time = [defaults integerForKey:@"expiry_time"];
        _single.Id = [defaults integerForKey:@"id"];
    }
    return _single;
}
+ (id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _single = [super allocWithZone:zone];
    });
    return _single;
}


MJCodingImplementation

+(void)login:(NSString *)account withPassword:(NSString *)password callback:(void (^)(UserModel *, NSString *, NSError *))callback{
    [[EMClient sharedClient]loginWithUsername:account password:password completion:^(NSString *aUsername, EMError *error) {
        if (!error){
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"account"] = account;
            dict[@"password"] = password;
            NSString *url = [NSString stringWithFormat:@"%@%@",domain,LOGINURL];
            [HTTPTools POST:url parameters:dict success:^(NSDictionary *success) {
                if ([success[@"code"] intValue] == 200) {
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    NSDictionary *data = success[@"data"];
                    [defaults setObject:data[@"account"] forKey:@"account"];
                    [defaults setObject:data[@"token"] forKey:@"token"];
                    [defaults setInteger:[data[@"expiry_time"] integerValue] forKey:@"expiry_time"];
                    [defaults setInteger:[data[@"id"] integerValue] forKey:@"id"];
                    [AccountModel sharedAccount].account = data[@"account"];
                    [AccountModel sharedAccount].Id = [data[@"id"] integerValue];
                    [AccountModel sharedAccount].token = data[@"token"];
                    [AccountModel sharedAccount].expiry_time = [data[@"expiry_time"] integerValue];
                    UserModel *user = [UserModel mj_objectWithKeyValues:data[@"user"]];
                    [UserModel saveUserInfo:user];
                    [UserModel getAllFirends:nil];
                    if (callback) {
                        callback(user,nil,nil);
                    }
                }else{
                    if (callback) {
                        callback(nil,success[@"msg"],nil);
                    }
                }
            } failure:^(NSError *error) {
                if (callback) {
                    callback(nil,nil,error);
                }
            }];
        }else{
            if (error.code == 204) {
                callback(nil,@"账号不存在!",nil);
            }else{
                callback(nil,error.errorDescription,nil);
            }
        }
    }];
}

+(void)getUserInfo:(void (^)(UserModel *, NSString *, NSError *))callback{
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"token"] = [AccountModel sharedAccount].token;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,GETUSERINFOURL];
    [HTTPTools GET:url parameters:dict success:^(NSDictionary *success) {
        if ([success[@"code"] intValue] == 200) {
            UserModel *user = [UserModel mj_objectWithKeyValues:success[@"data"]];
            [UserModel saveUserInfo:user];
            callback(user,nil,nil);
        }else{
            callback(nil,success[@"msg"],nil);
        }
        
    } failure:^(NSError *error) {
        callback(nil,nil,error);
    }];
    
}


+(void)saveAccount:(AccountModel *)account{
    [NSKeyedArchiver archiveRootObject:account toFile:accountPath];
}

+(AccountModel *)getAccount{
    AccountModel *account =  [NSKeyedUnarchiver unarchiveObjectWithFile:accountPath];
    if(!account){
        return nil;
    }
    return account;
}

+(void)registers:(NSString *)account withPassword:(NSString *)password withName:(NSString *)name callback:(void (^)(NSInteger ,NSString *, NSError *))callback{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"account"] = account;
    dict[@"password"] = password;
    dict[@"name"] = name;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,REGISTERURL];
    [HTTPTools POST:url parameters:dict success:^(NSDictionary *success) {
        if ([success[@"code"] intValue] == 200) {
            [TQLoadingHUD showSuccessHud:@"注册成功!" completion:^(Boolean finish) {
                if (callback) {
                    callback(200,nil,nil);
                }
            }];
        }else{
            if (callback) {
                callback(101,success[@"msg"],nil);
            }
        }
    } failure:^(NSError *error) {
        if (callback) {
            callback(404,nil,error);
        }
    }];
}


@end
