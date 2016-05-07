
//
//  RootViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/13.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "RootViewController.h"
#import "LSDevelopmetIOS.h"
#import "LSTableViewCellViewController.h"
#import "LSBigImageShowViewController.h"
#import "LeftMenuView.h"
#import "QRScannerCodeTest.h"
#import "AlbumToolTest.h"
#import "TableViewCellModel.h"
#import "AlertViewTest.h"
#import "PlaySoundAndMusicTest.h"
#import "NetWorkTest.h"
#import "LocationTest.h"
#import "HUDAndToastTest.h"
#import "LSNetWorkStatusTest.h"
#import "AdressBookViewController.h"
#import "ScrollViewTest.h"
#import "ProgressTest.h"
#import "PopMenuViewTest.h"
#import "CoreTextTest.h"
#import "ProgressWebViewController.h"
#import "NotificationHubCountTest.h"
#import "LSVideoTest.h"


@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>

@property(nonatomic , strong)UITableView *tableView;

@property(nonatomic , strong)NSMutableArray *datas;



@end

@implementation RootViewController

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"测试";
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _tableView = tableView;
    //
    //    self.datas = @[@"图片点击放大效果",@"tableViewCell侧滑",@"皮肤和抽屉效果",@"皮肤和经典TabBar和导航效果",@"二维码",@"图片选择"];
    
    TableViewCellModel *BigImageShowViewController = [[TableViewCellModel alloc] initWithName:@"图片点击放大效果" className:[LSBigImageShowViewController class]];
    
    [self.datas addObject:BigImageShowViewController];
    
    
    TableViewCellModel *TableViewCellViewController = [[TableViewCellModel alloc] initWithName:@"tableViewCell侧滑（左滑）" className:[LSTableViewCellViewController class]];
    
    [self.datas addObject:TableViewCellViewController];
    
    
    
    TableViewCellModel *sideMenu = [[TableViewCellModel alloc] initWithName:@"皮肤和抽屉效果" className:[RESideMenu class] isSpector:YES];
    
    [self.datas addObject:sideMenu];
    
    
    
    TableViewCellModel *tabBar = [[TableViewCellModel alloc] initWithName:@"皮肤和经典TabBar和导航效果" className:[TabBarController class] isSpector:YES];
    
    [self.datas addObject:tabBar];
    
    
    TableViewCellModel *scannerCodeTest = [[TableViewCellModel alloc] initWithName:@"二维码视图" className:[QRScannerCodeTest class]];
    
    [self.datas addObject:scannerCodeTest];
    
    
    TableViewCellModel *albumToolTest = [[TableViewCellModel alloc] initWithName:@"图片选择" className:[AlbumToolTest class]];
    
    [self.datas addObject:albumToolTest];
    
    TableViewCellModel *alertView = [[TableViewCellModel alloc] initWithName:@"自定义图片弹出框图" className:[AlertViewTest class]];
    
    [self.datas addObject:alertView];
    
    TableViewCellModel *playSoun = [[TableViewCellModel alloc] initWithName:@"播放音效音乐Demo" className:[PlaySoundAndMusicTest class]];
    
    [self.datas addObject:playSoun];
    
    TableViewCellModel *networkTest = [[TableViewCellModel alloc] initWithName:@"网络请求的用法" className:[NetWorkTest class]];
    
    [self.datas addObject:networkTest];
    
    TableViewCellModel *locationTest = [[TableViewCellModel alloc] initWithName:@"定位" className:[LocationTest class]];
    [self.datas addObject:locationTest];
    
    
    TableViewCellModel *husdAndToastTest = [[TableViewCellModel alloc] initWithName:@"HUD等待，toast" className:[HUDAndToastTest class]];
    
    [self.datas addObject:husdAndToastTest];
    
    TableViewCellModel *networkStatusTest = [[TableViewCellModel alloc] initWithName:@"网络监听" className:[LSNetWorkStatusTest class]];
    
    [self.datas addObject:networkStatusTest];
    
    TableViewCellModel *adressBookTest = [[TableViewCellModel alloc] initWithName:@"通讯录Demo" className:[AdressBookViewController class]];
    [self.datas addObject:adressBookTest];
    
    TableViewCellModel *scrollViewTest = [[TableViewCellModel alloc] initWithName:@"轮播图" className:[ScrollViewTest class]];
    [self.datas addObject:scrollViewTest];
    
    TableViewCellModel *progressTest = [[TableViewCellModel alloc] initWithName:@"大文件单线程，多线程下载进度" className:[ProgressTest class]];
    [self.datas addObject:progressTest];
    
    TableViewCellModel *popMenuViewTest = [[TableViewCellModel alloc] initWithName:@"弹出式菜单" className:[PopMenuViewTest class]];
    [self.datas addObject:popMenuViewTest];
    
    TableViewCellModel *progressWebViewTest = [[TableViewCellModel alloc] initWithName:@"带进度条的网页" className:[ProgressWebViewController class]];
    [self.datas addObject:progressWebViewTest];
    
    TableViewCellModel *coreTextTest = [[TableViewCellModel alloc] initWithName:@"富文本" className:[CoreTextTest class]];
    [self.datas addObject:coreTextTest];
    
    TableViewCellModel *notificationHubTest = [[TableViewCellModel alloc] initWithName:@"未读消息数量" className:[NotificationHubCountTest class]];
    [self.datas addObject:notificationHubTest];
    
    TableViewCellModel *videoPalyTest = [[TableViewCellModel alloc] initWithName:@"视频播放" className:[LSVideoTest class]];
    [self.datas addObject:videoPalyTest];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor redColor]];
    
    [self setScrollVew:_tableView scrollOffsetY:200 options:HiddenControlOptionLeft];
}


-(NSMutableArray *)datas
{
    if (!_datas) {
        _datas = [NSMutableArray array];
    }
    return _datas;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _datas.count;
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellId = @"RootViewControllerTableViewCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = ((TableViewCellModel *)_datas[indexPath.row]).name;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    TableViewCellModel *model = _datas[indexPath.row];
    if (model.isSepctor) {
        if ([NSStringFromClass(model.className) isEqualToString:@"RESideMenu"]) {
            TabBarController *tab = [[TabBarController alloc] init];
            LeftMenuView  *leftMenuViewController = [[LeftMenuView alloc] init];
            RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:tab
                                                                            leftMenuViewController:leftMenuViewController
                                                                           rightMenuViewController:nil];
            sideMenuViewController.contentViewShadowOffset = CGSizeMake(0, 0);
            sideMenuViewController.contentViewShadowOpacity = 0.6;
            sideMenuViewController.contentViewShadowRadius = 12;
            sideMenuViewController.contentViewShadowEnabled = YES;
            sideMenuViewController.contentViewScaleValue = 1.0;
            [self presentViewController:sideMenuViewController animated:YES completion:nil];
        }else if([NSStringFromClass(model.className) isEqualToString:@"TabBarController"]){
            TabBarController *tab = [[TabBarController alloc] init];
            [self presentViewController:tab animated:YES completion:nil];
        }
    }else{
        UIViewController *ViewController = [[model.className alloc] init];
        [self.navigationController pushViewController:ViewController animated:YES];
    }
}

@end
