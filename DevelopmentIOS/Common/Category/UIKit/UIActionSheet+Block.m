//
//  UIActionSheet+Block.m
//  AlertViewTest
//
//  Created by 刘硕 on 16/5/5.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "UIActionSheet+Block.h"
#import <objc/runtime.h>
@implementation UIActionSheet (Block)

static const int *completionBlock;

-(void)setCompletion:(void (^)(NSInteger, UIActionSheet *))completion
{
    objc_setAssociatedObject(self, &completionBlock, completion, OBJC_ASSOCIATION_COPY_NONATOMIC);
}


+(UIActionSheet *(^)())actionSheet
{
    
    return  ^UIActionSheet *(){
        
        return [[UIActionSheet alloc] init];
    };
}


-(void (^)(NSInteger, UIActionSheet *))completion
{
    return objc_getAssociatedObject(self, &completionBlock);
}






-(UIActionSheet *(^)(NSString *))setTitle
{
    
    return ^UIActionSheet *(NSString *message) {
        
        self.title = message;
        
        return self;
    };
}

-(UIActionSheet *(^)(NSArray<NSString *> *))setTitles
{
    return ^UIActionSheet *(NSArray<NSString *> *titles){
        
        for (NSInteger i = titles.count - 1; i>=0; i--) {
            NSString *title = titles[i];
            [self addButtonWithTitle:title];
        }
        return self;
    };
}

-(UIActionSheet *(^)(UIActionSheetStyle))setActionSheetStyle
{
    return ^UIActionSheet *(UIActionSheetStyle actionSheetStyle){
        
        self.actionSheetStyle = actionSheetStyle;
        return self;
    };
    
}
-(UIActionSheet *)addClickedButton:(void (^)(NSInteger index,UIActionSheet *actionSheet))didclicked
{
    self.delegate = self;
    self.completion = didclicked;
    return self;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.completion) {
        self.completion(buttonIndex,self);
    }
}
@end
