//
//  PopMenuViewTableViewDelegate.h
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PopMenuView.h"
#import "PopMenuTableViewCell.h"

#define kNumber 6
#define kPopCellHeight 40
typedef void(^tableViewDidSelectAtIndexPath)(NSIndexPath *indexPath);

@interface PopMenuViewTableViewDelegate : NSObject<UITableViewDelegate>


/**
 * 对 cell 代理初始化
 */
- (instancetype) initWithDidSelectRowAtIndexPath:(tableViewDidSelectAtIndexPath)tableViewDidSelectRowAtIndexPath;

@end
