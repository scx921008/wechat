//
//  ChatTabBarView.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/18.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "ChatTabBarView.h"
@interface ChatTabBarView()
@property (weak, nonatomic) IBOutlet UIButton *voiceBtn;

@end
@implementation ChatTabBarView

+(instancetype)tabBarView{
    ChatTabBarView *view = [[[NSBundle mainBundle]loadNibNamed:@"ChatTabBarView" owner:self options:nil]lastObject];
    return view;
}

- (IBAction)voiceAction:(UIButton *)sender {
    
}
- (IBAction)emotionAction:(UIButton *)sender {
    
}
- (IBAction)typeSelectAction:(UIButton *)sender {
    
}


@end

