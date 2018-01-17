//
//  TweetViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/28.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()
@property (nonatomic,strong) UIToolbar *toolbar;
/** 发送按钮 */
@property (nonatomic,strong) UIBarButtonItem *postItem;
@end

@implementation TweetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0,-(self.view.width/3), ScreenWidth, self.view.width/3)];
    view.backgroundColor = [UIColor redColor];
    self.tableView.contentInset = UIEdgeInsetsMake(self.view.width/3, 0, TabBarHeight, 0);
    [self.tableView addSubview:view];
    UIBarButtonItem *tabbarItem = [[UIBarButtonItem alloc]initWithTitle:@"第一个" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    self.toolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, self.view.height - TabBarHeight, ScreenWidth, TabBarHeight)];
    [self.toolbar setItems:@[tabbarItem]];
    [self.view addSubview:self.toolbar];
}
#pragma mark -- 初始化导航栏
-(void)initNavigation{
    
    UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismissViewController)];
    self.navigationItem.leftBarButtonItem = cancel;
    
    self.postItem = [[UIBarButtonItem alloc]initWithTitle:@"发表" style:UIBarButtonItemStylePlain target:self action:@selector(test)];
//    self.postItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = self.postItem;
    
}
-(void)test{
    UIEdgeInsets insets = self.tableView.contentInset;
    insets.top += 30;
    self.tableView.contentInset = insets;
    [self.tableView scrollToTop];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return section == 0 ? 1:2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cee"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}


@end
