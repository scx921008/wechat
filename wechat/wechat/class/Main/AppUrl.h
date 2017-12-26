//
//  Constant.h
//  New_APP
//
//  Created by 桑赐相 on 2017/11/21.
//  Copyright © 2017年 桑赐相. All rights reserved.
//  aaa

#ifndef Constant_h
#define Constant_h

#import <Foundation/Foundation.h>

/**  主域名 */
static NSString *domain = @"http://192.168.1.2/api/";
/** 注册 */
static NSString *REGISTERURL = @"account/register";
/** 登入 */
static NSString *LOGINURL = @"account/login";
/** 获取账号信息 */
static NSString *GETUSERINFOURL = @"user/getUserInfo";
/** 获取所有的好友 */
static NSString *GETAllFIRENDSURL = @"user/getFriends";
/** 发表帖子带图片 */
static NSString *POSTTOPICURL = @"topic/postTopic";
/** 获取帖子列表 */
static NSString *GETTOPICLISTURL = @"topic/getTopic";











#endif /* Constant_h */
