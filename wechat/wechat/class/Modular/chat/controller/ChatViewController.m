//
//  ChatViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/18.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTabBarView.h"
@interface ChatViewController ()
@property (nonatomic,strong) ChatTabBarView *tabBarView;
@end

@implementation ChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self initSubView];
    [self addObserver];
}


-(void)initNavigation{
    self.navigationItem.title = self.friends.name;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_InfoSingle"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initSubView{
    self.tabBarView = [ChatTabBarView tabBarView];
    self.tabBarView.frame = CGRectMake(0,self.view.height - 45, self.view.width, 45);
    [self.view addSubview:self.tabBarView];
}

-(void)addObserver{
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(showKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}
-(void)hideKeyboard:(NSNotification *)notification{
    [UIView animateWithDuration:0.25 animations:^{
        self.tabBarView.y = self.view.height - self.tabBarView.height;
    }];
}

-(void)showKeyboard:(NSNotification *)notification{
    //获取键盘弹出后的Rect
    CGRect  frame = [[[notification userInfo]objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:0.25 animations:^{
        self.tabBarView.y = self.view.height - (frame.size.height + self.tabBarView.height);
    }];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
