//
//  EdgeUILabel.m
//  meinvtu
//
//  Created by apple on 2017/2/26.
//  Copyright © 2017年 sangcixiang. All rights reserved.
//

#import "EdgeUILabel.h"
@interface EdgeUILabel()

@end
@implementation EdgeUILabel

-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
    
        self.edgeInsets = UIEdgeInsetsMake(2.5,10, 2.5, 10);
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        self.edgeInsets = UIEdgeInsetsMake(2.5, 5, 2.5, 5);
    }
    return self;
}
- (void)awakeFromNib{
    [super awakeFromNib];
    self.edgeInsets = UIEdgeInsetsMake(2.5, 5, 2.5, 5);
}

-(void)setEdgeInsets:(UIEdgeInsets)edgeInsets{
    _edgeInsets = edgeInsets;
    [self layoutIfNeeded];
}

-(CGRect)textRectForBounds:(CGRect)bounds limitedToNumberOfLines:(NSInteger)numberOfLines{
    CGRect rect = [super textRectForBounds:UIEdgeInsetsInsetRect(bounds,
                                                                 self.edgeInsets) limitedToNumberOfLines:numberOfLines];
    //根据edgeInsets，修改绘制文字的bounds
    rect.origin.x -= self.edgeInsets.left;
    rect.origin.y -= self.edgeInsets.top;
    rect.size.width += self.edgeInsets.left + self.edgeInsets.right;
    rect.size.height += self.edgeInsets.top + self.edgeInsets.bottom;
    return rect;
}
//绘制文字
- (void)drawTextInRect:(CGRect)rect{
    //令绘制区域为原始区域，增加的内边距区域不绘制
    [super drawTextInRect:UIEdgeInsetsInsetRect(rect, self.edgeInsets)];
}

@end
