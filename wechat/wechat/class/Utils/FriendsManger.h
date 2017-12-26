//
//  FriendsManger.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserModel.h"
@interface FriendsManger : NSObject

+(void)saveFriends:(NSArray *)users;

+(void)getFriends:(void(^)(NSArray <UserModel *>* firends))callback;

@end
