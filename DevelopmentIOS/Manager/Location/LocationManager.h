//
//  LocationManager.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/15.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingletonTemplate.h"
#import <CoreLocation/CoreLocation.h>

/**
 *  
 
 定位的使用:
 
 获取坐标
 [[LocationManager sharedLocationManager] getLocation:^(CLLocation *location) {
 //坐标
 }];
 
 *
 *  @param location <#location description#>
 *
 *  @return <#return value description#>
 */

typedef void(^locationHandle)(CLLocation *location);


@interface LocationManager : NSObject

/**
 *  单例
 */
singletonInterface(LocationManager);

/**
 *  当前位置
 */
@property(nonatomic,strong)CLLocation *location;

/**
 *  获取位置回调
 */
@property(nonatomic,copy)locationHandle handle;

/**
 *  获取当前位置
 */
-(void)getLocation:(locationHandle)completion;


@end
