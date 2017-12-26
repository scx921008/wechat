//
//  MeInfoTableCell.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "MeInfoTableCell.h"
@interface MeInfoTableCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatar;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *account;

@end
@implementation MeInfoTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setUser:(UserModel *)user{
    _user = user;
    [self.avatar sd_setImageWithURL:[NSURL URLWithString:user.avatar]];
    self.name.text = user.name;
    self.account.text = [NSString stringWithFormat:@"账号:%@",[AccountModel sharedAccount].account];
}

@end
