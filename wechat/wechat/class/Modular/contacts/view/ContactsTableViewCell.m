//
//  ContactsTableViewCell.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ContactsTableViewCell.h"
@interface ContactsTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *explainsLabel;

@end
@implementation ContactsTableViewCell

-(void)setModel:(UserModel *)model{
    _model = model;
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar] placeholderImage:[UIImage imageNamed:@"brandDefaultHeadFrame"]];
    self.nameLabel.text = model.name;
    self.explainsLabel.text = model.explains;
}


@end
