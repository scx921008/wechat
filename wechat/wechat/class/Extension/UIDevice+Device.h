//
//  UIDevice+Device.h
//  meinvtu
//
//  Created by apple on 2017/2/26.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIDevice (Device)
/**
 *  强制旋转设备
 */
+ (void)setOrientation:(UIInterfaceOrientation)orientation;
+ (BOOL)isOrientationLandscape;
@end
