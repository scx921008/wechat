//
//  AppDelegate.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//  这里是什么情况

#import "AppDelegate.h"
#import "ViewController.h"
#import "TabBarController.h"
#import "LoginViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface AppDelegate ()<CLLocationManagerDelegate,EMClientDelegate,EMChatManagerDelegate,EMGroupManagerDelegate>
@property (nonatomic, strong) CLLocationManager * locationManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    [self getSystemInfo];
    [self startLocation];
    [self initHyphenateLite];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    EMOptions *options = [EMClient sharedClient].options;
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *account = [userDefaults objectForKey:@"account"];
    NSString *pasword = [userDefaults objectForKey:@"password"];
    if (options.isAutoLogin) {
        self.window.rootViewController = [TabBarController new];
        [UserModel login:account withPassword:pasword callback:nil];
    }else{
        self.window.rootViewController = [LoginViewController new];
    }
    [self.window makeKeyAndVisible];
    return YES;
}

// APP进入后台
- (void)applicationDidEnterBackground:(UIApplication *)application{
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

// APP将要从后台返回
- (void)applicationWillEnterForeground:(UIApplication *)application{
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

#pragma mark - init
-(void)initHyphenateLite{
    EMOptions *options = [EMOptions optionsWithAppkey:@"1121171031178025#wechat"];
    [[EMClient sharedClient] initializeSDKWithOptions:options];
    [[EMClient sharedClient] addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].chatManager addDelegate:self delegateQueue:nil];
    [[EMClient sharedClient].groupManager addDelegate:self delegateQueue:nil];
}
- (void)autoLoginDidCompleteWithError:(EMError *)aError{
    if (aError) {
        NSLog(@"登录异常 == %@",aError.errorDescription);
        [self loginAgain:@"登录异常,请重新登入"];
    }else{
        NSLog(@"自动登入成功");
    }
}
- (void)connectionStateDidChange:(EMConnectionState)aConnectionState{
    [[NSNotificationCenter defaultCenter] postNotificationName:NotificationNameNetChange object:self userInfo:@{@"state":@(aConnectionState)}];
}
- (void)userAccountDidLoginFromOtherDevice{
    
    [self loginAgain:@"您的账号已在其它设备上登录，请重新登录!"];
}
- (void)userAccountDidRemoveFromServer{
    [self loginAgain:@"该账号已被管理员删除了"];
}
- (void)userDidForbidByServer{
    [self loginAgain:@"该账号已被管理员禁用"];
}
-(void)loginAgain:(NSString *)message{
    UIAlertController *alertCtrl = [UIAlertController alertControllerWithTitle:@"提示!" message:message preferredStyle:UIAlertControllerStyleAlert];
    WeakSelf(weakSelf);
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        weakSelf.window.rootViewController = [LoginViewController new];
    }];
    [alertCtrl addAction:action];
    UIViewController *presentVC = [[UIApplication sharedApplication] keyWindow].rootViewController;
    while (presentVC.presentedViewController) {
        presentVC = presentVC.presentedViewController;
    }
    [presentVC presentViewController:alertCtrl animated:YES completion:nil];
}
-(void)getSystemInfo{
    
    UIDevice *device = [UIDevice currentDevice];
    self.system = device.systemName;
    
}
-(void)startLocation{
    if([CLLocationManager locationServicesEnabled]){
        // 启动位置更新
        // 开启位置更新需要与服务器进行轮询所以会比较耗电，在不需要时用stopUpdatingLocation方法关闭;
        self.locationManager = [[CLLocationManager alloc] init];
        //设置定位的精度
        [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locationManager.distanceFilter = 10.0f;
        _locationManager.delegate = self;
        if ([[[UIDevice currentDevice] systemVersion] floatValue] > 8.0){
            [_locationManager requestAlwaysAuthorization];
            [_locationManager requestWhenInUseAuthorization];
        }
        //开始实时定位
        [_locationManager startUpdatingLocation];
    }else {
        NSLog(@"请开启定位功能！");
    }
}


#pragma mark - CLLocationManagerDelegate
//代理,定位代理经纬度回调
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    CLLocation * newLoaction = locations[0];
    CLLocationCoordinate2D coordinate = newLoaction.coordinate;
    //    NSLog(@"旧的经度：%f，旧的维度：%f",oCoordinate.longitude,oCoordinate.latitude);
    self.loc = [NSString stringWithFormat:@"%f",coordinate.longitude];
    self.lat = [NSString stringWithFormat:@"%f",coordinate.latitude];;
    [self.locationManager stopUpdatingLocation];
    //创建地理位置解码编码器对象
    CLGeocoder * geoCoder = [[CLGeocoder alloc] init];
    [geoCoder reverseGeocodeLocation:newLoaction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        for (CLPlacemark * place in placemarks) {
            self.location = place.locality;
            NSLog(@"%@",self.location);
        }
    }];
}
@end
