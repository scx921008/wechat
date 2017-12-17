//
//  ContactsTableViewCell.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "UserModel.h"
@interface ContactsTableViewCell : BaseTableViewCell
@property (nonatomic,strong) UserModel *model;
@end
