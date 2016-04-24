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
@interface PopMenuView : UIView

@property(nonatomic , assign)CGSize menuSize;
@property(nonatomic , copy)void (^action)(NSIndexPath *indexPath);
@property(nonatomic , copy)NSArray *menuModels;
@property(nonatomic , strong)UITableView *tableView;

-(instancetype)initWithFrame:(CGRect)frame menuSize:(CGSize)menuSize items:(NSArray *)items action:(void (^)(NSIndexPath *indexPath))action from:(UIView *)from;

@property(nonatomic , strong)UIView *fromView;

@end
