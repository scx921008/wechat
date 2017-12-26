//
//  FriendsCircleCell.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/26.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicModel.h"
@interface FriendsCircleCell : UITableViewCell
+(NSString *)cellIndentifier;
+(FriendsCircleCell *)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)indentifier;

@property (nonatomic,strong) TopicModelF *modelF;

@end
