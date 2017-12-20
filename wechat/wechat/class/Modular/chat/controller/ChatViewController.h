//
//  ChatViewController.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/18.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "BaseTableViewController.h"

@interface ChatViewController : BaseTableViewController


- (instancetype)initWithUser:(UserModel *)user chatType:(EMConversationType)chatType;

@end
