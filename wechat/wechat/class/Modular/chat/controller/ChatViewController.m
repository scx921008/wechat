//
//  ChatViewController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/18.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ChatViewController.h"
#import "ChatTabBarView.h"
@interface ChatViewController (){
    UserModel *_friends;
    EMConversation *_conversation;
}
@property (nonatomic,strong) ChatTabBarView *tabBarView;
@end

@implementation ChatViewController

-(instancetype)initWithUser:(UserModel *)user chatType:(EMConversationType)chatType{
    
    if(self = [super init]){
        _friends = user;
        //初始化聊天像
        _conversation = [[EMClient sharedClient].chatManager getConversation:user.account type:chatType createIfNotExist:YES];
        //像所有未读数量清空
        [_conversation markAllMessagesAsRead:nil];
    }
    return self;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNavigation];
    [self addObserver];
}


-(void)initNavigation{
    self.navigationItem.title = _friends.name;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_InfoSingle"] style:UIBarButtonItemStyleDone target:nil action:nil];
    self.navigationItem.rightBarButtonItem = rightItem;
}

-(void)initSubView{
    [super initSubView];
    self.tableView.mj_footer = nil;
    self.tableView.mj_header = nil;
    self.tableView.height = self.view.height - 45;
    ChatTabBarView *tabBarView = [ChatTabBarView tabBarView];
    tabBarView.frame = CGRectMake(0,self.view.height - 45, self.view.width, 45);
    [self.view addSubview:tabBarView];
    self.tabBarView = tabBarView;
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
