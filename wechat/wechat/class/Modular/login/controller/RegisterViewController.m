//
//  RegisterViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *accountField;

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (IBAction)closeAction:(UIButton *)sender {
    [self dismissViewController];
}

- (IBAction)registerAction:(UIButton *)sender {
    NSString *account = self.accountField.text;
    NSString *password = self.passwordField.text;
    NSString *name = self.nameField.text;
    NSString * regex = @"^[A-Za-z0-9]{6,15}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:account];
    if (!isMatch) {
        [MBProgressHUD showError:@"账号格式不对!"];
        return;
    }
    if (password.length < 6) {
        [MBProgressHUD showError:@"密码不能少于6位!"];
        return;
    }
    if (name.length <= 0) {
        [MBProgressHUD showError:@"昵称不能为空!"];
        return;
    }
    if (name.length > 10) {
        [MBProgressHUD showError:@"昵称长度不能大于10位!"];
        return;
    }
    [UserModel registers:account withPassword:password withName:name callback:^(NSString *msg, NSError *error) {
        if (!msg && !error) {
            [self dismissViewController];
        }
    }];
}







@end
