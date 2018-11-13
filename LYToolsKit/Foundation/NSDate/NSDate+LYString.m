//
//  NSDate+LYString.m
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-12.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import "NSDate+LYString.h"

@implementation NSDate (LYString)

- (NSDate *)ly_dateWithYMD {
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd";
    NSString *selfStr = [fmt stringFromDate:self];
    return [fmt dateFromString:selfStr];
}

- (NSDateComponents *)ly_deltaWithNow {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    return [calendar components:unit fromDate:self toDate:[NSDate date] options:0];
}

- (NSDateFormatter *)ly_dateFormater {
    NSString *formatKey = @"yyyy-MM-dd HH:mm:ss:SSS";
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc] init];
    dateformatter.dateFormat = formatKey;
    return dateformatter;
}

- (NSString *)ly_currentTimeString {
    NSString * newTimeStr = [self.ly_dateFormater stringFromDate:self];
    return newTimeStr;
}

@end


@implementation NSDate (LYJudge)

- (BOOL)ly_isToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitDay | NSCalendarUnitMonth |  NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    return
    (selfCmps.year == nowCmps.year) &&
    (selfCmps.month == nowCmps.month) &&
    (selfCmps.day == nowCmps.day);
}

- (BOOL)ly_isYesterday {
    NSDate *nowDate = [[NSDate date] ly_dateWithYMD];
    NSDate *selfDate = [self ly_dateWithYMD];
    
    // 获得nowDate和selfDate的差距
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *cmps = [calendar components:NSCalendarUnitDay fromDate:selfDate toDate:nowDate options:0];
    return cmps.day == 1;
}

- (BOOL)ly_isThisYear {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    int unit = NSCalendarUnitYear;
    
    // 1.获得当前时间的年月日
    NSDateComponents *nowCmps = [calendar components:unit fromDate:[NSDate date]];
    
    // 2.获得self的年月日
    NSDateComponents *selfCmps = [calendar components:unit fromDate:self];
    
    return nowCmps.year == selfCmps.year;
}

@end
