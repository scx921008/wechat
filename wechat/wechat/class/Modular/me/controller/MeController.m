//
//  MeController.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "MeController.h"
#import "MeModel.h"
#import "MeInfoTableCell.h"
#import "MeTableViewCell.h"
#import "UserModel.h"
@interface MeController ()
@property (nonatomic,strong) UserModel *user;
@end

@implementation MeController
- (instancetype)initWithStyle:(UITableViewStyle)style {
    return [super initWithStyle:UITableViewStyleGrouped];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 10)];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeInfoTableCell" bundle:nil] forCellReuseIdentifier:@"MeInfoTableCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"MeTableViewCell" bundle:nil] forCellReuseIdentifier:@"MeTableViewCell"];
    [self initData];
}

-(void)initData{
    self.user = [UserModel getUserInfo];
    [self.dataSource addObjectsFromArray:[MeModel loadData]];
    [AccountModel getUserInfo:^(UserModel *user, NSString *msg, NSError *error) {
        if (!error) {
            if (!msg) {
                self.user = user;
                [self.tableView reloadData];
            }
        }
    }];
    
}

#pragma mark -- UITableViewDataSource、UITableViewDelegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.dataSource.count+1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return [self.dataSource[section - 1] count];
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        MeInfoTableCell *infoCell = [tableView dequeueReusableCellWithIdentifier:@"MeInfoTableCell" forIndexPath:indexPath];
        infoCell.user = self.user;
        return infoCell;
    }else{
        MeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MeTableViewCell" forIndexPath:indexPath];
        NSArray *items = self.dataSource[indexPath.section - 1];
        cell.model = items[indexPath.row];
        return cell;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 80.0;
    }else{
        return 44.0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (@available(iOS 11.0, *)) {
        return 0.0001;
    }
    if (section == 0) {
        return 5;
    }else{
        return 15.0;
    }
    
}

@end
