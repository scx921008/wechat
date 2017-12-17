//
//  UIView+CALayer.h
//  weibo
//
//  Created by sangcixiang on 17/1/3.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CALayer)
-(void)setLayerWithRadius:(CGFloat)readius color:(UIColor *)color width:(CGFloat )width;

/**
 readius: 圆角半径
 color  : 边线颜色
 width  : 连线宽度
 scolor : 阴影颜色
 size   : 阴影偏移量
 opacity: 阴影深度
 shadowRadius : 阴影角度
 */
-(void)setLayerRadius:(CGFloat  )readius
          borderColor:(UIColor *)color
          borderWidth:(CGFloat  )width
          shadowColor:(UIColor *)scolor
         shadowOffset:(CGSize   )size
        shadowOpacity:(CGFloat  )opacity
         shadowRadius:(CGFloat  )shadowRadius;

/** 截屏 */
-(UIImage *)captureImage;
/** 抖动 */
-(void)shakeAnimation;


-(void)transfromViewsx:(CGFloat)sx sy:(CGFloat)sy;


@end
