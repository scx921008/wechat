//
//  UIView+Frame.h
//  weibo
//
//  Created by sangcixiang on 17/1/3.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)
@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@end
