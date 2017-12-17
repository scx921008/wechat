//
//  NSDate+Extension.m
//  CRM
//
//  Created by 桑赐相 on 2017/12/16.
//  Copyright © 2017年 teeking_scx. All rights reserved.
//

#import "NSDate+Extension.h"

@implementation NSDate (Extension)


/** 获取当天是周几 周数(1-7  ->  日-六)*/
- (NSInteger)getNumberInWeek{
    NSUInteger num =[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:self];
    return num;
}

/**当前时间月份第一天*/
- (NSDate *)getFirstDayOfMonth{
    NSCalendar *myCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [myCalendar components:NSCalendarUnitMonth | NSCalendarUnitYear fromDate:self];
    NSDate* rt = [myCalendar dateFromComponents:components];
    return rt;
}

/** 时间格式化 */
- (NSString *)dateFormat:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:format];
    return [formatter stringFromDate:self];
}

/** 获取上个月的时间 */
- (NSDate*)getPreviousMonth{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    
    NSInteger year  = comps.year;
    NSInteger month = comps.month;
    NSInteger day   = comps.day;
    NSDate* rt = nil;
    if (day <= 28 || month == 1) {
        comps.month = month-1;
        rt = [cal dateFromComponents:comps];
    } else {
        NSString* ss = [NSString stringWithFormat:@"%ld-%ld-3", (long)year, month-1];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* the_month = [formatter dateFromString:ss];
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:the_month];
        NSInteger day_in_month = rng.length;
        NSString* datestring = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, month-1, MIN(day, day_in_month)];
        rt = [formatter dateFromString:datestring];
    }
    return rt;
}

/** 获取下一个月的时间 */
- (NSDate*)getNextMonth{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay fromDate:self];
    NSInteger year  = comps.year;
    NSInteger month = comps.month;
    NSInteger day   = comps.day;
    NSDate* rt = nil;
    if (day <= 28 || month == 12) {
        comps.month = month+1;
        rt = [cal dateFromComponents:comps];
    } else {
        NSString* ss = [NSString stringWithFormat:@"%ld-%ld-3", (long)year, month+1];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate* the_month = [formatter dateFromString:ss];
        NSRange rng = [cal rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:the_month];
        NSInteger day_in_month = rng.length;
        NSString* datestring = [NSString stringWithFormat:@"%ld-%ld-%ld", (long)year, month+1, MIN(day, day_in_month)];
        rt = [formatter dateFromString:datestring];
    }
    return rt;
}

/**获取本月第一天是星期几 */
- (NSInteger)getCurrentFirstDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];//1.mon
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:self];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday;
}

/**获取本月总天数*/
- (NSInteger)getCurrentMonthOfDay{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    return totaldaysInMonth.length;
}

/**获取当前月有多少行 (一行有7天)*/
- (NSInteger)getRows{
    NSDate *firstday;
    [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitMonth startDate:&firstday interval:NULL forDate:self];
    NSUInteger zhouji =[[NSCalendar currentCalendar] ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstday];
    NSRange daysOfMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self];
    //该月的行数
    NSInteger shenyu = daysOfMonth.length - (8 - zhouji);
    NSInteger hangshu;
    hangshu = shenyu % 7 > 0 ? shenyu/7 + 2 : shenyu/7 + 1;
    return hangshu;
}

/**判断两个月份是不是一样的*/
- (BOOL)checkSameMonth:(NSDate*)date{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents* m1 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:self];
    NSDateComponents* m2 = [cal components:NSCalendarUnitYear|NSCalendarUnitMonth fromDate:date];
    BOOL rt = NO;
    if ((m1.year == m2.year) && (m1.month == m2.month)){
        rt = YES;
    }
    return rt;
}

/**判断两天是不是同一天*/
- (BOOL)checkSameDate:(NSDate *)date{
    NSDateFormatter *formate = [[NSDateFormatter alloc]init];
    [formate setDateFormat:@"yyyy-MM-dd"];
    NSString *currtentDay = [formate stringFromDate:self];
    NSString *otherDay = [formate stringFromDate:date];
    return [currtentDay isEqualToString:otherDay];
}


/**获取当天零点时间*/
- (NSDate *)getStartDate{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:self];
    return [calendar dateFromComponents:components];
}

/** 判断某个时间是否为今年 */
- (BOOL)isThisYear{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateCmps = [calendar components:NSCalendarUnitYear fromDate:self];
    NSDateComponents *nowCmps = [calendar components:NSCalendarUnitYear fromDate:[NSDate date]];
    return dateCmps.year == nowCmps.year;
}

/** 判断某个时间是否为昨天 */
- (BOOL)isYesterday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    NSDate *date = [fmt dateFromString:dateStr];
    now = [fmt dateFromString:nowStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *cmps = [calendar components:unit fromDate:date toDate:now options:0];
    return cmps.year == 0 && cmps.month == 0 && cmps.day == 1;
}

/**判断某个时间是否为今天*/
- (BOOL)isToday{
    NSDate *now = [NSDate date];
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *dateStr = [fmt stringFromDate:self];
    NSString *nowStr = [fmt stringFromDate:now];
    return [dateStr isEqualToString:nowStr];
}
@end
