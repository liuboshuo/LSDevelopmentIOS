

//
//  LSTabBarController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/3/13.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "TabBarController.h"
#import "LSDevelopmetIOS.h"
@interface TabBarController ()


//当底部不是自定义


@end


@implementation TabBarController



#pragma mark view lifeCirlce

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    
    //    [NotificationCenter addObserver:self selector:@selector(refreshCurrentSkin:) name:LSNotificationRefreshAllSkin object:nil];
    
    [self initViewController];
    
    [self setSkin];
    
    self.delegate = self;
}
/**
 * 读取配置文件设置不同的控制器
 *
 *  @param count <#count description#>
 */
-(void)initViewController
{
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
                
                //设置属性
                vc.title = tabTitle;
                [vc.tabBarItem setImage:[UIImage imageNamed:normalImage]];
                [vc.tabBarItem setSelectedImage:[UIImage imageNamed:selectImage]];
                //添加子控制器
                [self addChildViewController:nav];
            }else{
                NSString *desc = [NSString stringWithFormat:@"不能找到%@这个",tabBarController];
                NSAssert([[[NSClassFromString(tabBarController) alloc] init] isKindOfClass:[UIViewController class]],desc);
#if DEBUG
                NSLog(@"不能找到%@这个类",tabBarController);
#else 
                
#endif
            }
        }
        
    }
}


-(void)refreshCurrentSkin:(NSNotification *)notification
{
    [self setSkin];
}

-(void)setSkin
{
    //    [self.tabBar setBarTintColor:[LSSkinMananger colorNamed:@"Nav_bg_Color"]];
    //    self.tabBar.tintColor = [LSSkinMananger colorNamed:@"Tab_title_Color"];
}
@end
