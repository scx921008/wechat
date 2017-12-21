//
//  RefreshView.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/21.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefreshView : UIView


@property (nonatomic,assign) Boolean isRefresh;

-(void)setRotation:(CGFloat)rotation;

-(void)startRefresh;

-(void)endRefresh;

@end
