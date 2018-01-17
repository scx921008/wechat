//
//  FriendsCircleCell.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/26.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FriendsCircleCell.h"
#import "PositionView.h"
@interface FriendsCircleCell()
@property (nonatomic,strong) UIImageView *avatarImage;
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *contentLabel;
@property (nonatomic,strong) UILabel *creteTimeLabel;
@property (nonatomic,strong) UILabel *locationLabel;
@property (nonatomic,strong) UIButton *operateMore;
@property (nonatomic,strong) PositionView *postionView;
@property (nonatomic) NSLayoutConstraint *postionConstraint;

@end
@implementation FriendsCircleCell
+(FriendsCircleCell *)cellWithTableView:(UITableView *)tableView withIdentifier:(NSString *)indentifier{
    FriendsCircleCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    if (!cell) {
        cell = [[FriendsCircleCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    return cell;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    self.avatarImage = [UIImageView new];
    self.avatarImage.backgroundColor = GroupTableViewColor;
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFit;
    self.avatarImage.clipsToBounds = YES;
    [self.contentView addSubview:self.avatarImage];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.textColor = HexRGB(0x586C94);
    self.nameLabel.font = Font14;
    [self.contentView addSubview:self.nameLabel];
    
    self.contentLabel = [UILabel new];
    self.contentLabel.textColor = HexRGB(0x222222);
    self.contentLabel.numberOfLines = 0;
    self.contentLabel.font = Font14;
    [self.contentView addSubview:self.contentLabel];
    
    self.creteTimeLabel = [UILabel new];
    self.creteTimeLabel.textColor = HexRGB(0x999999);
    self.creteTimeLabel.font = Font12;
    [self.contentView addSubview:self.creteTimeLabel];
    
    self.locationLabel = [UILabel new];
    self.locationLabel.textColor = HexRGB(0x999999);
    self.locationLabel.font = Font12;
    [self.contentView addSubview:self.locationLabel];
    
    self.operateMore = [UIButton new];
    [self.operateMore setImage:[UIImage imageNamed:@"AlbumOperateMore"] forState:UIControlStateNormal];
    [self.operateMore addTarget:self action:@selector(showOperate) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.operateMore];
    
    [self.operateMore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
    
    self.postionView = [PositionView positionView];
    [self.contentView addSubview:self.postionView];
    
    self.postionConstraint = [NSLayoutConstraint constraintWithItem:self.postionView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:0];
    [self addConstraint:self.postionConstraint];

    [self.postionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.operateMore.mas_left).offset(0);
        make.centerY.equalTo(self.operateMore);
        make.height.mas_offset(@40);
    }];
    
   
    
    UIView *view = [UIView new];
    view.backgroundColor = GroupTableViewColor;
    [self.contentView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_offset(@1);
    }];
}

-(void)showOperate{
    if (self.postionConstraint.constant >= 180) {
         self.postionConstraint.constant = 0;
    }else{
        self.postionConstraint.constant = 180;
    }
    [self setNeedsUpdateConstraints];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
}

-(void)setModelF:(TopicModelF *)modelF{
    _modelF = modelF;
    TopicModel *model = modelF.model;
    UserModel *user = model.user;
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = modelF.nameF;
    
    [self.avatarImage sd_setImageWithURL:[NSURL URLWithString:user.avatar] placeholderImage:[UIImage imageWithColor:HexRGB(0xf9f9f9)]];
    self.avatarImage.frame = modelF.avatarF;
    
    self.contentLabel.text = model.content;
    self.contentLabel.frame = modelF.contnetF;
    
    
    if (model.location) {
        self.locationLabel.hidden = NO;
        self.locationLabel.text = model.location;
        self.locationLabel.frame = modelF.locationF;
    }
    self.creteTimeLabel.text = model.timeStr;
    self.creteTimeLabel.frame = modelF.timeF;
}



+(NSString *)cellIndentifier{
    return @"FriendsCircleCellIndentifier";
}

@end
