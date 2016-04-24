
//
//  PopMenuTableViewCell.m
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PopMenuTableViewCell.h"

@implementation PopMenuTableViewCell


+(instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *cellId = @"PopMenuTableViewCell";
    PopMenuTableViewCell *ce = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (ce == nil) {
        ce = [[PopMenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    return ce;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}
@end
