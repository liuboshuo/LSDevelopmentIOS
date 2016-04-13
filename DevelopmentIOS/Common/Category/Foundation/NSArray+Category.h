//
//  NSArray+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Category)
- (nullable NSString *)jsonStringEncoded;
@end
@interface NSMutableArray (Category)

/**
 *  移除第一个
 */
- (void)removeFirstObject;
/**
 *  移除最后
 */
- (void)removeLastObject;

/**
 *  移除第一个返回
 *
 *  @return <#return value description#>
 */
- (nullable id)popFirstObject;

/**
 *  移除最后一个返回
 *
 *  @return <#return value description#>
 */
- (nullable id)popLastObject;

/**
 *  在最后追加一个数组
 *
 *  @param objects <#objects description#>
 */
- (void)appendObjects:(nullable NSArray *)objects;

/**
 *  在最前面追加
 *
 *  @param objects <#objects description#>
 */
- (void)prependObjects:(nullable NSArray *)objects;

/**
 *  在第几个索引追加数组
 *
 *  @param objects 追加数组
 *  @param index   索引
 */
- (void)insertObjects:(nullable NSArray *)objects atIndex:(NSUInteger)index;

/**
 *  反转
 */
- (void)reverse;

/**
 *  random
 */
- (void)shuffle;
@end