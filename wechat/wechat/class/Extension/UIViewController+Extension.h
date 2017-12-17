//
//  UIViewController+Extension.h
//  EMC
//
//  Created by apple on 2017/3/11.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum : NSInteger {
    NotReachable = 0,//没有网络
    ReachableViaWiFi,//当前使用Wifi网络
    ReachableViaWWAN //使用的蜂窝网络
} NetworkStatus;

@interface UIViewController (Extension)
/** Gif加载状态 */
@property(nonatomic, weak) UIImageView *gifView;

/** 主界面使用的加载 */
@property (nonatomic, weak) UIImageView *loadImageView;
/** 显示GIF加载动画 */
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view;
/**
 *  取消GIF加载动画
 */
- (void)hideGufLoding;

/** 开始显示loading视图 */
-(void)showLoading:(NSString*)text;
/** 关闭loading视图 */
-(void)hideLoading;

-(void)openAlertControllerTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style actionTitle1:(NSString *)actionTitle1 actionTitle2:(NSString *)actionTitle2 callback:(void (^)(int index))callback;


//-(void)httpGetUrl:(NSString *)url withParmas:(NSMutableDictionary *)parameters callBack:(void(^)(NSDictionary *result,int statusCode))callback;

- (int)networkingStatesFromStatebar;

@end
