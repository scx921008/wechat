//
//  TopicModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/23.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TopicModel : NSObject


/** 帖子ID */
@property (nonatomic,assign) NSInteger Id;
/** 内容 */
@property (nonatomic,copy) NSString *content;
/** 发表的类型 0纯文本、1带图片、2视频 */
@property (nonatomic,assign) NSInteger media_type;
/** 发表地点 */
@property (nonatomic,copy) NSString *location;
/** 图片 */
@property (nonatomic,strong)NSArray *images;
/** 回复人 */
@property (nonatomic,strong) NSArray *replys;
/** 视频信息 */
@property (nonatomic,strong) NSArray *video;
/** 点赞人 */
@property (nonatomic,strong) NSArray *praises;
/** 发表人 */
@property (nonatomic,strong) UserModel *user;
/** 发表时间 时间戳 */
@property (nonatomic,assign) NSTimeInterval create_time;
/** 发表时间 字符串 */
@property (nonatomic,copy) NSString *timeStr;


@end


@interface TopicModelF : NSObject

@property (nonatomic,assign) CGRect avatarF;
@property (nonatomic,assign) CGRect nameF;
@property (nonatomic,assign) CGRect contnetF;
@property (nonatomic,assign) CGRect locationF;
@property (nonatomic,assign) CGRect timeF;
@property (nonatomic,assign) CGFloat cellHeight;
@property (nonatomic,strong) TopicModel *model;

+(void)loadDataPage:(NSInteger)page isCache:(Boolean)isCache callback:(void(^)(NSArray <TopicModelF *> *models,NSString *msg,NSError *error))callback;

@end















