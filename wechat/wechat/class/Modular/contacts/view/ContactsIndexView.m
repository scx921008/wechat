//
//  ContactsIndexView.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ContactsIndexView.h"
@interface ContactsIndexView()
@property (nonatomic,strong) NSArray *names;
@end
@implementation ContactsIndexView

-(instancetype)initWithFrame:(CGRect)frame withNames:(NSArray *)names{
    if (self = [super initWithFrame:frame]) {
        self.names = names;
        [self initSubView];
    }
    return self;
}
-(void)initSubView{
    for (int i=0; i<self.names.count; i++) {
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, i*20+i*3, 20, 20)];
        button.titleLabel.font = Font14;
        [button setTitle:self.names[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(didSelectedName:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:i];
        [button setLayerWithRadius:10 color:ClearColor width:0];
        [self addSubview:button];
    }
}
-(void)didSelectedName:(UIButton *)button{
    NSArray *subViews = self.subviews;
    for (UIButton *btn in subViews) {
        btn.backgroundColor = ClearColor;
        [btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.backgroundColor = mainColor;
    if ([self.delegate respondsToSelector:@selector(contactsIndexViewDidSelected:)]) {
        [self.delegate contactsIndexViewDidSelected:button.tag];
    }
}



@end
