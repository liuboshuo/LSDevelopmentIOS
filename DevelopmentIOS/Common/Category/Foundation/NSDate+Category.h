//
//  NSDate+Category.h
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Category)

/**
 *  获取年份
 */
@property (nonatomic, readonly) NSInteger year;
/**
 *  获取月份
 */
@property (nonatomic, readonly) NSInteger month; /// (1~12)

/**
 *  获取日期
 */
@property (nonatomic, readonly) NSInteger day; /// (1~31)
/**
 *  获取在哪个小时
 */
@property (nonatomic, readonly) NSInteger hour; ///(0~23)
/**
 *  获取时间的分钟
 */
@property (nonatomic, readonly) NSInteger minute; ///(0~59)
/**
 *  获取秒数
 */
@property (nonatomic, readonly) NSInteger second; ///(0~59)
/**
 *  获取微妙数
 */
@property (nonatomic, readonly) NSInteger nanosecond; ///< Nanosecond component
/**
 *  获取周几
 */
@property (nonatomic, readonly) NSInteger weekday; ///(1~7)
@property (nonatomic, readonly) NSInteger weekdayOrdinal;
/**
 *  获取月份的几周
 */
@property (nonatomic, readonly) NSInteger weekOfMonth;
/**
 *  获取概念的哪周
 */
@property (nonatomic, readonly) NSInteger weekOfYear;
@property (nonatomic, readonly) NSInteger yearForWeekOfYear;
@property (nonatomic, readonly) NSInteger quarter;
/**
 *  是闰月
 */
@property (nonatomic, readonly) BOOL isLeapMonth;
/**
 *  是闰年
 */
@property (nonatomic, readonly) BOOL isLeapYear;
/**
 *  见天
 */
@property (nonatomic, readonly) BOOL isToday;
/**
 *  昨天
 */
@property (nonatomic, readonly) BOOL isYesterday;

/**
 *  增加几年时间
 *
 *  @param years <#years description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingYears:(NSInteger)years;
/**
 *  增加月份时间
 *
 *  @param months <#months description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingMonths:(NSInteger)months;

/**
 *  增加周时间
 *
 *  @param weeks <#weeks description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingWeeks:(NSInteger)weeks;
/**
 *  增加天数
 *
 *  @param days <#days description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingDays:(NSInteger)days;
/**
 *  增加小时的数量
 *
 *  @param hours <#hours description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingHours:(NSInteger)hours;
/**
 *  增加分钟的数量
 *
 *  @param minutes <#minutes description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingMinutes:(NSInteger)minutes;
/**
 *  增加秒数时间
 *
 *  @param seconds <#seconds description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDate *)dateByAddingSeconds:(NSInteger)seconds;
/**
 *  把当前日期转化成字符串
 *
 *  @param format 以这个格式
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)stringWithFormat:(nullable NSString *)format;
/**
 *  把当前日期转化成字符串
 *
 *  @param format   以这个格式
 *  @param timeZone 时区
 *  @param locale   本地化对象
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)stringWithFormat:(nullable NSString *)format
                               timeZone:(nullable NSTimeZone *)timeZone
                                 locale:(nullable NSLocale *)locale;

/**
 *  把当前日期转化成字符串以标准的地区
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)stringWithISOFormat;
/**
 *  把dateString转日期
 *
 *  @param dateString 符合日期格式的字符串
 *  @param format     日期格式
 *
 *  @return <#return value description#>
 */
+ (nullable NSDate *)dateWithString:(nullable NSString *)dateString format:(nullable NSString *)format;
/**
 *  把符合日期格式的字符串转日期
 *
 *  @param dateString 符合日期格式的字符串
 *  @param format     日期格式
 *  @param timeZone   时区
 *  @param locale     本地对象
 *
 *  @return <#return value description#>
 */
+ (nullable NSDate *)dateWithString:(nullable NSString *)dateString
                             format:(nullable NSString *)format
                           timeZone:(nullable NSTimeZone *)timeZone
                             locale:(nullable NSLocale *)locale;

/**
 *  把字符串以标准的格式转化成对象日期
 *
 *  @param dateString <#dateString description#>
 *
 *  @return <#return value description#>
 */
+ (nullable NSDate *)dateWithISOFormatString:(NSString *)dateString;
@end
