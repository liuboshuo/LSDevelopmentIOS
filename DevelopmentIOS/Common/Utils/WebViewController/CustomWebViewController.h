//
//  CustomWebViewController.h
//  LSWebViewProject
//
//  Created by 刘硕 on 15/12/25.
//  Copyright © 2015年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

//替换image

/**
 *  网页浏览器的封装
 
 
 CustomWebViewController *web = [[CustomWebViewController alloc] initProgressWebViewWithURLStr:@"http://www.baidu.com" withTitle:@"百度"];
 web.navigatemColor = [UIColor orangeColor];
 web.progressColor = [UIColor orangeColor];
 [self.navigationController pushViewController:web animated:YES];
 
 
 
 */
@interface CustomWebViewController : UIViewController

/**
 *  主页地址
 */
@property(nonatomic , strong)NSURL *homeURL;

@property(nonatomic , strong)UIColor *progressColor;

@property(nonatomic , strong)UIColor *navigatemColor;
/**
 *  初始化网页浏览器视图
 */
-(CustomWebViewController *)initProgressWebViewWithURLStr:(NSString *)urlStr withTitle:(NSString *)title;


@end
