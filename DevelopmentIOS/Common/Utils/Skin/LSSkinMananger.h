//
//  LSSkinMananger.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/11.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LSDevelopmetIOS.h"

typedef NS_ENUM(NSUInteger , LSSkinManangerType)
{
    LSSkinManangerDefalut = 0,
    LSSkinManangerNight = 1
};



#define LSNotificationRefreshAllSkin @"LSNotificationRefreshAllSkin"

@interface LSSkinMananger : NSObject

/**
 *  当前皮肤
 */
@property(nonatomic , assign)LSSkinManangerType currentSkinType;


singletonInterface(LSSkinMananger);

/**
 *  在appDeleate初始化
 */
-(void)initSkinSetting;

/**
 *  根据名称获取一张图片
 *
 *  @param name
 *
 *  @return <#return value description#>
 */
+(UIImage *)imageNamed:(NSString *)name;

/**
 *  根据名称获取颜色
 *
 *  @param name <#name description#>
 *
 *  @return <#return value description#>
 */
+(UIColor *)colorNamed:(NSString *)name;

@end
