//
//  BaseViewController.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController




-(void)pushViewController:(UIViewController *)viewController;

-(void)popViewController;
-(void)dismissViewController;

@end
