
//
//  PopMenuViewSingleton.m
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PopMenuViewSingleton.h"
#import "PopMenuView.h"
@interface PopMenuViewSingleton ()
@property(nonatomic , strong)PopMenuView *popMenu;

@end
@implementation PopMenuViewSingleton

+(PopMenuViewSingleton *)sharePopMenuViewSingleton
{
    static PopMenuViewSingleton *popMenuViewSingleton;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popMenuViewSingleton = [[PopMenuViewSingleton alloc] init];
    });
    return popMenuViewSingleton;
}

-(void)showPopMenuSelecteWithFrame:(CGSize)size item:(NSArray *)item action:(void (^)(NSIndexPath *indexPath))action from:(UIView *)from
{
    __weak typeof(self) weakSelf = self;
    if (self.popMenu != nil) {
        [self hideMenu];
    }
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    self.popMenu = [[PopMenuView alloc] initWithFrame:window.bounds menuSize:size items:item action:^(NSIndexPath *indexPath) {
        [weakSelf hideMenu];
    } from:from];
    self.popMenu.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
    [window addSubview:self.popMenu];
}

-(void)hideMenu
{
    
    [self.popMenu.tableView removeFromSuperview];
    [self.popMenu removeFromSuperview];
    self.popMenu.tableView = nil;
    self.popMenu = nil;
    
}
@end
