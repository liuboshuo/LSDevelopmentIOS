
//
//  LSBarButtonItem.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/11.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSBarButtonItem.h"
#import "UIBarButtonItem+Category.h"
#import "NSString+Category.h"
@implementation LSBarButtonItem

+(instancetype)itemWithTitle:(NSString *)title image:(NSString *)image isBackButtonItem:(BOOL)isBackButtonItem target:(id)target action:(SEL)action
{
    if (isBackButtonItem) {
        //返回
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.backgroundColor = [UIColor clearColor];
        if (image) {
            [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
        }
        if (title) {
            [btn setTitle:title forState:UIControlStateNormal];
        }
        
        btn.titleLabel.font = [UIFont systemFontOfSize:17];
        
        CGFloat titleSizeW = [title widthForFont:btn.titleLabel.font];
        
        
        btn.frame = CGRectMake(0, 0, 20 + titleSizeW, 44);
        
        CGFloat padding = 25;
        
        btn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, btn.frame.size.width - btn.imageView.frame.size.width + padding);
        
        if (title) {
            btn.titleEdgeInsets = UIEdgeInsetsMake(0, -padding, 0, 0);
        }
        
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        LSBarButtonItem *item = [[LSBarButtonItem alloc] initWithCustomView:btn];
        return item;
    }else{
        LSBarButtonItem *item = [[LSBarButtonItem alloc]
                                 initWithTitle:title
                                 style:UIBarButtonItemStylePlain
                                 target:target
                                 action:action];
        return item;
    }
}

+(instancetype)itemWithTitle:(NSString *)title isBackButtonItem:(BOOL)isBackButtonItem target:(id)target action:(SEL)action
{
    return [self itemWithTitle:title image:nil isBackButtonItem:isBackButtonItem target:target action:action];
}

+(instancetype)itemWithImage:(NSString *)image isBackButtonItem:(BOOL)isBackButtonItem target:(id)target action:(SEL)action
{
    
    //返回
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.backgroundColor = [UIColor clearColor];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    btn.frame = CGRectMake(0, 0, 44, 44);
    btn.imageEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    LSBarButtonItem *item = [[LSBarButtonItem alloc] initWithCustomView:btn];
    
    return item;
}


+(instancetype)backItemWithImage:(NSString *)image target:(id)target action:(SEL)action
{
    return [self itemWithTitle:nil image:image isBackButtonItem:YES target:target action:action];
}

-(void)setEnabled:(BOOL)enabled
{
    [super setEnabled:enabled];
    if ([self.customView isKindOfClass:[UIControl class]]) {
        UIControl *ctrl = (UIControl *)self.customView;
        ctrl.enabled = enabled;
    }
}
@end
