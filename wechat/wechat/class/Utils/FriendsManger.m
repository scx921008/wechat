//
//  FriendsManger.m
//  wechat
//
//  Created by 桑赐相 on 2017/12/17.
//  Copyright © 2017年 桑赐相. All rights reserved.
//

#import "FriendsManger.h"
#import <FMDB.h>
static FMDatabaseQueue *_db;
@implementation FriendsManger
+(void)initialize{
    
    NSString *dataBasePath = [[CacheManager createDocumentPath] stringByAppendingPathComponent:@"friends.db"];
    NSLog(@"dataBasePath==%@",dataBasePath);
    _db = [FMDatabaseQueue databaseQueueWithPath:dataBasePath];
    [_db inDatabase:^(FMDatabase *db) {
        NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS friends (id integer PRIMARY KEY autoincrement,account varchar,name varchar default null,sex int default null,avatar varchar default null,explains varchar default null,phone varchar default null,email varchar default null,address varchar default null,login_time int default null)";
        if (![db executeUpdate:sqlStr]){
            NSLog(@"建表失败!");
        }
    }];
}

+(void)saveFriends:(NSArray *)users{
    [_db inDatabase:^(FMDatabase * _Nonnull db) {
        [db executeUpdateWithFormat:@"DELETE FROM friends"];
    }];
    for (UserModel *user in users) {
        [FriendsManger insterFriends:user];
    }
}

+(void)insterFriends:(UserModel *)user{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_db inDatabase:^(FMDatabase * _Nonnull db) {
            Boolean status = [db executeUpdateWithFormat:@"replace into friends(account,name,sex,avatar,explains,phone,email,address,login_time) VALUES (%@,%@,%ld,%@,%@,%@,%@,%@,%ld)",user.account,user.name,user.sex,user.avatar,user.explains,user.phone,user.email,user.address,user.login_time];
            if (!status) {
                NSLog(@"保存好友失败");
            }
        }];
    });
}

+(void)getFriends:(void (^)(NSArray<UserModel *> *))callback{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [_db inDatabase:^(FMDatabase * _Nonnull db) {
            NSString *sql = @"SELECT *FROM friends";
            FMResultSet *set = [db executeQuery:sql];
            NSMutableArray *array = [NSMutableArray array];
            while ([set next]) {
                [array addObject:[FriendsManger result:set]];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                callback(array);
            });
        }];
    });
}
+(UserModel *)result:(FMResultSet *)set{
    UserModel *firend = [UserModel new];
    firend.account = [set stringForColumn:@"account"];
    firend.name = [set stringForColumn:@"name"];
    firend.sex = [set intForColumn:@"sex"];
    firend.avatar = [set stringForColumn:@"avatar"];
    firend.explains = [set stringForColumn:@"explains"];
    firend.phone = [set stringForColumn:@"phone"];
    firend.email = [set stringForColumn:@"email"];
    firend.address = [set stringForColumn:@"address"];
    firend.login_time = [set stringForColumn:@"login_time"];
    return firend;
}

@end
