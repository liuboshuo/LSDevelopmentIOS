//
//  LSTableViewCellViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSTableViewCellViewController.h"
#import "LSTableViewCell.h"
@interface LSTableViewCellViewController (){
    NSArray *_sections;
    NSMutableArray *_testArray;
}
@property (nonatomic) BOOL useCustomCells;

@end

@implementation LSTableViewCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.tableView.rowHeight = 50;
    self.navigationItem.title = @"侧滑效果";
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(toggleCells:) forControlEvents:UIControlEventValueChanged];
    refreshControl.tintColor = [UIColor blueColor];
    self.refreshControl = refreshControl;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    
    _sections = [[UILocalizedIndexedCollation currentCollation] sectionIndexTitles];
    
    _testArray = [[NSMutableArray alloc] init];
    
    self.useCustomCells = NO;
    
    for (int i = 0; i < _sections.count; ++i) {
        [_testArray addObject:[NSMutableArray array]];
    }
    
    for (int i = 0; i < _sections.count; ++i) {
        NSString *string = [NSString stringWithFormat:@"%d", i];
        [_testArray[i] addObject:string];
    }
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _testArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_testArray[section] count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView选中 %ld:%ld", (long)indexPath.section, (long)indexPath.row);
    NSLog(@"选中 %@", [self.tableView indexPathForSelectedRow]);
    
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return _sections[section];
}

#pragma mark - UIRefreshControl Selector

- (void)toggleCells:(UIRefreshControl*)refreshControl
{
    [refreshControl beginRefreshing];
    self.useCustomCells = !self.useCustomCells;
    if (self.useCustomCells)
    {
        self.refreshControl.tintColor = [UIColor yellowColor];
    }
    else
    {
        self.refreshControl.tintColor = [UIColor blueColor];
    }
    [self.tableView reloadData];
    [refreshControl endRefreshing];
}

#pragma mark - UIScrollViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.useCustomCells)
    {
        LSTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"CellCustom"];
        if (cell == nil) {
            cell = [[LSTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellCustom"];
        }
        [cell setRightUtilityButtons:[self rightButtons] WithButtonWidth:58.0f];
        cell.delegate = self;
        
        cell.textLabel.text = [NSString stringWithFormat:@"组 %ld, 行 %ld", (long)indexPath.section, (long)indexPath.row];
        
        return cell;
    }
    else
    {
        static NSString *cellIdentifier = @"Cell";
        
        SWTableViewCell *cell = (SWTableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (cell == nil) {
            
            cell = [[SWTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
            cell.rightUtilityButtons = [self rightButtons];
            cell.delegate = self;
        }
        
        NSDate *dateObject = _testArray[indexPath.section][indexPath.row];
        cell.textLabel.text = [dateObject description];
        cell.textLabel.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.backgroundColor = [UIColor whiteColor];
        cell.detailTextLabel.text = @"详细";
        
        return cell;
    }
    
}

- (NSArray *)rightButtons
{
    NSMutableArray *rightUtilityButtons = [NSMutableArray new];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:0.78f green:0.78f blue:0.8f alpha:1.0]
                                                title:@"更多"];
    [rightUtilityButtons sw_addUtilityButtonWithColor:
     [UIColor colorWithRed:1.0f green:0.231f blue:0.188 alpha:1.0f]
                                                title:@"删除"];
    
    return rightUtilityButtons;
}

#pragma mark - SWTableViewDelegate
- (void)swipeableTableViewCell:(SWTableViewCell *)cell scrollingToState:(SWCellState)state
{
    switch (state) {
        case 0:
            NSLog(@"工具按钮 隐藏");
            break;
        case 1:
            NSLog(@"左边工具按钮打开");
            break;
        case 2:
            NSLog(@"右边工具按钮打开");
            break;
        default:
            break;
    }
}
- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerRightUtilityButtonWithIndex:(NSInteger)index
{
    switch (index) {
        case 0:
        {
            UIAlertView *alertTest = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"更多" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
            [alertTest show];
            
            [cell hideUtilityButtonsAnimated:YES];
            break;
        }
        case 1:
        {
            // Delete button was pressed
            NSIndexPath *cellIndexPath = [self.tableView indexPathForCell:cell];
            
            [_testArray[cellIndexPath.section] removeObjectAtIndex:cellIndexPath.row];
            [self.tableView deleteRowsAtIndexPaths:@[cellIndexPath] withRowAnimation:UITableViewRowAnimationLeft];
            break;
        }
        default:
            break;
    }
}
/**
 *  tableView是否可以多个tableViewCell的侧滑出现
 *
 *  @param cell <#cell description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)swipeableTableViewCellShouldHideUtilityButtonsOnSwipe:(SWTableViewCell *)cell
{
    // allow just one cell's utility button to be open at once
    return NO;
}


/**
 *  设置是否显示
 *
 *  @param cell  <#cell description#>
 *  @param state <#state description#>
 *
 *  @return <#return value description#>
 */
- (BOOL)swipeableTableViewCell:(SWTableViewCell *)cell canSwipeToState:(SWCellState)state
{
    switch (state) {
        case 1:
            return YES;
            break;
        case 2:
            return YES;
            break;
        default:
            break;
    }
    
    return YES;
}

@end
