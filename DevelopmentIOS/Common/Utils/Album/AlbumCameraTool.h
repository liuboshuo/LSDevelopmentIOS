//
//  UIImagePickerControllerTool.h
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/27.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol AlbumCameraToolSelectImageDelegate  <NSObject>

@required
/**
 *  选择图片
 *
 *  @param image 选择的图片
 */
-(void)albumCameraTool:(UIImage *)image;
@optional

/**
 *  取消选择
 */
-(void)cancleSelect;

@end


/**
 *  从底部弹出ActionSheet选择从图库选择图片或者相机拍照图片
 
 在控制器设置属性
 [self.albumCameraTool open];
 
 -(AlbumCameraTool *)albumCameraTool
 {
 if (!_albumCameraTool) {
 _albumCameraTool = [[AlbumCameraTool alloc] initWithVc:self];
 _albumCameraTool .delegate = self;
 }
 return _albumCameraTool;
 }
 
 */
@interface AlbumCameraTool : NSObject

@property(nonatomic , assign)id<AlbumCameraToolSelectImageDelegate> delegate;


-(id)initWithVc:(UIViewController *)vc;


/**
 *  弹出选择框
 */
-(void)open;


@end
