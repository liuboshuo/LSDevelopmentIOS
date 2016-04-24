//
//  PopMenuViewTableViewDelegate.m
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PopMenuViewTableViewDelegate.h"

@interface PopMenuViewTableViewDelegate ()

@property(nonatomic , copy)tableViewDidSelectAtIndexPath tableViewDidSelectRowAtIndexPath;

@end
@implementation PopMenuViewTableViewDelegate
-(instancetype)initWithDidSelectRowAtIndexPath:(tableViewDidSelectAtIndexPath)tableViewDidSelectRowAtIndexPath
{
    if (self = [super init]) {
        self.tableViewDidSelectRowAtIndexPath = [tableViewDidSelectRowAtIndexPath copy];
    }
    return self;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSelector:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kPopCellHeight;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableViewDidSelectRowAtIndexPath) {
        self.tableViewDidSelectRowAtIndexPath(indexPath);
    }
}
@end
