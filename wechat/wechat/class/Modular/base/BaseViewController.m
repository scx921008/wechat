//
//  BaseViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
}
-(void)pushViewController:(UIViewController *)viewController{
    viewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewController animated:YES];
}
-(void)popViewController{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)dismissViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}


@end
