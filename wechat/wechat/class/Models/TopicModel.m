//
//  TopicModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/23.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "TopicModel.h"

@implementation TopicModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"Id": @"id"};
}

-(NSString *)timeStr{
    NSDateFormatter *fmt = [[NSDateFormatter alloc]init];
    
    NSDate *createDate = [NSDate dateWithTimeIntervalSince1970:_create_time];
    NSDate *new = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *cmps = [calendar components:unit fromDate:createDate toDate:new options:0];
    if([createDate isThisYear]){
        if([createDate isYesterday]){
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createDate];
        }else if([createDate isToday]){
            if(cmps.hour >= 1){
                return [NSString stringWithFormat:@"%d小时前",(int)cmps.hour];
            }else if(cmps.minute >= 1 && cmps.hour < 1){
                return [NSString stringWithFormat:@"%d分钟前",(int)cmps.minute];
            }else{
                return @"刚刚";
            }
        }else{
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createDate];
        }
    }else{
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createDate];
    }
    return nil;
}


@end

@implementation TopicModelF

-(void)setModel:(TopicModel *)model{
    _model = model;
    UserModel *user = model.user;
    CGFloat marage = 10;
    CGFloat top = 15;
    self.avatarF = CGRectMake(marage, top, 40, 40);
    
    CGSize nameSize = [user.name sizeWithFont:Font14];
    CGFloat nameX = CGRectGetMaxY(self.avatarF)+marage;
    self.nameF = (CGRect){{nameX,top},nameSize};
    
    CGFloat maxY = ScreenWidth - nameX - marage;
    CGSize contentSize = [model.content sizeWithFont:Font14 maxW:maxY];
    CGFloat contentY = CGRectGetMaxY(self.nameF)+marage;
    self.contnetF = (CGRect){{nameX,contentY},contentSize};
    
    CGFloat contentMaxY = CGRectGetMaxY(self.contnetF)+marage;
    if (model.location) {
        CGSize locationSize = [model.location sizeWithFont:Font12];
        CGFloat locationY = contentMaxY;
        self.locationF = (CGRect){{nameX,locationY},locationSize};
        contentMaxY = CGRectGetArea(self.locationF)+marage;
    }
    
    CGSize timeSize = [model.timeStr sizeWithFont:Font12];
    
    self.timeF = (CGRect){{nameX,contentMaxY},timeSize};
    
    self.cellHeight = CGRectGetMaxY(self.timeF)+top+1;

}

+(void)loadDataPage:(NSInteger)page isCache:(Boolean)isCache callback:(void (^)(NSArray<TopicModelF *> *, NSString *, NSError *))callback{
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,GETTOPICLISTURL];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"page"] = @(page);
    [HTTPTools GET:url parameters:dict success:^(NSDictionary *success) {
        if ([success[@"code"] intValue] == 200) {
            NSMutableArray *mutableArray = [NSMutableArray array];
            NSArray *array = [TopicModel mj_objectArrayWithKeyValuesArray:success[@"data"][@"list"]];
            for (TopicModel *model in array) {
                TopicModelF *modelF = [TopicModelF new];
                modelF.model = model;
                [mutableArray addObject:modelF];
            }
            callback(mutableArray,nil,nil);
        }else{
            callback(nil,success[@"msg"],nil);
        }
    } failure:^(NSError *error) {
        callback(nil,nil,error);
    }];
}



@end






