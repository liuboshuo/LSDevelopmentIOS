

//
//  UIGestureRecognizer+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "UIGestureRecognizer+Category.h"
#import <objc/runtime.h>

static const int block_key;
@interface UIGestureRecognizerBlock : NSObject

@property(nonatomic , copy) void (^block)(id sender);
-(id)initWithBlock: (void(^)(id sender))block;
-(void)invoke:(id)sender;
@end
@implementation UIGestureRecognizerBlock

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
@implementation UIGestureRecognizer (Category)
-(instancetype)initWithActionBlock:(void (^)(id))block
{
    if (self = [super init]) {
        [self addActionBlock:block];
    }
    return self;
}
-(void)addActionBlock:(void (^)(id))block
{
    UIGestureRecognizerBlock *target = [[UIGestureRecognizerBlock alloc] initWithBlock:block];
    [self addTarget:target action:@selector(invoke:)];
    NSMutableArray *targets = [self allBlockTarget];
    [targets addObject:target];
}
-(void)removeAllActionBlocks
{
    NSMutableArray *targets = [self allBlockTarget];
    [targets enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeTarget:obj action:@selector(invoke:)];
    }];
    [targets removeAllObjects];
}
-(NSMutableArray *)allBlockTarget
{
    NSMutableArray *target = objc_getAssociatedObject(self, &block_key);
    if (!target) {
        target = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, target, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return target;
}
@end
