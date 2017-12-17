//
//  BaseTableViewCell.m
//  CRM
//
//  Created by teeking_scx on 2017/12/7.
//  Copyright © 2017年 teeking_scx. All rights reserved.
//

#import "BaseTableViewCell.h"

@implementation BaseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
// 自绘分割线
- (void)drawRect:(CGRect)rect{
    //获取cell系统自带的分割线，获取分割线对象目的是为了保持自定义分割线frame和系统自带的分割线一样。如果不想一样，可以忽略。
    UIView *separatorView = [self valueForKey:@"_separatorView"];
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:232/255.0 green:232/255.0 blue:232/255.0 alpha:1].CGColor);
    //CGContextStrokeRect(context, CGRectMake(0, rect.size.height - 1, rect.size.width, 1));
    CGContextStrokeRect(context, separatorView.frame);
}
@end
