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

@property(nonatomic , strong)NSMutableArray *keysArr;

@property(nonatomic , strong)NSMutableDictionary *valuesDictionary;

// 初始化方法 创建有序字典  根据Selector（必须是objects类型的属性名称）排序
-(instancetype)initWithKeys:(NSArray *)objects sel:(SEL)selector;

/**
 *  获取index的value
 *
 *  @param index <#index description#>
 *
 *  @return <#return value description#>
 */
-(NSArray *)valueWithIndex:(NSInteger)index;\
/**
 *  插入value
 *
 *  @param value <#value description#>
 *  @param key   <#key description#>
 *  @param index <#index description#>
 */
-(void)insertWithValue:(id)value key:(id)key index:(int)index;

/**
 *  移除index的值
 *
 *  @param index <#index description#>
 */
-(void)removeWithIndex:(int)index;


@end
