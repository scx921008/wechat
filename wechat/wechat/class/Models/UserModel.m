//
//  UserModel.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "UserModel.h"
#import "TabBarController.h"
#define userPath [PathDocument stringByAppendingPathComponent:@"user.archiver"]
@implementation UserModel

MJCodingImplementation

-(NSString *)name{
    return _name?_name:_account;
}

-(NSString *)explains{
    return _explains?_explains:@"好像还什么都没写...";
}
+(void)getAllFirends:(void (^)(NSArray<UserModel *> *))callback{
    
    UserModel *user = [UserModel getUserInfo];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[@"account"] = user.account;
    NSString *url = [NSString stringWithFormat:@"%@%@",domain,GETAllFIRENDSURL];
    [HTTPTools GET:url parameters:dict success:^(NSDictionary *success) {
        NSArray *array = [UserModel mj_objectArrayWithKeyValuesArray:success[@"data"]];
        [FriendsManger saveFriends:array];
        if (callback) {
            callback(array);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}



+(void)saveUserInfo:(UserModel *)personal{
    [NSKeyedArchiver archiveRootObject:personal toFile:userPath];
}

+(UserModel *)getUserInfo{
    UserModel *user =  [NSKeyedUnarchiver unarchiveObjectWithFile:userPath];
    if(!user){
        return nil;
    }
    return user;
}
@end
