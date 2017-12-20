//
//  BaseTableViewController.h
//  wechat
//
//  Created by 桑赐相 on 2017/12/18.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseTableViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *dataSource;
@property (nonatomic,assign) NSInteger page;

-(void)initSubView;

-(void)reloadData;

-(void)down_refreshData;

-(void)loadMoreData;


@end
