//
//  TQLoadingHUD.h
//  New_APP
//
//  Created by 桑赐相 on 2017/12/2.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ALLoadingView.h"

@interface TQLoadingHUD : UIView

@property (nonatomic,strong) ALLoadingView *loadingView;
@property (nonatomic,copy) NSString *message;





+(void)showLoadingHud:(NSString *)message;

+(void)showSuccessHud:(NSString *)message;

+(void)showSuccessHud:(NSString *)message completion:(void(^)(Boolean finish))completion;

+(void)showErrorHud:(NSString *)message;
+(void)showWarningHud:(NSString *)message;

+(void)hideView;

@end
