//
//  NSDate+Extension.h
//  CRM
//
//  Created by 桑赐相 on 2017/12/16.
//  Copyright © 2017年 teeking_scx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)


/** 获取当天是周几 周数(1-7  ->  日-六)*/
- (NSInteger)getNumberInWeek;

/**当前时间月份第一天*/
- (NSDate *)getFirstDayOfMonth;

/** 时间格式化 */
- (NSString *)dateFormat:(NSString *)format;

/** 获取上个月的时间 */
- (NSDate*)getPreviousMonth;

/** 获取下一个月的时间 */
- (NSDate*)getNextMonth;

/**获取本月第一天是星期几 */
- (NSInteger)getCurrentFirstDay;

/**获取本月总天数*/
- (NSInteger)getCurrentMonthOfDay;

/**获取当前月有多少行 (一行有7天)*/
- (NSInteger)getRows;

/**判断两个月份是不是一样的*/
- (BOOL)checkSameMonth:(NSDate*)date;

/**判断两天是不是同一天*/
- (BOOL)checkSameDate:(NSDate *)date;

/**获取当天零点时间*/
- (NSDate *)getStartDate;

/** 判断某个时间是否为今年 */
- (BOOL)isThisYear;

/**判断某个时间是否为昨天*/
- (BOOL)isYesterday;

/** 判断某个时间是否为今天 */
- (BOOL)isToday;
@end
