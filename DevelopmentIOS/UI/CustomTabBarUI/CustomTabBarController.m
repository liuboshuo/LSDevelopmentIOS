//
//  SouctomTabBarController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/6/1.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "CustomTabBarController.h"
#import "LSTabBarItem.h"
#import "UIView+Extension.h"
#import "LSFirstViewController.h"
#import "NavigationController.h"
#import "LSSecondViewController.h"
#import "UIGloablConfig.h"
#import "LSSkinMananger.h"
@interface CustomTabBarController ()

@property(nonatomic , strong)UIImageView *tabBarView;

@property(nonatomic , strong)LSTabBarItem *previousBtn;

@end

@implementation CustomTabBarController

-(void)viewWillAppear:(BOOL)animated
{
    self.tabBar.hidden = YES;
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.hidden = YES;
    CGFloat tabbarViewY = self.view.height - 49;
    self.tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, tabbarViewY, self.view.width, 49)];
    _tabBarView.userInteractionEnabled = YES;
    NSString *imageName = [@"TabBarImages.bundle" stringByAppendingPathComponent:@"title_background"];
    _tabBarView.image = [UIImage imageWithContentsOfFile:imageName];
    _tabBarView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tabBarView];
    
    [self initViewController];
    // Do any additional setup after loading the view.
}
/**
 * 读取配置文件设置不同的控制器
 *
 *  @param count <#count description#>
 */
-(void)initViewController
{
    [NotificationCenter addObserver:self selector:@selector(refreshCurrentSkin:) name:LSNotificationRefreshAllSkin object:nil];
    //storyboard创建
    if (self.childViewControllers.count >0) {
#if DEBUG
        NSLog(@"该项目采用storyboard方式搭建");
#else
        
#endif
    }else{
        //读取
        NSDictionary *propertyConfigDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:LSUIPropertyConfigFile ofType:nil]];
        NSArray *tabBarPropertyConfig = propertyConfigDictionary[LSUITabBarUI];
        //读取UITabBarController 的childViewControllers的属性
        for (int i=0; i<tabBarPropertyConfig.count; i++) {
            
            NSDictionary *detailConfigDictionary = tabBarPropertyConfig[i];
            //正常图片
            NSString *normalImage = detailConfigDictionary[LSUITabBarUITabBarUIControllerNormalImage];
            //选中的图片
            NSString *selectImage = detailConfigDictionary[LSUITabBarUITabBarUIControllerSelectImage];
            //控制器
            NSString *tabBarController = detailConfigDictionary[LSUITabBarUITabBarUIController];
            //标题
            NSString *tabTitle = detailConfigDictionary[LSUITabBarUITabBarUIControllerShowTitle];
            
#if DEBUG
            NSLog(@"第%d个选项卡没有选中图片:%@",i+1,normalImage);
            NSLog(@"第%d个选项卡选中正常图片:%@",i+1,selectImage);
            NSLog(@"第%d个选项卡标题%@",i+1,tabTitle);
#else
            
#endif
            //判断是否可以转化
            if ([[[NSClassFromString(tabBarController) alloc] init] isKindOfClass:[UIViewController class]]) {
                //生成UIViewController
                UIViewController *vc= [[NSClassFromString(tabBarController) alloc] init];
                //设置控制器背景颜色
                
                //设置控制器的颜色
                //            vc.view.backgroundColor = [UIColor redColor];
                //配置导航
                NavigationController *nav = [[NavigationController alloc] initWithRootViewController:vc];
                [self addChildViewController:nav];
                //创建图片
                LSTabBarItem *customButton = [LSTabBarItem buttonWithType:UIButtonTypeCustom];
                customButton.tag = i;
                CGFloat w = self.view.width / tabBarPropertyConfig.count;
                CGFloat h = _tabBarView.height;
                customButton.frame = CGRectMake(w * i, 0, w, h);
                
                [customButton setImage:[UIImage imageNamed:normalImage] forState:UIControlStateNormal];
                [customButton setImage:[UIImage imageNamed:selectImage] forState:UIControlStateDisabled ];
                [customButton setTitle:tabTitle forState:UIControlStateNormal];
                [customButton addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchDown];
                customButton.imageView.contentMode = UIViewContentModeCenter;
                customButton.titleLabel.textAlignment = NSTextAlignmentCenter;
                if ([LSSkinMananger isUseSKin]) {
                    [customButton setTitleColor:[LSSkinMananger colorNamed:@"Tab_title_Select_Color"] forState:UIControlStateNormal];
                    [customButton setTitleColor:[ LSSkinMananger colorNamed:@"Tab_title_Color"] forState:UIControlStateDisabled];
                }else{
                    [customButton setTitleColor:[UIGloablConfig getCustomNormal] forState:UIControlStateNormal];
                    [customButton setTitleColor:[UIGloablConfig getCustomSelected] forState:UIControlStateDisabled];
                }
                [_tabBarView addSubview:customButton];
                //添加子控制器
            }else{
                NSString *desc = [NSString stringWithFormat:@"不能找到%@这个",tabBarController];
                NSAssert([[[NSClassFromString(tabBarController) alloc] init] isKindOfClass:[UIViewController class]],desc);
#if DEBUG
                NSLog(@"不能找到%@这个类",tabBarController);
#else
                
#endif
            }
        }
        LSTabBarItem *tabBarItem = _tabBarView.subviews[0];
        [self changeViewController:tabBarItem];
        
    }
}
-(void)refreshCurrentSkin:(NSNotification *)notification
{
    for (int i = 0; i<_tabBarView.subviews.count; i++) {
        UIView *view = _tabBarView.subviews[i];
        if ([view isKindOfClass:[LSTabBarItem class]]) {
            LSTabBarItem *but = (LSTabBarItem *)view;
            [but setTitleColor:[LSSkinMananger colorNamed:@"Tab_title_Select_Color"] forState:UIControlStateNormal];
            [but setTitleColor:[ LSSkinMananger colorNamed:@"Tab_title_Color"] forState:UIControlStateDisabled];
        }
    }
}
-(void)changeViewController:(LSTabBarItem *)button
{
    self.selectedIndex = button.tag;
    button.enabled = NO;
    if (_previousBtn != button) {
        _previousBtn.enabled = YES;
    }
    _previousBtn = button;
    self.selectedViewController = self.viewControllers[button.tag];
}
-(void)hidesBottomBarWhenPushed:(BOOL)hidesBottomBarWhenPushed
{
    if (!hidesBottomBarWhenPushed) {
        [UIView animateWithDuration:0.2 animations:^{
            _tabBarView.x = 0;
        } completion:^(BOOL finished) {
            _tabBarView.hidden = hidesBottomBarWhenPushed;
        }];
    }else{
        [UIView animateWithDuration:0.2 animations:^{
            _tabBarView.x = -self.view.width;
        } completion:^(BOOL finished) {
            _tabBarView.hidden = hidesBottomBarWhenPushed;
        }];
    }
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
