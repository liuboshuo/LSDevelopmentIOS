//
//  UIActionSheet+Block.h
//  AlertViewTest
//
//  Created by 刘硕 on 16/5/5.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIActionSheet (Block)<UIActionSheetDelegate>


@property(nonatomic , copy)void (^completion)(NSInteger index,UIActionSheet *actionSheet);


+(UIActionSheet *(^)())actionSheet;
-(UIActionSheet *(^)(NSString *))setTitle;
-(UIActionSheet *(^)(NSArray <NSString*> *))setTitles;
-(UIActionSheet *(^)(UIActionSheetStyle actionSheetStyle))setActionSheetStyle;
-(UIActionSheet *)addClickedButton:(void (^)(NSInteger index,UIActionSheet *actionSheet))didclicked;

@end
