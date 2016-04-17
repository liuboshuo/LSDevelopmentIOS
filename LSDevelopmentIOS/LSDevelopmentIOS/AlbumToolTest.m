//
//  AlbumToolTest.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "AlbumToolTest.h"
#import "LSDevelopmetIOS.h"
@interface AlbumToolTest ()<AlbumCameraToolSelectImageDelegate>

@property(nonatomic , strong)AlbumCameraTool *albumCameraTool;

@property(nonatomic , strong)UIImageView *imageView;


@property(nonatomic , strong)ZLPhotoActionSheet *actionSheet;


@property(nonatomic , strong)NSMutableArray *images;



@property(nonatomic , weak)UIView *containView;


@end

@implementation AlbumToolTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //图片
    
    
    UIView *containView = [[UIView alloc] init];
    containView.frame = CGRectMake(0, 200, UIScreenWidth, UIScreenHeight - 264);
    [self.view addSubview:containView];
    self.containView = containView;
    UIButton *button = [[UIButton alloc] init];
    [button setTitle:@"选择单张图片" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = CGRectMake(20, 100, 150, 50);
    [self albumCameraTool];
    [button addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [self.albumCameraTool open];
    }];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] init];
    [button1 setTitle:@"选择多张图片" forState:UIControlStateNormal];
    [button1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button1.frame = CGRectMake(200, 100, 150, 50);
    self.actionSheet = [[ZLPhotoActionSheet alloc] init];
    _actionSheet.maxPreviewCount = 5;
    [button1 addBlockForControlEvents:UIControlEventTouchUpInside block:^(id sender) {
        [_actionSheet showWithSender:self animate:YES completion:^(NSArray<UIImage *> * _Nonnull selectPhotos) {
            
            
            [self.containView removeAllSubviews];
            int rowCount = 3;
            
            CGFloat padding = 10;
            
            CGFloat w = UIScreenWidth / rowCount;
            CGFloat h = 110;
            for (int i= 0; i<selectPhotos.count; i++) {
                UIImageView *imageView = [[UIImageView alloc] initWithImage:selectPhotos[i]];
                imageView.x = (i % rowCount) * ( padding + w);
                imageView.width = w;
                imageView.height = h;
                imageView.y = (i / rowCount) * (padding + h);
                [self.containView addSubview:imageView];
            }
            
        }];
    }];
    [self.view addSubview:button1];
    
    
}



-(void)albumCameraTool:(UIImage *)image
{
    [self.containView removeAllSubviews];
    
    NSMutableArray *selectPhotos = [NSMutableArray arrayWithObject:image];
    int rowCount = 3;
    
    CGFloat padding = 10;
    
    CGFloat w = UIScreenWidth / rowCount;
    CGFloat h = 110;
    for (int i= 0; i<selectPhotos.count; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:selectPhotos[i]];
        imageView.x = (i % rowCount) * ( padding + w);
        imageView.width = w;
        imageView.height = h;
        imageView.y = (i / rowCount) * (padding + h);
        [self.containView addSubview:imageView];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(AlbumCameraTool *)albumCameraTool
{
    if (!_albumCameraTool) {
        _albumCameraTool = [[AlbumCameraTool alloc] initWithVc:self];
        _albumCameraTool .delegate = self;
    }
    return _albumCameraTool;
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
