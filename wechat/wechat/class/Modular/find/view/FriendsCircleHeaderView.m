//
//  FriendsCircleHeaderView.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/20.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FriendsCircleHeaderView.h"
@interface FriendsCircleHeaderView()
@property (nonatomic,strong) UIImageView *backgroundView;
@property (nonatomic,strong) UIImageView *avatarImage;
@property (nonatomic,strong) UILabel *nameLabel;
@end
@implementation FriendsCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
        [self initSubViewFrame];
    }
    return self;
}

-(void)initSubView{
    
    self.backgroundView = [UIImageView new];
    self.backgroundView.contentMode = UIViewContentModeScaleAspectFit;
    self.backgroundView.backgroundColor = [UIColor grayColor];
    [self addSubview:self.backgroundView];
    
    self.nameLabel = [UILabel new];
    self.nameLabel.font = Font17;
    self.nameLabel.textColor = WhiteColor;
    self.nameLabel.text = @"名字";
    [self addSubview:self.nameLabel];
    
    self.avatarImage = [UIImageView new];
    self.avatarImage.contentMode = UIViewContentModeScaleAspectFit;
    self.avatarImage.backgroundColor = WhiteColor;
    [self addSubview:self.avatarImage];
    
}

-(void)initSubViewFrame{
    
    [self.backgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).offset(-20);
    }];
    
    [self.avatarImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self);
        make.width.height.mas_offset(@60);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.backgroundView.mas_bottom).offset(-10);
        make.right.equalTo(self.avatarImage.mas_left).offset(-10);
    }];
    
    
}



@end
