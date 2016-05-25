//
//  ShowBigImageView.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/2/18.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <UIKit/UIKit.h>


/**
 *  大图效果
 
 
 ShowBigImageView *showBigImageView = [[ShowBigImageView alloc] initWithFrame:UICurrentWindow.bounds];
 //小图必须
 showBigImageView.smallImageView = imageView;
 showBigImageView.bigImageIcon = @"http://121.196.228.152/image/6919620160407185559042.jpg";
 //窗口
 [UICurrentWindow addSubview:showBigImageView];
 
 
 */
@interface ShowBigImageView : UIView
/**
 *  小图
 */
@property(nonatomic , strong)UIImageView *smallImageView;
/**
 *  大图的链接
 */
@property(nonatomic , copy)NSString *bigImageIcon;

@end
