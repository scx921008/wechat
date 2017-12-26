//
//  UserModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic,assign) NSInteger Id;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,assign) NSInteger sex;
@property (nonatomic,copy) NSString *avatar;
@property (nonatomic,copy) NSString *explains;
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *email;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,assign) NSInteger login_time;

/** 保存自己的信息 */
+(void)saveUserInfo:(UserModel *)user;
/** 获取自己的信息 */
+(UserModel *)getUserInfo;

/**获取好友信息*/
+(void)getAllFirends:(void(^)(NSArray <UserModel *>*))callback;




@end
