
//
//  LSNavigationController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/13.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NavigationController.h"
#import "LSDevelopmetIOS.h"
#import "UIGloablConfig.h"
#import "CustomTabBarController.h"
#import "TabBarController.h"
@interface NavigationController ()<UINavigationControllerDelegate>

@property(nonatomic , assign)BOOL enableRightGesture;

@end

@implementation NavigationController


-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.enableRightGesture = YES;
    self.interactivePopGestureRecognizer.delegate = self;
    self.delegate = self;
    
    [NotificationCenter addObserver:self selector:@selector(refreshCurrentSkin:) name:LSNotificationRefreshAllSkin object:nil];
    [self setSkin];
}

-(void)dealloc
{
    [NotificationCenter removeObserver:self];
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    //如果大于一隐藏底部选项卡
    if (self.viewControllers.count) {
        if ([self.parentViewController isKindOfClass:[TabBarController class]]) {
            viewController.hidesBottomBarWhenPushed = YES;
        }else if ([self.parentViewController isKindOfClass:[CustomTabBarController class]]) {
            CustomTabBarController *tab = (CustomTabBarController *)self.parentViewController;
            if (self.viewControllers.count == 1) {
                [tab hidesBottomBarWhenPushed:YES];
            }
        }
        //        viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    }
    
    //    
    //    if ([viewController isKindOfClass:[CommonViewController class]]) {
    //        if ([viewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
    //            CommonViewController *vc = (CommonViewController *)viewController;
    //            self.enableRightGesture = [vc gestureRecognizerShouldBegin];
    //        }
    //        
    //    }
    //    //统一设置返回按钮
    //    viewController.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    [super pushViewController:viewController animated:YES];
}

-(UIViewController *)popViewControllerAnimated:(BOOL)animated
{
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    return viewController;
}
-(void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if ([self.parentViewController isKindOfClass:[CustomTabBarController class]]) {
        CustomTabBarController *tab = (CustomTabBarController *)self.parentViewController;
        if (self.viewControllers.count == 1){
            [tab hidesBottomBarWhenPushed:NO];
        }
    }
}
-(void)refreshCurrentSkin:(NSNotification *)notification
{
    [self setSkin];
}


//-(BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
//{
//    //    if ([self.topViewController isKindOfClass:[CommonViewController class]]) {
//    //        if ([self.topViewController respondsToSelector:@selector(gestureRecognizerShouldBegin:)]) {
//    //            CommonViewController *vc = (CommonViewController *)self.topViewController;
//    //            self.enableRightGesture = [vc gestureRecognizerShouldBegin];
//    //        }
//    //    }
//    return YES;
//}
-(void)setSkin
{
    if ([LSSkinMananger isUseSKin]) {
        [self.navigationBar setBarTintColor:[LSSkinMananger colorNamed:@"Nav_bg_Color"]];
        self.navigationBar.tintColor = [LSSkinMananger colorNamed:@"Nav_title_Color"];
        [self.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[LSSkinMananger colorNamed:@"Nav_title_Color"],NSForegroundColorAttributeName,nil]];
    }else{
        [UIGloablConfig configNavigationBar];
    }
    if ([[UIDevice currentDevice].systemVersion doubleValue] >= 8.0) {
        self.navigationBar.translucent = NO;
        [self.navigationBar setBackgroundImage:[UIImage new] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    }
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.shadowImage = [[UIImage alloc] init];
}
@end
