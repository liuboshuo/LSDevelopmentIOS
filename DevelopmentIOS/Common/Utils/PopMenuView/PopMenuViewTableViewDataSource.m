//
//  PopMenuViewTableViewDataSource.m
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PopMenuViewTableViewDataSource.h"

@interface PopMenuViewTableViewDataSource ()

@property(nonatomic , copy)tableViewCellConfigureBlock configureCellBlock;
@property(nonatomic ,strong)Class cellClass;
@property(nonatomic , strong)NSArray *modelArray;

@end

@implementation PopMenuViewTableViewDataSource


-(instancetype)initWithItems:(NSArray *)items cellClass:(Class)cellClass configureCellBlock:(tableViewCellConfigureBlock)configureCellBlock
{
    if (self = [super init]) {
        self.modelArray =  items;
        self.cellClass = cellClass;
        self.configureCellBlock = configureCellBlock;
    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.modelArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PopMenuTableViewCell *popMenuCell = [self.cellClass cellWithTableView:tableView];
    self.configureCellBlock(popMenuCell,self.modelArray[indexPath.row]);
    return popMenuCell;
}
@end
