
//
//  PopMenuViewTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/19.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "PopMenuViewTest.h"
#import "LSDevelopmetIOS.h"
@interface PopMenuViewTest ()

@end

@implementation PopMenuViewTest

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake(10, 100, 50, 20);
    [button setTitle:@"点击" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [self.view addSubview:button];
}
-(void)click:(UIButton *)btn
{
    NSMutableArray *obj = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        PopMenuModel * info = [PopMenuModel new];
        info.title = [self titles][i];
        [obj addObject:info];
    }
    [[PopMenuViewSingleton sharePopMenuViewSingleton]showPopMenuSelecteWithFrame:CGSizeMake(150, 200)
                                                                            item:obj
                                                                          action:^(NSIndexPath *indexPath) {
                                                                              NSLog(@"index:%ld",(long)indexPath.row);
                                                                              
                                                                          } from:btn];
}
- (NSArray *) titles {
    return @[@"扫一扫",
             @"加好友",
             @"创建讨论组",
             @"发送到电脑",
             @"面对面快传",
             @"收钱"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
