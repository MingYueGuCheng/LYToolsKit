//
//  NSDate+LYString.h
//  茗玥古城
//
//  Created by 似水灵修 on 13-11-12.
//  Copyright (c) 2013年 MingYueGuCheng. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (LYString)

/** 返回一个只有年月日的时间 */
- (NSDate *)ly_dateWithYMD;
/** 获得与当前时间的差距 */
- (NSDateComponents *)ly_deltaWithNow;
/** 时间转换格式 */
- (NSDateFormatter *)ly_dateFormater;
/** 获取当前时间戳字符串 */
- (NSString *)ly_currentTimeString;

@end

@interface NSDate (LYJudge)

/** 是否为今天 */
- (BOOL)ly_isToday;
/** 是否为昨天 */
- (BOOL)ly_isYesterday;
/** 是否为今年 */
- (BOOL)ly_isThisYear;

@end

NS_ASSUME_NONNULL_END
