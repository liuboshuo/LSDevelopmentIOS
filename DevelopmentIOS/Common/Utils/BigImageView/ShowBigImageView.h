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
