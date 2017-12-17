//
//  FindModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FindModel.h"

@implementation FindModel

+(NSArray<NSArray<FindModel *> *> *)loadData{
    
    NSMutableArray *group = [NSMutableArray array];
    NSMutableArray *items = [NSMutableArray array];
    FindModel *model = [FindModel new];
    model.icon = @"ff_IconShowAlbum";
    model.name = @"朋友圈";
    [items addObject:model];
    [group addObject:items];
    
    items = [NSMutableArray array];
    model = [FindModel new];
    model.icon = @"ff_IconQRCode";
    model.name = @"扫一扫";
    [items addObject:model];
    
    model = [FindModel new];
    model.icon = @"ff_IconShake";
    model.name = @"摇一摇";
    [items addObject:model];
    [group addObject:items];
    
    
    items = [NSMutableArray array];
    model = [FindModel new];
    model.icon = @"ff_IconLocationService";
    model.name = @"附近的人";
    [items addObject:model];
    
    model = [FindModel new];
    model.icon = @"ff_IconBottle";
    model.name = @"漂流瓶";
    [items addObject:model];
    [group addObject:items];
    
    items = [NSMutableArray array];
    model = [FindModel new];
    model.icon = @"MoreWeApp";
    model.name = @"小程序";
    [items addObject:model];
    [group addObject:items];
    
    return group;
}

@end
