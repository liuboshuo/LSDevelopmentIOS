
//
//  LSSkinMananger.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/11.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSSkinMananger.h"
#import "UIPropertyConstant.h"
//#import "LSProjectUtils.h"

#define LSCurrentSkinType @"LSCurrentSkinType"

static NSBundle *SkinDefaultColor = nil;
static NSBundle *SkinNightColor = nil;


@implementation LSSkinMananger

singletonImplementation(LSSkinMananger);

-(void)initSkinSetting
{
    NSNumber *currentSKinType = [UserDefaults objectForKey:LSCurrentSkinType];
    if (currentSKinType == nil) {
        
        [self setCurrentSkinType:LSSkinManangerDefalut];
        
    }else{
        [self setCurrentSkinType:(LSSkinManangerType)currentSKinType.integerValue];
    }
}

-(void)setCurrentSkinType:(LSSkinManangerType)currentSkinType
{
    
    _currentSkinType = currentSkinType;
    
    [UserDefaults setObject:[NSNumber numberWithInteger:currentSkinType] forKey:LSCurrentSkinType];
    //    [LSProjectUtils saveValueNSUserdefaultsWithKey:LSCurrentSkinType value:[NSNumber numberWithInteger:currentSkinType]];
    //通知更新皮肤颜色
}

+(UIImage *)imageNamed:(NSString *)name
{
    NSString *AppPath = [[NSBundle mainBundle] resourcePath];
    if ([LSSkinMananger sharedLSSkinMananger].currentSkinType == LSSkinManangerDefalut) {
        return [UIImage imageNamed:name];
    }else{
        if ([LSSkinMananger sharedLSSkinMananger].currentSkinType == LSSkinManangerNight) {
            AppPath = [AppPath stringByAppendingPathComponent:@"switch_night"];
        }
        if (iOS7) {
            AppPath = [AppPath stringByAppendingPathComponent:name];
        }else{
            AppPath = [AppPath stringByAppendingPathComponent:name];
            AppPath = [NSString stringWithFormat:@"%@@2x.png",AppPath];
        }
        return [UIImage imageWithContentsOfFile:AppPath];
    }
}

+(UIColor *)colorNamed:(NSString *)name
{
    
    NSString *AppPath = [[NSBundle mainBundle] resourcePath];
    NSBundle *bundleColorConfig = nil;
    if ([LSSkinMananger sharedLSSkinMananger].currentSkinType == LSSkinManangerDefalut) {
        if (SkinDefaultColor == nil) {
            SkinDefaultColor = [NSBundle bundleWithPath:AppPath];
        }
        bundleColorConfig = SkinDefaultColor;
    }else if ([LSSkinMananger sharedLSSkinMananger].currentSkinType == LSSkinManangerNight){
        if (SkinNightColor == nil) {
            AppPath = [AppPath stringByAppendingPathComponent:@"switch_night"];
            SkinNightColor = [NSBundle bundleWithPath:AppPath];
        }
        bundleColorConfig = SkinNightColor;
        
    }
    
    if (bundleColorConfig != nil) {
        NSString *colorstr = [bundleColorConfig localizedStringForKey:name value:name table:@"SkinAllColor"];
        if (colorstr) {
            NSArray *colors = [colorstr componentsSeparatedByString:@","];
            return Color([colors[0] floatValue], [colors[1] floatValue], [colors[2] floatValue], [colors[3] floatValue]);
        }else{
            return nil;
        }
    }
    
    return nil;
}
@end
