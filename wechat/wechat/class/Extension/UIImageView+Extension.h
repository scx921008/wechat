//
//  UIImageView+Extension.h
//  LoveLive
//
//  Created by 桑赐相 on 2017/6/10.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Extension)
// 播放GIF
- (void)playGifAnim:(NSArray *)images duration:(CGFloat)duration count:(NSInteger)count;
// 停止动画
- (void)stopGifAnim;
@end
