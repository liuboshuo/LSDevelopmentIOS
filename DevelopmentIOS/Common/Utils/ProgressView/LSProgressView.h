//
//  LSView.h
//  02-下载进度
//
//  Created by 刘硕 on 15-5-6.
//  Copyright (c) 2015年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 *
 用法:
 圆弧的进度条（中间显示进度文字%0~%100字样）
 LSProgressView *progress = [[LSProgressView alloc] init];
 progress.frame = CGRectMake(10, 100, 100, 100);
 progress.width = 5;
 progress.color  = [UIColor purpleColor];
 [self.view addSubview:progress];
 
 //设置进度
 
 progress.process = 0.5;
 progress.process = 0;   (0~1.0)
 
 */
@interface LSProgressView : UIView

@property(nonatomic, assign)CGFloat process;

@property(nonatomic , assign)CGFloat width;

@property(nonatomic , strong)UIColor *color;


@end
