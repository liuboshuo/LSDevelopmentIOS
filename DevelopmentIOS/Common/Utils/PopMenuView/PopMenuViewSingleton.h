//
//  PopMenuViewSingleton.h
//  TestPopView
//
//  Created by 刘硕 on 16/4/18.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PopMenuViewSingleton : NSObject
+(PopMenuViewSingleton *)sharePopMenuViewSingleton;

/** 创建一个弹出菜单
 *
 * @param frame 视图尺寸
 * @param titles 文字
 * @param images 图片
 * @param action 回调点击方法
 */
- (void) showPopMenuSelecteWithFrame:(CGSize)size
                                item:(NSArray *)item
                              action:(void(^)(NSIndexPath *indexPath))action from:(UIView *)from;
-(void)hideMenu;
@end
