//
//  RefreshView.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/21.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "RefreshView.h"
@interface RefreshView(){
//    Boolean _isRefresh;
    CGFloat _angle;
}

@property (nonatomic,strong) UIImageView *imageView;

@end

@implementation RefreshView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        _angle = 10;
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.imageView.image = [UIImage imageNamed:@"AlbumReflashIcon"];
    [self addSubview:self.imageView];
}

-(void)setRotation:(CGFloat)rotation{
    if (!_isRefresh) {
        self.imageView.transform = CGAffineTransformMakeRotation(-M_PI/180*rotation*5);
    }
}

-(void)startRefresh{
    
    if (!_isRefresh) {
        _isRefresh = YES;
        [self startAnimation];
    }
    
}
-(void)startAnimation{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.02];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(endAnimation)];
    self.imageView.transform = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    [UIView commitAnimations];
}
-(void)endAnimation{
    _angle += 10;
    if (_isRefresh) {
        [self startAnimation];
    }
}
-(void)endRefresh{
    _isRefresh = NO;
}


@end
