//
//  ContactsController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ContactsController.h"
#import "ContactsTableViewCell.h"
#import "BMChineseSort.h"
#import "ContactsIndexView.h"
#import "ChatViewController.h"
#import "EaseMessageViewController.h"
@interface ContactsController ()<ContactsIndexViewDelegate,UISearchResultsUpdating>
//排序后的出现过的拼音首字母数组

@property (nonatomic,strong) UISearchController *searchController;
@property(nonatomic,strong)NSMutableArray *indexArray;
@property (nonatomic,strong) ContactsIndexView *indexView;

@end

@implementation ContactsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFriends];
}
-(void)initSubView{
    [super initSubView];
    
    // 创建UISearchController, 这里使用当前控制器来展示结果
    UISearchController *search = [[UISearchController alloc]initWithSearchResultsController:nil];
    // 设置结果更新代理
    search.searchResultsUpdater = self;
    search.searchBar.barTintColor = [UIColor groupTableViewBackgroundColor];
    // 因为在当前控制器展示结果, 所以不需要这个透明视图
    search.dimsBackgroundDuringPresentation = YES;
    self.searchController = search;
    // 将searchBar赋值给tableView的tableHeaderView
    self.tableView.tableHeaderView = search.searchBar;
    [self.tableView registerNib:[UINib nibWithNibName:@"ContactsTableViewCell" bundle:nil] forCellReuseIdentifier:@"ContactsTableViewCell"];
    
}

-(void)loadFriends{
    [FriendsManger getFriends:^(NSArray<UserModel *> *firends) {
        self.indexArray = [BMChineseSort IndexWithArray:firends Key:@"name"];
        self.dataSource = [BMChineseSort sortObjectArray:firends Key:@"name"];
        if (self.indexArray.count > 0) {
            if ([self.indexArray[0] isEqualToString:@"#"]) {
                [self.indexArray removeObjectAtIndex:0];
                [self.indexArray addObject:@"#"];
                NSArray *array = [self.dataSource[0] mutableCopy];
                [self.dataSource removeObjectAtIndex:0];
                [self.dataSource addObject:array];
            }
        }
        [self addIndexView];
    }];
}

-(void)addIndexView{
    CGFloat indexHeight = self.indexArray.count * 20 + (self.indexArray.count-1) * 3;
    CGFloat y = (ScreenHeight - indexHeight)/2;
    self.indexView = [[ContactsIndexView alloc]initWithFrame:CGRectMake(ScreenWidth - 30, y,20, indexHeight) withNames:self.indexArray];
    self.indexView.delegate = self;
    [self.view insertSubview:self.indexView aboveSubview:self.tableView];
    [self reloadData];
}
#pragma mark - UISearchResultsUpdating
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *inputStr = searchController.searchBar.text ;
    NSLog(@"%@",inputStr);
}
#pragma mark -- ContactsIndexViewDelegate

-(void)contactsIndexViewDidSelected:(NSInteger)index{
    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:index];
    [self.tableView scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

#pragma mark -- UITableViewDataSource、UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [self.indexArray count];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[self.dataSource objectAtIndex:section] count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContactsTableViewCell" forIndexPath:indexPath];
    cell.model = self.dataSource[indexPath.section][indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UserModel *friend = self.dataSource[indexPath.section][indexPath.row];
    ChatViewController *chat = [ChatViewController new];
    chat.friends = friend;
    [self pushViewController:chat];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(15, 0,50, 20)];
    label.textColor = [UIColor darkGrayColor];
    label.font = Font12;
    label.text = self.indexArray[section];
    [view addSubview:label];
    return view;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20.0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.000001;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60.0;
}



@end
