//
//  ErrorView.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/16.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "ErrorView.h"
#import "UIView+Extension.h"
#import "UIPropertyConstant.h"
#import "SizeTool.h"
@interface ErrorView ()

/**
 *  错误提示标签
 */
@property(nonatomic , weak)UILabel *errorLabel;

/**
 *  错误提示图片视图
 */
@property(nonatomic , weak)UIImageView *errorImageView;

@end

@implementation ErrorView

#pragma mark 懒加载方法
-(UILabel *)errorLabel
{
    if (!_errorLabel) {
        UILabel *errorLabel = [[UILabel alloc] init];
        errorLabel.textAlignment = NSTextAlignmentCenter;
        errorLabel.textColor = Color(100, 100, 100,1.0);
        [self addSubview:errorLabel];
        _errorLabel = errorLabel;
    }
    return _errorLabel;
}

-(UIImageView *)errorImageView
{
    if (!_errorImageView) {
        UIImageView *errorImageView = [[UIImageView alloc] init];
        [self addSubview:errorImageView];
        _errorImageView = errorImageView;
    }
    return _errorImageView;
}



#pragma mark 私有方法

-(void)setErrorText:(NSString *)errorText
{
    _errorText = errorText;
    self.errorLabel.text = _errorText;
    CGFloat padding = 10;
    CGFloat maxWidth = UIScreenWidth - 2 * padding;
    CGSize size = [SizeTool sizeWithText:_errorText font:_errorLabel.font];
    if (size.width > maxWidth) {
        
        CGSize sizeT = [SizeTool sizeWithText:_errorText font:_errorLabel.font w:maxWidth];
        self.errorLabel.width = sizeT.width;
        self.errorLabel.height = sizeT.height;
    }else{
        self.errorLabel.width = size.width;
        self.errorLabel.height = size.height;
    }
    self.errorLabel.centerX = self.width / 2;
    self.errorLabel.y = self.errorImageView.bottomY + 10;
}
-(void)setErrorImageName:(NSString *)errorImageName
{
    _errorImageName = errorImageName;
    if (_errorImageName
        == nil) {
        self.errorImageView.image = [UIImage imageNamed:@"biaoqing"];
    }else{
        self.errorImageView.image = [UIImage imageNamed:_errorImageName];
    }
    self.errorImageView.width = 80;
    self.errorImageView.height = 80;
    self.errorImageView.centerX = self.width / 2;
    self.errorImageView.y = 30;
}

/**
 *  回调
 *
 *  @param touches <#touches description#>
 *  @param event   <#event description#>
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    if ([self.delegate respondsToSelector:@selector(errorViewTouch)]){
        [_delegate errorViewTouch];
    }else{
        if(self.tap){
            self.tap();
        }
    }
}
@end
