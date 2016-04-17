//
//  LSBigImageShowViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSBigImageShowViewController.h"
#import "LSDevelopmetIOS.h"
#import "UIImageView+WebCache.h"
@interface LSBigImageShowViewController ()

@end

@implementation LSBigImageShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        self.edgesForExtendedLayout =UIRectEdgeNone;
    }
    //图片
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.width = 120;
    imageView.height = 200;
    imageView.x = 100;
    imageView.y = 64;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGesturecognizer = [[UITapGestureRecognizer alloc] init];
    [tapGesturecognizer addActionBlock:^(id sender) {
        ShowBigImageView *showBigImageView = [[ShowBigImageView alloc] initWithFrame:UICurrentWindow.bounds];
        //小图必须
        showBigImageView.smallImageView = imageView;
        showBigImageView.bigImageIcon = @"http://121.196.228.152/image/6919620160407185559042.jpg";
        [UICurrentWindow addSubview:showBigImageView];
        
    }];
    [imageView addGestureRecognizer:tapGesturecognizer];
    [imageView sd_setImageWithURL:[NSURL URLWithString:@"http://121.196.228.152/image/6919620160407185559042SA.jpg"]];
    [self.view addSubview:imageView];
    
    
    //gif
    UIImageView *imageGif = [[UIImageView alloc] init];
    imageGif.frame = CGRectMake(120, 300, 120, 70);
    imageGif.userInteractionEnabled = YES;
    [self.view addSubview:imageGif];
    UITapGestureRecognizer *tapGesturecognizerImageGif = [[UITapGestureRecognizer alloc] init];
    [tapGesturecognizerImageGif addActionBlock:^(id sender) {
        ShowBigImageView *showBigImageView = [[ShowBigImageView alloc] initWithFrame:UICurrentWindow.bounds];
        //小图
        showBigImageView.smallImageView = imageGif;
        showBigImageView.bigImageIcon = @"http://ww2.sinaimg.cn/large/85cccab3tw1esjq9r0pcpg20d3086qtr.jpg";
        [UICurrentWindow addSubview:showBigImageView];
        
    }];
    [imageGif addGestureRecognizer:tapGesturecognizerImageGif];
    [imageGif sd_setImageWithURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/large/85cccab3tw1esjq9r0pcpg20d3086qtr.jpg"]];
    
    
    //    imageGif.image = [UIImage imageWithSmallGIFData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/large/85cccab3tw1esjq9r0pcpg20d3086qtr.jpg"]] scale:1];
    
    
    
    
    //
    // Do any additional setup after loading the view.
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
