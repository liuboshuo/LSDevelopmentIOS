//
//  ReverseGeocodeLocation.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/5.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonTemplate.h"
#import "LocationManager.h"

typedef void(^locationCurrentCity)(NSDictionary *adress ,NSString *cityName, CLLocation *location);

@interface ReverseGeocodeLocation : NSObject


@property(nonatomic , strong)LocationManager *locationMgr;

singletonInterface(ReverseGeocodeLocation);

/**
 *  定位的block返回地址坐标和座城市名
 */
@property(nonatomic , copy)locationCurrentCity locationCurrentCityBlock;

/**
 *  获取当前位置
 *
 *  @param locationCurrentCity <#locationCurrentCity description#>
 */
-(void)getLocation:(locationCurrentCity)locationCurrentCity;

@end
