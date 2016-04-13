//
//  LSAlertView.m
//  CGV电影购票
//
//  Created by 刘硕 on 15/12/11.
//  Copyright (c) 2015年 lck. All rights reserved.
//

#import "LSAlertView.h"
#import "SizeTool.h"
#import "UIView+Extension.h"
#import "UIPropertyConstant.h"
#define LSMainScreenW [UIScreen mainScreen].bounds.size.width
#define LSMainScreenH [UIScreen mainScreen].bounds.size.height

#define margin 25
#define padding 5

#define textFont [UIFont systemFontOfSize:14]

#define titleFont [UIFont systemFontOfSize:20]

@interface LSAlertView()

@property(nonatomic,weak)UIView *containerView;

@property(nonatomic , weak)UILabel *alertViewTitleLabel;

@property(nonatomic ,weak)UIImageView *imageView;

@property(nonatomic , weak)UILabel *textLabel;

@property(nonatomic , assign)LSShowViewModelType type;

@property(nonatomic , weak)UIButton *okBtn;

@property(nonatomic ,weak)UIButton *cancleBtn;

@property(nonatomic , weak)UIView *line;

@end
@implementation LSAlertView
/**
 *  初始化空间
 *
 *  @param frame <#frame description#>
 *
 *  @return <#return value description#>
 */
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        UIView *contatinerView = [[UIView alloc] init];
        contatinerView.backgroundColor = [UIColor whiteColor];
        contatinerView.layer.cornerRadius = 10;
        [self addSubview:contatinerView];
        self.containerView = contatinerView;
        
        UILabel *alertViewTitleLabel = [[UILabel alloc] init];
        alertViewTitleLabel.textAlignment = NSTextAlignmentCenter;
        alertViewTitleLabel.textColor = [UIColor blackColor];
        [self.containerView addSubview:alertViewTitleLabel];
        self.alertViewTitleLabel = alertViewTitleLabel;
        alertViewTitleLabel.font = titleFont;
        alertViewTitleLabel.font = [UIFont boldSystemFontOfSize:20];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeCenter;
        [self.containerView addSubview:imageView];
        self.imageView = imageView;
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.textColor = [UIColor blackColor];
        textLabel.numberOfLines = 0;
        [self.containerView addSubview:textLabel];
        self.textLabel = textLabel;
        textLabel.font = textFont;
        
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor lightGrayColor];
        [self.containerView addSubview:view];
        self.line = view;
        
    }
    return self;
}

-(instancetype)initWithType:(LSShowViewModelType)type
{
    self = [super init];
    
    if (self) {
        _type = type;
        switch (type) {
            case LSShowViewModelCancle:
                self.cancleBtn = [self createBtnWithTitle:@"取消" selector:@selector(cancleButtonClick)];
                break;
            case LSShowViewModelOk:
                self.okBtn = self.cancleBtn = [self createBtnWithTitle:@"确定" selector:@selector(okButtonClick)];
                break;
            case LSShowViewModelBoth:
                self.cancleBtn = [self createBtnWithTitle:@"取消" selector:@selector(cancleButtonClick)];
                self.okBtn = [self createBtnWithTitle:@"确定" selector:@selector(okButtonClick)];
                break;
            default:
                break;
        }
    }
    return self;
}

-(UIButton *)createBtnWithTitle:(NSString *)title selector:(SEL)selector
{
    UIButton *button = [[UIButton alloc] init];
    [button setTitleColor:Color(62, 153, 252,1.0) forState:UIControlStateNormal];
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:button];
    return button ;
}
-(void)cancleButtonClick
{
    if ([self.delegate respondsToSelector:@selector(alertView:didClickWithIndex:type:)]) {
        [self.delegate alertView:self didClickWithIndex:0 type:self.type];
    }
    if (self.delegate == nil) {
        if (self.block) {
            self.block(self,0,self.type);
        }
    }
    [self removeFromSuperview];
}
-(void)okButtonClick
{
    if ([self.delegate respondsToSelector:@selector(alertView:didClickWithIndex:type:)]) {
        [self.delegate alertView:self didClickWithIndex:1 type:self.type];
    }
    if (self.delegate == nil) {
        if (self.block) {
            self.block(self,1,self.type);
        }
    }
    [self removeFromSuperview];
    
}
-(void)show
{
    if (self.alertViewTitle == nil || [self.alertViewTitle isEqualToString:@""]) {
        self.alertViewTitle = @"标题";
    }
    
    if (self.imageURL == nil || [self.imageURL isEqualToString:@""]) {
        self.imageURL = @"";
    }
    
    if (self.alertViewText == nil || [self.alertViewText isEqualToString:@""]) {
        self.alertViewText = @"内容文字";
    }
    
    // 设置
    CGFloat titleX = padding;
    CGFloat titleY = 2 * padding;
    CGFloat titleW = LSMainScreenW - 2 * margin - 2 * padding;
    CGFloat titleH = 25;
    self.alertViewTitleLabel.text = self.alertViewTitle;
    self.alertViewTitleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    CGFloat imageViewMaxY = self.alertViewTitleLabel.bottomY + padding * 2;
    ;
    if (![self.imageURL isEqualToString:@""]) {
        CGFloat imageViewX = padding;
        CGFloat imageViewY = self.alertViewTitleLabel.bottomY + padding;
        CGFloat imageViewW = titleW;
        CGFloat imageViewH = 200;
        self.imageView.frame = CGRectMake(imageViewX, imageViewY, imageViewW, imageViewH);
        self.imageView.image = [UIImage imageNamed:self.imageURL];
        
        imageViewMaxY = self.imageView.bottomY + padding;
    }
    
    
    CGFloat textX = titleX + padding;
    CGFloat textY = imageViewMaxY;
    CGFloat textW = titleW - 2 * padding;
    CGFloat textH = [SizeTool sizeWithText:self.alertViewText font:self.textLabel.font w:textW].height;
    self.textLabel.frame = CGRectMake(textX, textY, textW, textH);
    self.textLabel.text = self.alertViewText;
    
    self.line.x = 0;
    self.line.y = self.textLabel.bottomY + padding + 10;
    self.line.width = LSMainScreenW - 2 * margin;
    self.line.height = 0.5;
    
    //按钮高度
    CGFloat buttonH = 35;
    CGFloat buttonW = 0;
    CGFloat buttonX = 0;
    CGFloat buttonY = self.line.bottomY;
    
    switch (self.type) {
        case LSShowViewModelCancle:
            buttonW = LSMainScreenW - 2 * margin;
            self.cancleBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            break;
        case LSShowViewModelOk:
            buttonW = LSMainScreenW - 2 * margin;
            self.okBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
            break;
        case LSShowViewModelBoth:
            buttonW = (LSMainScreenW - 2 * margin)/2;
            self.cancleBtn.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);\
            UIView *view = [[UIView alloc] init];
            view.backgroundColor = [UIColor lightGrayColor];
            view.x = self.cancleBtn.rightX;
            view.y = buttonY;
            view.height = buttonH + padding;
            view.width = 0.5;
            [self.containerView addSubview:view];
            self.okBtn.frame = CGRectMake(self.cancleBtn.rightX, buttonY, buttonW, buttonH);
            break;
    }
    
    
    CGFloat containerViewW = LSMainScreenW - 2 * margin;
    CGFloat containerViewH = self.line.bottomY + buttonH + padding;
    CGFloat containerViewX = margin;
    CGFloat containerViewY = LSMainScreenH / 2 - containerViewH /2;
    self.containerView.frame = CGRectMake(containerViewX, containerViewY, containerViewW, containerViewH);
    self.containerView.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
}

-(void)hide
{
    [self removeFromSuperview];
}
@end
