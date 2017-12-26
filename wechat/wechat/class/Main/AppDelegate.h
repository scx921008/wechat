//
//  AppDelegate.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//  这里是什么情况

#import <UIKit/UIKit.h>

#define NotificationNameNetChange @"NotificationNameNetChange"
#define NotificationMessagesDidReceive @"NotificationMessagesDidReceive"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,copy) NSString *longitude;
@property (nonatomic,copy) NSString *latitude;
@property (nonatomic,copy) NSString *location;
@property (nonatomic,copy) NSString *system;

-(void)setRootController:(UIViewController *)viewController;

@end

