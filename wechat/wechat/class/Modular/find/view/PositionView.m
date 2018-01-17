//
//  PositionView.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/27.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "PositionView.h"

@implementation PositionView

+(instancetype)positionView{
    PositionView *view = [[[NSBundle mainBundle]loadNibNamed:@"PositionView" owner:nil options:nil]lastObject];
    return view;
}

@end
