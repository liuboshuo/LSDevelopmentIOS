//
//  PopMenuView.h
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PopMenuViewTableViewDataSource.h"
#import "PopMenuViewTableViewDelegate.h"



/**
 *
 用法:（弹出式的菜单选择）
 
 
 NSMutableArray *obj = [NSMutableArray array];
 
 NSArray *titles = @[@"扫一扫",
 @"加好友",
 @"创建讨论组",
 @"发送到电脑",
 @"面对面快传",
 @"收钱"];
 
 for (NSInteger i = 0; i < [self titles].count; i++) {
 PopMenuModel * info = [PopMenuModel new];
 info.title = titles[i];
 [obj addObject:info];
 }
 //创建显示和点击回调
 [[PopMenuViewSingleton sharePopMenuViewSingleton]showPopMenuSelecteWithFrame:CGSizeMake(150, 200)
 item:obj
 action:^(NSIndexPath *indexPath) {
 NSLog(@"index:%ld",(long)indexPath.row);
 
 } from:btn];
 
 
 */


@interface PopMenuView : UIView

@property(nonatomic , assign)CGSize menuSize;
@property(nonatomic , copy)void (^action)(NSIndexPath *indexPath);
@property(nonatomic , copy)NSArray *menuModels;
@property(nonatomic , strong)UITableView *tableView;

-(instancetype)initWithFrame:(CGRect)frame menuSize:(CGSize)menuSize items:(NSArray *)items action:(void (^)(NSIndexPath *indexPath))action from:(UIView *)from;

@property(nonatomic , strong)UIView *fromView;

@end
