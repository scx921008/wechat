//
//  UserModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,assign) NSInteger uid;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *explains;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *last_time;

+(void)saveUser:(UserModel *)user;
+(UserModel *)getUserInfo;

+(void)getAllFirends:(void(^)(NSArray <UserModel *>*))callback;

+(void)login:(NSString *)account
withPassword:(NSString *)password
    callback:(void(^)(NSString *msg,NSError *error))callback;

+(void)registers:(NSString *)account
    withPassword:(NSString *)password
        withName:(NSString *)name
        callback:(void(^)(NSString *msg,NSError *error))callback;
@end
