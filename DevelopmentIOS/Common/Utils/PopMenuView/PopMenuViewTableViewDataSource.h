//
//  PopMenuViewTableViewDataSource.h
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PopMenuTableViewCell.h"
#import "PopMenuModel.h"

typedef void(^tableViewCellConfigureBlock)(PopMenuTableViewCell *cell,PopMenuModel *model);

@interface PopMenuViewTableViewDataSource : NSObject<UITableViewDataSource>


-(instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass configureCellBlock:(tableViewCellConfigureBlock)configureCellBlock;

@end
