//
//  TQLoadingHUD.m
//  New_APP
//
//  Created by 桑赐相 on 2017/12/2.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "TQLoadingHUD.h"

@interface TQLoadingHUD()

@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UILabel *textLabel;
@property (nonatomic,strong) NSTimer *timer;

@property (nonatomic,copy) void(^completion)(Boolean finish);

@end
@implementation TQLoadingHUD


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self initSubView];
    }
    return self;
}

-(void)initSubView{
    
    
    self.contentView = [[UIView alloc]init];
    self.contentView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.7];
    [self.contentView setLayerWithRadius:5 color:ClearColor width:0.0];
    [self addSubview:self.contentView];
    
    self.loadingView = [[ALLoadingView alloc]init];
    [self.contentView addSubview:self.loadingView];
    
    self.textLabel = [UILabel new];
    self.textLabel.textColor = WhiteColor;
    self.textLabel.font = Font14;
    self.textLabel.text = @"";
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.textLabel];
    
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.height.mas_offset(@120);
    }];
    
    [self.loadingView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.contentView);
        make.top.equalTo(self.contentView).offset(20);
        make.width.height.mas_offset(@40);
    }];
    
    [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.loadingView);
        make.top.equalTo(self.loadingView.mas_bottom).offset(20);
    }];
    
    
    [self layoutIfNeeded];
    [self.loadingView start];
}

-(void)setMessage:(NSString *)message{
    _message = message;
    self.textLabel.text = message;
}



+(void)showLoadingHud:(NSString *)message{
    TQLoadingHUD *loadingHud = [[TQLoadingHUD alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    loadingHud.message = message;
    UIWindow *window = KeyWindow;
    [window addSubview:loadingHud];
}

+(void)showErrorHud:(NSString *)message{
    [TQLoadingHUD hideHudMessage:message type:ALLoadingViewResultTypeError completion:nil];
}
+(void)showSuccessHud:(NSString *)message{
    [TQLoadingHUD hideHudMessage:message type:ALLoadingViewResultTypeSuccess completion:nil];
}
+(void)showWarningHud:(NSString *)message{
    [TQLoadingHUD hideHudMessage:message type:ALLoadingViewResultTypeExclamationMark completion:nil];
}

+(void)showSuccessHud:(NSString *)message completion:(void (^)(Boolean))completion{
    [TQLoadingHUD hideHudMessage:message type:ALLoadingViewResultTypeSuccess completion:completion];
}

+(void)hideHudMessage:(NSString *)message type:(ALLoadingViewResultType)type completion:(void (^)(Boolean))completion{
    UIWindow *window = KeyWindow;
    NSArray *views = window.subviews;
    Class class = NSClassFromString(@"TQLoadingHUD");
    TQLoadingHUD *loading = nil;
    for (UIView *view in views) {
        if([view isKindOfClass:class]){
            loading = (TQLoadingHUD *)view;
            loading.message = message;
            [loading.loadingView endAnimationWithResult:type];
        }
    }
    loading.completion = completion;
    if(loading == nil) return;
    [loading hideView];
}
-(void)hideView{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(next) userInfo:nil repeats:NO];
    //解决拖动其他UIScrollView时 定时器不再滚动 看不懂
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
+(void)hideView{
    UIWindow *window = KeyWindow;
    NSArray *views = window.subviews;
    Class class = NSClassFromString(@"TQLoadingHUD");
    TQLoadingHUD *loading = nil;
    for (UIView *view in views) {
        if([view isKindOfClass:class]){
            loading = (TQLoadingHUD *)view;
            [UIView animateWithDuration:0.01 animations:^{
                loading.contentView.alpha = 0;
            } completion:^(BOOL finished) {
                if (finished) {
                    [loading removeFromSuperview];
                    if (loading.timer) {
                        [loading.timer invalidate];
                    }
                    loading.timer = nil;
                }
            }];
            return;
        }
    }
}

-(void)next{
    [UIView animateWithDuration:0.5 animations:^{
        self.contentView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if(self.completion){
                self.completion(finished);
            }
            [self removeFromSuperview];
            [self.timer invalidate];
            self.timer = nil;
        }
    }];
}



-(void)dealloc{
    NSLog(@"%s",__func__);
}


@end

