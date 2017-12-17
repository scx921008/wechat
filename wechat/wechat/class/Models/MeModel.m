//
//  MeModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "MeModel.h"

@implementation MeModel
+(NSArray<NSArray<MeModel *> *> *)loadData{
    
    NSMutableArray *group = [NSMutableArray array];
    NSMutableArray *items = [NSMutableArray array];
    MeModel *model = [MeModel new];
    model.icon = @"MoreMyBankCard";
    model.name = @"钱包";
    [items addObject:model];
    [group addObject:items];
    
    items = [NSMutableArray array];
    model = [MeModel new];
    model.icon = @"MoreMyFavorites";
    model.name = @"收藏";
    [items addObject:model];
    
    model = [MeModel new];
    model.icon = @"MoreMyAlbum";
    model.name = @"相册";
    [items addObject:model];

    model = [MeModel new];
    model.icon = @"MyCardPackageIcon";
    model.name = @"卡包";
    [items addObject:model];
    
    model = [MeModel new];
    model.icon = @"MoreExpressionShops";
    model.name = @"表情";
    [items addObject:model];
    [group addObject:items];
    
    items = [NSMutableArray array];
    model = [MeModel new];
    model.icon = @"MoreSetting";
    model.name = @"设置";
    [items addObject:model];
    [group addObject:items];
    
    return group;
}

@end
