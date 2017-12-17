//
//  FIndController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FindController.h"
#import "FindTableViewCell.h"
#import "FindModel.h"
@interface FindController ()

@end

@implementation FindController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableHeaderView = nil;
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    [self.dataSource addObjectsFromArray:[FindModel loadData]];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"FindTableViewCell" bundle:nil] forCellReuseIdentifier:@"FindTableViewCell"];
}
#pragma mark -- UITableViewDataSource、UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.dataSource[section] count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FindTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FindTableViewCell" forIndexPath:indexPath];
    NSArray *items = self.dataSource[indexPath.section];
    cell.model = items[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
   return 0.0001;
}


@end
