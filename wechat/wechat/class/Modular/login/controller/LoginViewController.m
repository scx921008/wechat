//
//  LoginViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "TabBarController.h"
#import "UserModel.h"
@interface LoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *accountField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    self.accountField.text = [userDefault objectForKey:@"account"];
}
- (IBAction)forgetPassword:(UIButton *)sender {
}

- (IBAction)loginAction:(UIButton *)sender {
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    if (account.length <= 0) {
        [MBProgressHUD showError:@"账号不能为空!"];
        return;
    }
    if(password.length <= 0){
        [MBProgressHUD showError:@"密码不能为空!"];
        return;
    }
    [UserModel login:account withPassword:password callback:^(NSString *msg, NSError *error) {
        if (!msg && !error) {
            UIWindow *window = KeyWindow;
            window.rootViewController = [TabBarController new];
        }
    }];
    
}

- (IBAction)registerAcciont:(UIButton *)sender {
    
    [self presentViewController:[RegisterViewController new] animated:YES completion:nil];
    
}




@end

