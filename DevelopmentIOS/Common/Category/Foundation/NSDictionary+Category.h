//
//  NSDictionary+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Category)


/**
 *  plist的Data转成字典
 *
 *  @return <#return value description#>
 */
- (nullable NSData *)plistData;
/**
 *  对字典的可以排序
 *
 *  @return <#return value description#>
 */
- (nullable NSArray *)allKeysSorted;

/**
 *  对字典value排序
 *
 *  @return <#return value description#>
 */
- (nullable NSArray *)allValuesSortedByKeys;

/**
 *  包含key
 *
 *  @param key <#key description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)containsObjectForKey:(nullable id)key;

/**
 *  转换字典字符串
 *
 *  @return <#return value description#>
 */
- (nullable NSString *)jsonStringEncoded;

- (nullable NSString *)jsonPrettyStringEncoded;

@end


@interface NSMutableDictionary (Category)

/**
 *  移除key的值返回溢出
 *
 *  @param aKey <#aKey description#>
 *
 *  @return <#return value description#>
 */
- (nullable id)popObjectForKey:(nullable id)aKey;

/**
 *  移除多个keys
 *
 *  @param keys <#keys description#>
 *
 *  @return <#return value description#>
 */
- (nullable NSDictionary *)popEntriesForKeys:(nullable NSArray *)keys;


@end

