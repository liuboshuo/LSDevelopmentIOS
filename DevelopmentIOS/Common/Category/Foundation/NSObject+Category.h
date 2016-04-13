//
//  NSObject+Category.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/29.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Category)<NSCoding>

/**
 *  对象的名称
 *
 *  @return <#return value description#>
 */
+ (nullable NSString *)className;

/**
 *  对象的名称
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)className;

/**
 *  KVO 为对象添加观察对象
 *
 *  @param keyPath 观察的键值对
 *  @param block   执行的Block
 */
-(void)addObserverBlockForKeyPath:(nullable NSString *)keyPath block:(void (^) (id _Nonnull obj , _Nullable id oldValue , _Nullable id newValue))block;
/**
 *  移除KVO
 *
 *  @param keyPath 观察的键值对
 */
- (void)removeObserverBlocksForKeyPath:(nullable NSString*)keyPath;

/**
 *  移除所有的KVO
 */
- (void)removeObserverBlocks;


@end
