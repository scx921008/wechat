//
//  AccountModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/23.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface AccountModel : NSObject

+ (instancetype)sharedAccount;

@property (nonatomic,assign) NSInteger Id;
/** 账号 */
@property (nonatomic,copy) NSString *account;
/** token */
@property (nonatomic,copy) NSString *token;
/** 过期时间 */
@property (nonatomic,assign) NSInteger expiry_time;

/**
 用户登入
 
 @param account 登入账号
 @param password 登入密码
 @param callback 登入回调信息
 */
+(void)login:(NSString *)account
withPassword:(NSString *)password
    callback:(void(^)(UserModel *user,NSString *msg,NSError *error))callback;

+(void)getUserInfo:(void(^)(UserModel *user,NSString *msg,NSError *error))callback;;

/**
 用户注册
 
 @param account 注册账号
 @param password 注册密码
 @param name 注册昵称
 @param callback 回调注册信息
 */
+(void)registers:(NSString *)account
    withPassword:(NSString *)password
        withName:(NSString *)name
        callback:(void(^)(NSInteger code,NSString *msg,NSError *error))callback;

@end
