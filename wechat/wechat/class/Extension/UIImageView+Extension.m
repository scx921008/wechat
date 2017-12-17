//
//  UIImageView+Extension.m
//  LoveLive
//
//  Created by 桑赐相 on 2017/6/10.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "UIImageView+Extension.h"

@implementation UIImageView (Extension)
// 播放GIF
- (void)playGifAnim:(NSArray *)images duration:(CGFloat)duration count:(NSInteger)count{
    if (!images.count) {
        return;
    }
    //动画图片数组
    self.animationImages = images;
    //执行一次完整动画所需的时长
    self.animationDuration = duration;
    //动画重复次数, 设置成0 就是无限循环
    self.animationRepeatCount = 0;
    [self startAnimating];
}
// 停止动画
- (void)stopGifAnim
{
    if (self.isAnimating) {
        [self stopAnimating];
    }
    [self removeFromSuperview];
}
- (UIImage *)blurryImage:(UIImage *)image withMaskImage:(UIImage *)maskImage blurLevel:(CGFloat)blur {
    
    // 创建属性
    CIImage *ciImage = [[CIImage alloc] initWithImage:image];
    
    // 滤镜效果 高斯模糊
    //    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    //    [filter setValue:cimage forKey:kCIInputImageKey];
    //    // 指定模糊值 默认为10, 范围为0-100
    //    [filter setValue:[NSNumber numberWithFloat:blur] forKey:@"inputRadius"];
    
    /**
     *  滤镜效果 VariableBlur
     *  此滤镜模糊图像具有可变模糊半径。你提供和目标图像相同大小的灰度图像为它指定模糊半径
     *  白色的区域模糊度最高，黑色区域则没有模糊。
     */
    CIFilter *filter = [CIFilter filterWithName:@"CIMaskedVariableBlur"];
    // 指定过滤照片
    [filter setValue:ciImage forKey:kCIInputImageKey];
    CIImage *mask = [CIImage imageWithCGImage:maskImage.CGImage] ;
    // 指定 mask image
    [filter setValue:mask forKey:@"inputMask"];
    // 指定模糊值  默认为10, 范围为0-100
    [filter setValue:[NSNumber numberWithFloat:blur] forKey: @"inputRadius"];
    
    // 生成图片
    CIContext *context = [CIContext contextWithOptions:nil];
    // 创建输出
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    
    // 下面这一行的代码耗费时间内存最多,可以开辟线程处理然后回调主线程给imageView赋值
    //result.extent 指原来的大小size
    //    NSLog(@"%@",NSStringFromCGRect(result.extent));
    //    CGImageRef outImage = [context createCGImage: result fromRect: result.extent];
    
    CGImageRef outImage = [context createCGImage: result fromRect:CGRectMake(0, 0, 320.0 * 2, 334.0 * 2)];
    UIImage * blurImage = [UIImage imageWithCGImage:outImage];
    
    return blurImage;
}

@end
