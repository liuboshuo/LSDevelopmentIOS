//
//  UITextField+Category.h
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Category)

/**
 *  添加隐藏键盘按钮
 *
 *  @return <#return value description#>
 */
-(UIView *)addKeyBoardWithCompleteBtn;

/**
 *  选择所有文字
 */
- (void)selectAllText;

/**
 *  选择范围的文字
 *
 *  @param range <#range description#>
 */
- (void)setSelectedRange:(NSRange)range;



@end
