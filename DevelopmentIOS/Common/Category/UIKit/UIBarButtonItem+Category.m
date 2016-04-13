
//
//  UIBarButtonItem+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "UIBarButtonItem+Category.h"
#import <objc/runtime.h>

static const int block_key;

@interface UIBarButtonItemBlockTarget : NSObject

@property(nonatomic , copy) void (^block)(id sender) ;

-(id)initWithBlock:(void (^)(id sender))block;
-(void)invoke:(id)sender;


@end
@implementation UIBarButtonItemBlockTarget

-(id)initWithBlock:(void (^)(id))block
{
    if (self = [super init]) {
        _block = [block copy];
    }
    return self;
}

-(void)invoke:(id)sender
{
    if (_block) {
        _block(sender);
    }
}


@end
@implementation UIBarButtonItem (Category)

-(void)setBlock:(void (^)(id))block
{
    UIBarButtonItemBlockTarget *barButtonItem = [[UIBarButtonItemBlockTarget alloc] initWithBlock:block];
    objc_setAssociatedObject(self, &block_key, barButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self setTarget:barButtonItem];
    [self setAction:@selector(invoke:)];
}
-(void (^)(id))block
{
    UIBarButtonItemBlockTarget *target = objc_getAssociatedObject(self, &block_key);
    return target.block;
}
@end
