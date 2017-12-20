//
//  AppDelegate.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import <UIKit/UIKit.h>

#define NotificationNameNetChange @"NotificationNameNetChange"
#define NotificationMessagesDidReceive @"NotificationMessagesDidReceive"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic,copy) NSString *loc;
@property (nonatomic,copy) NSString *lat;
@property (nonatomic,copy) NSString *system;
@property (nonatomic,copy) NSString *location;
@end

