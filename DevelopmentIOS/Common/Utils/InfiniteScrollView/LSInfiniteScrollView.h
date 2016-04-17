//
//  LSInfiniteScrollView.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ScrollViewNetDelegate <NSObject>

@optional
-(void)didSelectNetImageAtIndex:(NSInteger)idex;

@end

@protocol ScrollViewLocalDelegate <NSObject>

@optional
-(void)didSelectLocalImageAtIndex:(NSInteger)idex;

@end
@interface LSInfiniteScrollView : UIView



@property(nonatomic,  strong)id<ScrollViewNetDelegate> netDelegate;

@property(nonatomic , strong)id<ScrollViewLocalDelegate> localDelegate;

@property(nonatomic , strong)UIImage *placeholderImage;

//延迟时间
@property(nonatomic , assign)NSTimeInterval autoScrollDelay;

/**
 *  加载本地图片
 *
 *  @param frame       <#frame description#>
 *  @param imagesNames <#imagesNames description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame localImageNames:(NSArray<NSString *> *)imagesNames;

/**
 *  <#Description#>
 *
 *  @param frame <#frame description#>
 *  @param urls  <#urls description#>
 *
 *  @return <#return value description#>
 */
-(instancetype)initWithFrame:(CGRect)frame netURLs:(NSArray<NSString *> *)urls;


@end
