//
//  TabBarController.m
//  weibo
//
//  Created by sangcixiang on 17/1/2.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "TabBarController.h"
#import "NavigationController.h"
#import "HomeController.h"
#import "ContactsController.h"
#import "FindController.h"
#import "MeController.h"

@interface TabBarController ()<UITabBarControllerDelegate>

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    HomeController *wechat = [HomeController new];
    NavigationController *wechatNav = [[NavigationController alloc]initWithRootViewController:wechat];
    [self addController:wechat title:@"微信" image:@"tabbar_mainframe" selectedImage:@"tabbar_mainframeHL"];
    
    
    ContactsController *contacts = [ContactsController new];
    NavigationController *contactsNav = [[NavigationController alloc]initWithRootViewController:contacts];
    [self addController:contacts title:@"联系人" image:@"tabbar_contacts" selectedImage:@"tabbar_contactsHL"];
    
    FindController *find = [FindController new];
    NavigationController *findNav = [[NavigationController alloc]initWithRootViewController:find];
    [self addController:find title:@"发现" image:@"tabbar_discover" selectedImage:@"tabbar_discoverHL"];
    
    MeController *me = [MeController new];
    NavigationController *meNav = [[NavigationController alloc]initWithRootViewController:me];
    [self addController:me title:@"我的" image:@"tabbar_me" selectedImage:@"tabbar_meHL"];
    
    self.viewControllers = @[wechatNav,contactsNav,findNav,meNav];
    
    self.delegate = self;
    
    /** 设置tabbar字体颜色 */
    NSDictionary *dictNormal = @{NSForegroundColorAttributeName:GrayColor186,NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [[UITabBarItem appearance] setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    NSDictionary *dictSelected = @{NSForegroundColorAttributeName:mainColor,NSFontAttributeName:[UIFont systemFontOfSize:14]};
    [[UITabBarItem appearance] setTitleTextAttributes:dictSelected forState:UIControlStateSelected];
    
}
-(void)addController:(UIViewController *)controller title:(NSString *)title image:(NSString *)imageName selectedImage:(NSString *)selectedImage{
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [self imageName:imageName];
    controller.tabBarItem.selectedImage = [self imageName:selectedImage];
    controller.title = title;
}

-(UIImage *)imageName:(NSString *)image{
    
    UIImage *OriginalImage = [UIImage imageNamed:image];
    OriginalImage = [OriginalImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    return OriginalImage;
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

















@end
