//
//  UserModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "UserModel.h"
#import "TabBarController.h"
@implementation UserModel

MJCodingImplementation

-(NSString *)name{
    return _name?_name:_account;
}

-(NSString *)explains{
    return _explains?_explains:@"好像还什么都没写...";
}

+(void)login:(NSString *)account withPassword:(NSString *)password callback:(void (^)(NSString *, NSError *))callback{
    [TQLoadingHUD showLoadingHud:@"登录中..."];
    [[EMClient sharedClient]loginWithUsername:account password:password completion:^(NSString *aUsername, EMError *error) {
        if (!error){
            NSMutableDictionary *dict = [NSMutableDictionary dictionary];
            dict[@"account"] = account;
            dict[@"password"] = password;
            NSString *url = [NSString stringWithFormat:@"%@%@",domain,LOGINURL];
            [HTTPTools POST:url parameters:dict success:^(NSDictionary *success) {
                NSLog(@"%@",success);
                if ([success[@"code"] intValue] == 200) {
                    [TQLoadingHUD hideView];
                    [[EMClient sharedClient].options setIsAutoLogin:YES];
                    UserModel *user = [UserModel mj_objectWithKeyValues:success[@"data"]];
                    [UserModel saveUser:user];
                    [UserModel getAllFirends:nil];
                    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                    [defaults setObject:account forKey:@"account"];
                    [defaults setObject:password forKey:@"password"];
                    if (callback) {
                        callback(nil,nil);
                    }
                }else{
                    [TQLoadingHUD showErrorHud:success[@"msg"]];
                }
            } failure:^(NSError *error) {
                [TQLoadingHUD hideView];
            }];
        }else{
            if (error.code == 204) {
                [TQLoadingHUD showErrorHud:@"账号不存在!"];
            }else{
                [TQLoadingHUD showErrorHud:error.errorDescription];
            }
        }
    }];
}

+(void)getAllFirends:(void (^)(NSArray<UserModel *> *))callback{
    
    UserModel *user = [UserModel getUserInfo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"account"] = user.account;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,GETAllFIRENDSURL];
    [HTTPTools GET:url parameters:dict success:^(NSDictionary *success) {
        NSArray *array = [UserModel mj_objectArrayWithKeyValuesArray:success[@"data"]];
        [FriendsManger saveFriends:array];
        if (callback) {
            callback(array);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


+(void)registers:(NSString *)account withPassword:(NSString *)password withName:(NSString *)name callback:(void (^)(NSString *, NSError *))callback{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"account"] = account;
    dict[@"password"] = password;
    dict[@"name"] = name;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,REGISTERURL];
    [TQLoadingHUD showLoadingHud:@"注册中..."];
    [HTTPTools POST:url parameters:dict success:^(NSDictionary *success) {
        if ([success[@"code"] intValue] == 200) {
            [TQLoadingHUD showSuccessHud:@"注册成功!" completion:^(Boolean finish) {
                if (callback) {
                    callback(nil,nil);
                }
            }];
        }else{
            [TQLoadingHUD showErrorHud:success[@"msg"]];
        }
    } failure:^(NSError *error) {
        [TQLoadingHUD hideView];
    }];
}

+(void)saveUser:(UserModel *)user{
    [NSKeyedArchiver archiveRootObject:user toFile:UserPath];
}

+(UserModel *)getUserInfo{
    UserModel *user =  [NSKeyedUnarchiver unarchiveObjectWithFile:UserPath];
    if(!user){
        return nil;
    }
    return user;
}

@end
