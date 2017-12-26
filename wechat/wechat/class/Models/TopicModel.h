//
//  TopicModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/23.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TopicModel : NSObject

@property (nonatomic,strong) UserModel *user;
/** 帖子ID */
@property (nonatomic,assign) NSInteger Id;
/** 内容 */
@property (nonatomic,copy) NSString *content;
/** 发表时间 */
@property (nonatomic,assign) NSTimeInterval *create_time;
/** 点赞人 */
@property (nonatomic,strong) NSArray *praises;
/** 回复人 */
@property (nonatomic,strong) NSArray *replys;
/** 发表地点 */
@property (nonatomic,copy) NSString *location;
/** 图片 */
@property (nonatomic,strong)NSArray *images;

@end
