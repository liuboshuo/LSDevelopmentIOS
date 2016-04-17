//
//  UIImagePickerControllerTool.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/27.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "AlbumCameraTool.h"
#import "LSDevelopmetIOS.h"
@interface AlbumCameraTool ()<UIImagePickerControllerDelegate ,UINavigationControllerDelegate,UIActionSheetDelegate>

@property(nonatomic,strong)UIViewController *vc;

@end
@implementation AlbumCameraTool


-(void)open
{
    [self popToActionSheet];
}
-(id)initWithVc:(UIViewController *)vc
{
    if (self = [super init]) {
        _vc = vc;
    }
    return self;
}
-(void)popToActionSheet
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册",@"拍照", nil];
    [actionSheet showInView:self.vc.view];
    
}

//打开相机
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}
//打开相册集
- (void)openAlbum
{
    // 如果想自己写一个图片选择控制器，得利用AssetsLibrary.framework，利用这个框架可以获得手机上的所有相册图片
    // UIImagePickerControllerSourceTypePhotoLibrary > UIImagePickerControllerSourceTypeSavedPhotosAlbum
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}


-(void)actionSheetCancel:(UIActionSheet *)actionSheet
{
    if ([self.delegate respondsToSelector:@selector(cancleSelect)]) {
        [self.delegate cancleSelect];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *selectImage = info[UIImagePickerControllerOriginalImage];
    if ([_delegate respondsToSelector:@selector(albumCameraTool:)]) {
        [_delegate albumCameraTool:[selectImage fixOrientation]];
    }
    [_vc dismissViewControllerAnimated:YES completion:nil];
}
//打开
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    ipc.allowsEditing = YES;
    [_vc presentViewController:ipc animated:YES completion:nil];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self openAlbum];
            break;
        case 1:
            [self openCamera];
            break;
        default:
            break;
    }
}

@end
