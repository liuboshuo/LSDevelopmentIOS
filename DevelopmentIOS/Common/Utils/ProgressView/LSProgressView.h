//
//  LSView.h
//  02-下载进度
//
//  Created by 刘硕 on 15-5-6.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSProgressView : UIView

@property(nonatomic, assign)CGFloat process;

@property(nonatomic , assign)CGFloat width;

@property(nonatomic , strong)UIColor *color;


@end
