//
//  NSKeyedUnarchiver+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSKeyedUnarchiver (Category)


/**
 *  对数据归档
 *
 *  @param data      data
 *  @param exception 异常
 *
 *  @return <#return value description#>
 */
+ (nullable id)unarchiveObjectWithData:(nullable NSData *)data
                             exception:(NSException *_Nullable *_Nullable)exception;


/**
 *  对文件操作->反归档
 *
 *  @param path      路径
 *  @param exception <#exception description#>
 *
 *  @return <#return value description#>
 */
+ (nullable id)unarchiveObjectWithFile:(nullable NSString *)path
                             exception:(NSException *_Nullable *_Nullable)exception;

@end
