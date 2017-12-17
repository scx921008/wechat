//
//  FindModel.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FindModel : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;

+(NSArray <NSArray<FindModel *> *> *)loadData;

@end
