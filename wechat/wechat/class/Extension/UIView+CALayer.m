//
//  UIView+CALayer.m
//  weibo
//
//  Created by sangcixiang on 17/1/3.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "UIView+CALayer.h"

@implementation UIView (CALayer)

-(void)setLayerWithRadius:(CGFloat)readius color:(UIColor *)color width:(CGFloat )width{
    
    self.layer.masksToBounds = YES;
    self.layer.borderWidth = width;
    self.layer.borderColor = color.CGColor;
    self.layer.cornerRadius = readius;
}

-(void)setLayerRadius:(CGFloat)readius borderColor:(UIColor *)color borderWidth:(CGFloat )width shadowColor:(UIColor *)scolor shadowOffset:(CGSize)size shadowOpacity:(CGFloat)opacity shadowRadius:(CGFloat)shadowRadius{
    self.layer.cornerRadius = readius;
    self.layer.borderColor  = color.CGColor;
    self.layer.borderWidth  = width;
    self.layer.shadowColor  = scolor.CGColor;
    self.layer.shadowOffset = size;
    self.layer.shadowOpacity= opacity;
    self.layer.shadowRadius = shadowRadius;
    
}
-(void)shakeAnimation{
    CABasicAnimation* shake = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
    shake.fromValue = [NSNumber numberWithFloat:-3];
    shake.toValue = [NSNumber numberWithFloat:3];
    shake.duration = 0.1;//执行时间
    shake.autoreverses = YES; //是否重复
    shake.repeatCount = 2;//次数
    [self.layer addAnimation:shake forKey:@"shakeAnimation"];
}




-(UIImage *)captureImage{
    CGRect screenRect = [self bounds];
    UIGraphicsBeginImageContext(screenRect.size);
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:ctx];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

-(void)transfromViewsx:(CGFloat)sx sy:(CGFloat)sy{
    
    [UIView animateWithDuration:0.2 animations:^{
        self.transform = CGAffineTransformMakeScale(sx,sy);
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
    }];
}


@end
