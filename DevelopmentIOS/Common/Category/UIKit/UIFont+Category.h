//
//  UIFont+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/8.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>
@interface UIFont (Category)

/**
 *  创建Font
 *
 *  @param CTFont CTFontRef
 *
 *  @return <#return value description#>
 */
+ (nullable UIFont *)fontWithCTFont:(nullable CTFontRef)CTFont;


/**
 *  创建UIFont
 *
 *  @param CGFont CGFontRef
 *  @param size   size
 *
 *  @return UIFont
 */
+ (nullable UIFont *)fontWithCGFont:(nullable CGFontRef)CGFont size:(CGFloat)size;

/**
 *  创建CTFontRef 返回
 *  释放
 *
 *  @return <#return value description#>
 */
- (nullable CTFontRef)CTFontRef CF_RETURNS_RETAINED;

/**
 *  创建CGFontRef 返回
 *  释放
 *
 *  @return <#return value description#>
 */
- (nullable CGFontRef)CGFontRef CF_RETURNS_RETAINED;


/**
 *  创建字体
 *
 *  @param path 文件
 *
 *  @return <#return value description#>
 */
+ (BOOL)loadFontFromPath:(nullable NSString *)path;

/**
 *  删除字体
 *
 *  @param path 路径
 */
+ (void)unloadFontFromPath:(nullable NSString *)path;

/**
 *  创建字体
 *
 *  @param data <#data description#>
 *
 *  @return <#return value description#>
 */
+ (nullable UIFont *)loadFontFromData:(nullable NSData *)data;

/**
 *  删除字体
 *
 *  @param font <#font description#>
 *
 *  @return <#return value description#>
 */
+ (BOOL)unloadFontFromData:(nullable UIFont *)font;


/**
 *  把UIFont字体转化成数据
 *
 *  @param font <#font description#>
 *
 *  @return <#return value description#>
 */
+ (nullable NSData *)dataFromFont:(nullable UIFont *)font;

/**
 *  把CGFontRef字体转化成数据
 *
 *  @param font <#font description#>
 *
 *  @return <#return value description#>
 */
+ (nullable NSData *)dataFromCGFont:(nullable CGFontRef)cgFont;


@end
