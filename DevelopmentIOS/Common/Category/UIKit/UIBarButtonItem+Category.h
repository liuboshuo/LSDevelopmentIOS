//
//  UIBarButtonItem+Category.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (Category)

/**
 *  为BarButtonItem添加回调
 */
@property(nonatomic , copy) void (^block)(id);

@end
