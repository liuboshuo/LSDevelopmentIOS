//
//  ProgressView.h
//  LSZhiHuNews
//
//  Created by 刘硕 on 15/12/20.
//  Copyright © 2015年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

@property(nonatomic , strong)UIColor *strokeColor;
@property(nonatomic , assign)CGFloat width;

-(void)loadingAnimation;

-(void)stop;

@end
