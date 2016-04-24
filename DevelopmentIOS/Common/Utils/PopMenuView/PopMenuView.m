

//
//  PopMenuView.m
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "PopMenuView.h"
#import "PopMenuViewSingleton.h"
#define kPopTriangleLengthHalf 10
#define kPopMargin 15
#define kPopPadding 10
@interface PopMenuView ()
@property(nonatomic , strong)PopMenuViewTableViewDataSource *dataSource;
@property(nonatomic , strong)PopMenuViewTableViewDelegate *delegate;
@end
@implementation PopMenuView

-(instancetype)initWithFrame:(CGRect)frame menuSize:(CGSize)menuSize items:(NSArray *)items action:(void (^)(NSIndexPath *))action from:(UIView *)from
{
    if (self = [super initWithFrame:frame]) {
        _menuModels = items;
        _menuSize = menuSize;
        _action = [action copy];
        _fromView = from;
        _dataSource = [[PopMenuViewTableViewDataSource alloc] initWithItems:self.menuModels cellClass:[PopMenuTableViewCell class] configureCellBlock:^(PopMenuTableViewCell *cell, PopMenuModel *model) {
            cell.textLabel.text = model.title;
            if (model.imageName != nil) {
                cell.imageView.image = [UIImage imageNamed:model.imageName];
            }
        }];
        
        _delegate = [[PopMenuViewTableViewDelegate alloc] initWithDidSelectRowAtIndexPath:^(NSIndexPath *indexPath) {
            if (self.action) {
                self.action(indexPath);
            }
        }];
        self.backgroundColor = [UIColor purpleColor];
        
        
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:[self menuFrame:from] style:UITableViewStylePlain];
        tableView.rowHeight = kPopCellHeight;
        tableView.dataSource = self.dataSource;
        tableView.delegate = self.delegate;
        [self addSubview:tableView];
        self.tableView = tableView;
        tableView.layer.cornerRadius = 10.0;
        tableView.layer.anchorPoint = CGPointMake(1.0, 0);
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}
-(CGRect)menuFrame:(UIView *)from
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    CGRect newF = [from convertRect:from.bounds toView:window];
    if (_menuSize.width > newF.size.width) {
        if (newF.origin.x - fabs(_menuSize.width - _fromView.frame.size.width) / 2 < 0) {
            return (CGRect){kPopMargin,newF.origin.y + from.frame.size.height + kPopTriangleLengthHalf + kPopPadding ,_menuSize.width,_menuSize.height};
        }else{
            if (newF.origin.x + _menuSize.width > [UIScreen mainScreen].bounds.size.width) {
                return (CGRect){ ([UIScreen mainScreen].bounds.size.width - _menuSize.width) - kPopMargin,newF.origin.y + from.frame.size.height + kPopTriangleLengthHalf + kPopPadding ,_menuSize.width,_menuSize.height};
            }else{
                return (CGRect){newF.origin.x - fabs(_menuSize.width - _fromView.frame.size.width) / 2,newF.origin.y + from.frame.size.height + kPopTriangleLengthHalf + kPopPadding ,_menuSize.width,_menuSize.height};
            }
        }
    }else{
        return (CGRect){newF.origin.x + newF.size.width / 2 - self.menuSize.width / 2 , newF.origin.y + from.frame.size.height + kPopTriangleLengthHalf + kPopPadding ,_menuSize.width,_menuSize.height};
    }
}

-(void)drawRect:(CGRect)rect
{
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject];
    CGRect newF = [_fromView convertRect:_fromView.bounds toView:window];
    [[UIColor whiteColor] set];
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat location = (newF.origin.x + newF.size.width / 2 ) + kPopTriangleLengthHalf;
    CGFloat origin = newF.origin.y + _fromView.frame.size.height + kPopTriangleLengthHalf + kPopPadding;
    
    if (location >= self.tableView.frame.origin.x + _menuSize.width - self.tableView.layer.cornerRadius) {
        location = location - 2 * self.tableView.layer.cornerRadius;
    }else if (location <= self.tableView.frame.origin.x + 2 * kPopTriangleLengthHalf + self.tableView.layer.cornerRadius){
        location = location + self.tableView.layer.cornerRadius;
    }
    CGContextMoveToPoint(context, location, origin);
    CGContextAddLineToPoint(context, location - 1*kPopTriangleLengthHalf, origin - kPopTriangleLengthHalf);
    CGContextAddLineToPoint(context, location - 2*kPopTriangleLengthHalf, origin);
    CGContextClosePath(context);
    
    [[UIColor whiteColor] setFill];
    [[UIColor whiteColor] setStroke];
    CGContextDrawPath(context, kCGPathFillStroke);
    
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    PopMenuViewSingleton *singlton = [PopMenuViewSingleton sharePopMenuViewSingleton];
    [singlton hideMenu];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tableView.frame = [self menuFrame:_fromView];
}
@end
