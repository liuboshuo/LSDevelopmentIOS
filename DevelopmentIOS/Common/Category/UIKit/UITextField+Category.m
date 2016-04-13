//
//  UITextField+Category.m
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "UITextField+Category.h"

@implementation UITextField (Category)


- (UIView*)addKeyBoardWithCompleteBtn
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, 35)];
    // 173 181 189
    bgView.backgroundColor = [UIColor colorWithRed:202.0/255 green:202.0/255 blue:208.0/255 alpha:1];
    self.inputAccessoryView = bgView;
    // 按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@" 完成" forState:UIControlStateNormal];
    [button setFrame:CGRectMake(width-80,0 , 80, 35)];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [bgView addSubview:button];
    
    return bgView;
}

- (void)buttonClick:(UIButton*)btn
{
    [self resignFirstResponder];
}

- (void)selectAllText {
    UITextRange *range = [self textRangeFromPosition:self.beginningOfDocument toPosition:self.endOfDocument];
    [self setSelectedTextRange:range];
}

- (void)setSelectedRange:(NSRange)range {
    UITextPosition *beginning = self.beginningOfDocument;
    UITextPosition *startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition *endPosition = [self positionFromPosition:beginning offset:NSMaxRange(range)];
    UITextRange *selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectionRange];
}

@end
