//
//  NSNumber+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Category)

/**
 *  把字符串转化为NSNumber （YES,NO,TRUE,FALSE,nil,null,<null> 为nil）,其他不符合数字的也返回nil，否则数字对象
 *
 *  @param string 字符串
 *
 *  @return <#return value description#>
 */
+ (nullable NSNumber *)numberWithString:(nullable NSString *)string;
@end
