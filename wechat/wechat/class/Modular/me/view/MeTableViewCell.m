//
//  MeTableViewCell.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "MeTableViewCell.h"
@interface MeTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *icon;
@property (weak, nonatomic) IBOutlet UILabel *name;

@end
@implementation MeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(MeModel *)model{
    _model = model;
    self.icon.image = [UIImage imageNamed:model.icon];
    self.name.text = model.name;
}

@end
