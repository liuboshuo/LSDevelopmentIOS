//
//  LSInfiniteScrollView.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

//网络图片


/**
 *
 
 图片轮播图
 
 使用方法:
 
 
 创建
 LSInfiniteScrollView *scroll = [[LSInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) netURLs:@[图片地址]];
 //延迟时间
 scroll.autoScrollDelay = 3;
 代理
 scroll.netDelegate = self;
 
 [self.view addSubview:scroll];
 */

@protocol ScrollViewNetDelegate <NSObject>

@optional
//选中第几个图片回调
-(void)didSelectNetImageAtIndex:(NSInteger)idex;

@end
//本地图片
@protocol ScrollViewLocalDelegate <NSObject>

@optional
//选中第几个图片回调
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
