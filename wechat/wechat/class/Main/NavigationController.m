//
//  NavigationController.m
//  weibo
//
//  Created by sangcixiang on 17/1/2.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "NavigationController.h"
@interface NavigationController ()<UIGestureRecognizerDelegate>

@end

@implementation NavigationController

+(void)initialize{

}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSMutableDictionary *titleTextAttributes = [NSMutableDictionary dictionary];
    titleTextAttributes[NSFontAttributeName] = Font20;
    titleTextAttributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [self.navigationBar setTitleTextAttributes:titleTextAttributes];
    self.navigationBar.barTintColor = navColor;
    [self.navigationBar setTintColor:[UIColor whiteColor]];

}




@end
