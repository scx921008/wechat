//
//  FriendsCircleController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/20.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FriendsCircleController.h"
#import "FriendsCircleHeaderView.h"
#import "RefreshView.h"
#import "TweetsViewController.h"
@interface FriendsCircleController (){
    CGFloat _beginOffsetY;
    Boolean _isRefresh;
    Boolean _viewDidAppear;
}
@property (nonatomic,strong) FriendsCircleHeaderView *headerView;
@property (nonatomic,strong) RefreshView *refreshView;
@property (nonatomic,strong) UIImageView *imageView;
@end

@implementation FriendsCircleController

singleton_implementation(FriendsCircleController)

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(void)initSubView{
    [super initSubView];
    self.view.backgroundColor = HexRGB(0x2D3132);
    self.navigationItem.title = @"朋友圈";
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.contentInset = UIEdgeInsetsMake(270, 0, 0, 0);
    [self.tableView addSubview:self.headerView];

    self.refreshView = [[RefreshView alloc]initWithFrame:CGRectMake(20,TopHeight - 30, 30, 30)];
    
    [self.view addSubview:self.refreshView];
    
    
    self.imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"barbuttonicon_Camera"]];
    self.imageView.userInteractionEnabled = YES;
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:self.imageView];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    //点击手势
    UITapGestureRecognizer *clickGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(postTweets)];
    clickGesture.numberOfTapsRequired = 1;
    [self.imageView addGestureRecognizer:clickGesture];
    
    UILongPressGestureRecognizer *logGesture = [[UILongPressGestureRecognizer  alloc]initWithTarget:self action:@selector(longPressChange)];
    logGesture.minimumPressDuration = 1;
    [self.view addGestureRecognizer:logGesture];
    
}

-(void)longPressChange{
    NSLog(@"长按");
}
-(void)postTweets{
    NavigationController *navTweets = [[NavigationController alloc]initWithRootViewController:[TweetsViewController new]];
    [self presentViewController:navTweets animated:YES completion:nil];
}

//-(void)postStatus{
//    [self.refreshView endRefresh];
//    [UIView animateWithDuration:0.2 animations:^{
//        self.refreshView.y = TopHeight - 30;
//    }];
//}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    _viewDidAppear = YES;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _beginOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSInteger y = (NSInteger)(_beginOffsetY-offsetY);
    [self.refreshView setRotation:y];
    if(y < 60 && !self.refreshView.isRefresh){
        self.refreshView.y = (TopHeight + y) - 30;
    }else{
        if (_viewDidAppear) {
            [self.refreshView startRefresh];
        }
    }
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return [UITableViewCell new];
}






-(FriendsCircleHeaderView *)headerView{
    if(!_headerView){
        _headerView = [[FriendsCircleHeaderView alloc]initWithFrame:CGRectMake(0,-330-TopHeight,ScreenWidth, 320+TopHeight)];
    }
    return _headerView;
}


@end
