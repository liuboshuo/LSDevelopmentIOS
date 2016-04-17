//
//  OrderedDictionaryOC.h
//  besttoneMobile
//
//  Created by 刘硕 on 15/9/4.
//  Copyright (c) 2015年 Besttone. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  <#Description#>
 */
@interface OrderedDictionaryOC : NSObject


-(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

@property(nonatomic , strong)NSMutableArray *keysArr;

@property(nonatomic , strong)NSMutableDictionary *valuesDictionary;

// 初始化方法 创建有序字典  根据Selector（必须是objects类型的属性名称）排序
-(instancetype)initWithKeys:(NSArray *)objects sel:(SEL)selector;

/**
 *  获取index的value
 *
 *  @param index 索引
 *
 *  @return 返回value
 */
-(NSArray *)valueWithIndex:(NSInteger)index;
/**
 *  插入value
 *
 *  @param value NSArray
 *  @param key   key
 *  @param index 索引
 */
-(void)insertWithValue:(id)value key:(id)key index:(int)index;

/**
 *  移除下标index的所有值
 *
 *  @param index 无
 */
-(void)removeWithIndex:(int)index;

/**
 *  插入单个数值即 valuesDictionary的value数组的单个对象
 *
 */
-(void)inserValue:(id)value;


@end
