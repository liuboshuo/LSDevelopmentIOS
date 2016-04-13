//
//  LSDispatchQueuePool.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/6.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef LSDispatchQueuePool_h

#define LSDispatchQueuePool_h


NS_ASSUME_NONNULL_BEGIN



@interface LSDispatchQueuePool : NSObject

-(instancetype)init UNAVAILABLE_ATTRIBUTE;
+(instancetype)new UNAVAILABLE_ATTRIBUTE;

/**
 *  初始化
 *
 *  @param name       pool名称
 *  @param queueCount 数量
 *  @param qos        <#qos description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithName:(nullable NSString*)name queueCount:(NSUInteger)queueCount qos:(NSQualityOfService)qos;

/**
 *  pool的名称
 */
@property(nonatomic , nullable, readonly)NSString *name;


/**
 *  随机获取队列
 *
 *  @return <#return value description#>
 */
-(dispatch_queue_t)queue;


/**
 *  获取自己根据qos
 *
 *  @param qos <#qos description#>
 *
 *  @return <#return value description#>
 */
+(instancetype)defaultPoolForQOS:(NSQualityOfService)qos;



@end

/**
 *  获取对列
 *
 *  @param qos qos
 *
 *  @return 获取对列
 */
extern dispatch_queue_t LSDispatchQueueGetForQOS(NSQualityOfService qos);
NS_ASSUME_NONNULL_END

#endif