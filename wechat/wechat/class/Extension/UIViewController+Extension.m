//
//  UIViewController+Extension.m
//  EMC
//
//  Created by apple on 2017/3/11.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "UIViewController+Extension.h"
#import <objc/message.h>
#import "UIImageView+Extension.m"
static const void *GifKey    = &GifKey;
static const void *ImageViewKey = &ImageViewKey;
@implementation UIViewController (Extension)

- (UIImageView *)gifView{
    return objc_getAssociatedObject(self, GifKey);
}

- (void)setGifView:(UIImageView *)gifView{
    objc_setAssociatedObject(self, GifKey, gifView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIImageView *)loadImageView{
    return objc_getAssociatedObject(self, ImageViewKey);
}


- (void)setLoadImageView:(UIImageView *)loadImageView{
    objc_setAssociatedObject(self, ImageViewKey, loadImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}


// 显示GIF加载动画
- (void)showGifLoding:(NSArray *)images inView:(UIView *)view{
    if (!images.count) {
        images = @[[UIImage imageNamed:@"portrait_loading1_107x31_"],
                   [UIImage imageNamed:@"portrait_loading2_107x31_"],
                   [UIImage imageNamed:@"portrait_loading3_107x31_"],
                   [UIImage imageNamed:@"portrait_loading4_107x31_"],
                   [UIImage imageNamed:@"portrait_loading5_107x31_"],
                   [UIImage imageNamed:@"portrait_loading6_107x31_"],
                   [UIImage imageNamed:@"portrait_loading7_107x31_"],
                   [UIImage imageNamed:@"portrait_loading8_107x31_"],
                   [UIImage imageNamed:@"portrait_loading9_107x31_"],
                   [UIImage imageNamed:@"portrait_loading10_107x31_"],];
    }
    UIImageView *gifView = [[UIImageView alloc] init];
    gifView.contentMode = UIViewContentModeScaleAspectFit;
    if (!view) {
        view = self.view;
    }
    [view addSubview:gifView];
    [gifView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@80);
        make.height.equalTo(@80);
    }];
    self.gifView = gifView;
    [gifView playGifAnim:images duration:2 count:0];
    
}

// 取消GIF加载动画
- (void)hideGufLoding{
    [self.gifView stopGifAnim];
    self.gifView = nil;
}

/** 开始显示loading视图 */
-(void)showLoading:(NSString*)text{
    NSArray *images = @[[UIImage imageNamed:@"hold1_60x72"],
                        [UIImage imageNamed:@"hold2_60x72"],
                        [UIImage imageNamed:@"hold3_60x72"]];
    UIImageView *loadView = [[UIImageView alloc] init];
    
    [self.view addSubview:loadView];
    [loadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(@0);
        make.width.equalTo(@130);
        make.height.equalTo(@130);
    }];
    self.loadImageView = loadView;
    [loadView playGifAnim:images duration:2 count:0];
}

/** 关闭loading视图 */
-(void)hideLoading{
    [self.loadImageView stopGifAnim];
    self.loadImageView = nil;
}


-(void)openAlertControllerTitle:(NSString *)title message:(NSString *)message style:(UIAlertControllerStyle)style actionTitle1:(NSString *)actionTitle1 actionTitle2:(NSString *)actionTitle2 callback:(void (^)(int))callback{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    if (actionTitle1) {
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            callback(1);
        }];
        [alert addAction:action1];
    }
    if (actionTitle2) {
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            callback(2);
        }];
        [alert addAction:action2];
    }
    UIAlertAction *action0 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        callback(0);
    }];
    
    
    if (style == UIAlertControllerStyleActionSheet) {
        [alert addAction:action0];
    }
    [self presentViewController:alert animated:YES completion:nil];
}


- (int)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];
    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];
    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }
    // 0==没有网络，1==2G，2==3G,3==4G,4==LTE,5==WIFI
    return type;
}



@end
