//
//  UserModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject
/** 用户ID */
@property (nonatomic,assign) NSInteger Id;
/** 用户账号 */
@property (nonatomic,copy) NSString *account;
/** 名字 */
@property (nonatomic,copy) NSString *name;
/** 性别 */
@property (nonatomic,assign) NSInteger sex;
/** 头像 */
@property (nonatomic,copy) NSString *avatar;
/** 个人说明 */
@property (nonatomic,copy) NSString *explains;
/** 手机号码 */
@property (nonatomic,copy) NSString *phone;
/** 邮箱 */
@property (nonatomic,copy) NSString *email;
/** 常在地 */
@property (nonatomic,copy) NSString *address;
/** 最后所在地 */
@property (nonatomic,copy) NSString *location;
/** 最后登入时间 */
@property (nonatomic,assign) NSInteger login_time;

/** 保存自己的信息 */
+(void)saveUserInfo:(UserModel *)user;
/** 获取自己的信息 */
+(UserModel *)getUserInfo;

/**获取好友信息*/
+(void)getAllFirends:(void(^)(NSArray <UserModel *>*))callback;




@end
