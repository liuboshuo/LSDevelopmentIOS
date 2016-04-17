
//
//  ScrollViewTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "ScrollViewTest.h"
#import "LSDevelopmetIOS.h"
@interface ScrollViewTest ()<ScrollViewNetDelegate , ScrollViewLocalDelegate>

@property(nonatomic , strong)NSArray *netImagesName;

@property(nonatomic , strong)NSArray *localImagesName;
@end

@implementation ScrollViewTest
-(NSArray *)netImagesName
{
    if (!_netImagesName) {
        _netImagesName = @[@"http://ws.xzhushou.cn/focusimg/201508201549023.jpg",@"http://ws.xzhushou.cn/focusimg/52.jpg",@"http://ws.xzhushou.cn/focusimg/51.jpg",@"http://ws.xzhushou.cn/focusimg/50.jpg"];
    }
    return _netImagesName;
}
-(NSArray *)localImagesName
{
    if (!_localImagesName) {
        _localImagesName = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    }
    return _localImagesName;
}

-(void)createNetScrollView
{
    LSInfiniteScrollView *scroll = [[LSInfiniteScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200) netURLs:self.netImagesName];
    scroll.autoScrollDelay = 3;
    scroll.netDelegate = self;
    [self.view addSubview:scroll];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [self createNetScrollView];
    
    
    
}

-(void)didSelectNetImageAtIndex:(NSInteger)idex
{
    NSLog(@"%d",idex);
}


-(void)didSelectLocalImageAtIndex:(NSInteger)idex
{
    NSLog(@"%d",idex);
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
