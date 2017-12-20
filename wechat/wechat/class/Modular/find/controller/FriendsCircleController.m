//
//  FriendsCircleController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/20.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FriendsCircleController.h"
#import "FriendsCircleHeaderView.h"
@interface FriendsCircleController (){
    CGFloat _beginOffsetY;
    Boolean _isRefresh;
}
@property (nonatomic,strong) FriendsCircleHeaderView *headerView;
@property (nonatomic,strong) UIView *refreshView;
@property (nonatomic,strong) UIImageView *refreshImage;
@end

@implementation FriendsCircleController

singleton_implementation(FriendsCircleController)

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

-(void)initSubView{
    [super initSubView];
    self.view.backgroundColor = HexRGB(0x2D3132);
    self.tableView.mj_header = nil;
    self.tableView.mj_footer = nil;
    self.tableView.contentInset = UIEdgeInsetsMake(270, 0, 0, 0);
    [self.tableView addSubview:self.headerView];
    
    
    self.refreshView = [[UIView alloc]initWithFrame:CGRectMake(20,TopHeight - 30, 30, 30)];
    [self.view addSubview:self.refreshView];
    self.refreshImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.refreshImage.image = [UIImage imageNamed:@"AlbumReflashIcon"];
    [self.refreshView addSubview:self.refreshImage];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    _beginOffsetY = scrollView.contentOffset.y;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSInteger y = (NSInteger)(_beginOffsetY-offsetY);
    NSLog(@"%ld",(long)y);
    if(y < 50 && !_isRefresh){
        self.refreshView.y = (TopHeight + y) - 30;
    }else{
        [self refresh];
    }
    self.refreshImage.transform = CGAffineTransformMakeRotation(-M_PI/180*y*5);
}

-(void)refresh{
    NSLog(@"刷新");
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
