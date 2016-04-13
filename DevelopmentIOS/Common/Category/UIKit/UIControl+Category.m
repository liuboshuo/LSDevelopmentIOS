
//
//  UIControl+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "UIControl+Category.h"
#import <objc/runtime.h>

static const int block_key;

@interface UIControlBlockTarget : NSObject

@property (nonatomic , copy) void (^block)(id sender);
@property(nonatomic , assign)UIControlEvents events;
-(id)initWithBlock:(void(^)(id sender))block events:(UIControlEvents)events;
-(void)invoke:(id)sender;
@end

@implementation UIControlBlockTarget

-(id)initWithBlock:(void(^)(id sender))block events:(UIControlEvents)events
{
    if (self = [super init]) {
        _block = [block copy];
        _events = events;
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


@implementation UIControl (Category)

-(NSMutableArray *)allUIControBlock
{
    NSMutableArray *targets = objc_getAssociatedObject(self, &block_key);
    if (!targets) {
        targets = [NSMutableArray array];
        objc_setAssociatedObject(self, &block_key, targets, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targets;
}
-(void)removeAllTargets
{
    [[self allTargets] enumerateObjectsUsingBlock:^(id  _Nonnull obj, BOOL * _Nonnull stop) {
        [self removeTarget:obj action:NULL forControlEvents:UIControlEventAllEvents];
    }];
    [[self allUIControBlock] removeAllObjects];
}

-(void)setTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
{
    if (!target || !action || !controlEvents) {
        return;
    }
    NSSet *targets = [self allTargets];
    for (id currentTarget in targets) {
        NSArray *action = [self actionsForTarget:currentTarget forControlEvent:controlEvents];
        for (NSString *currentAction in action) {
            [self removeTarget:currentTarget action:NSSelectorFromString(currentAction) forControlEvents:controlEvents];
        }
    }
    [self addTarget:target action:action forControlEvents:controlEvents];
}

-(void)addBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id))block
{
    if (!controlEvents) {
        return;
    }
    UIControlBlockTarget *target = [[UIControlBlockTarget alloc] initWithBlock:block events:controlEvents];
    [self addTarget:target action:@selector(invoke:) forControlEvents:controlEvents];
    NSMutableArray *targets = [self allUIControBlock];
    [targets addObject:target];
}

-(void)setBlockForControlEvents:(UIControlEvents)controlEvents block:(void (^)(id))block
{
    [self removeAllBlocksForControlEvents:controlEvents];
    [self addBlockForControlEvents:controlEvents block:block];
}
-(void)removeAllBlocksForControlEvents:(UIControlEvents)controlEvents
{
    NSMutableArray *targets = [self allUIControBlock];
    NSMutableArray *removes = [NSMutableArray array];
    for (UIControlBlockTarget *target in targets) {
        
        if (target.events & controlEvents) {
            UIControlEvents new = target.events & (~controlEvents);
            if (new) {
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                target.events = new;
                [self addTarget:target action:@selector(invoke:) forControlEvents:target.events];
            }else{
                [self removeTarget:target action:@selector(invoke:) forControlEvents:target.events];
                [removes addObject:target];
            }
        }
    }
    [targets removeObjectsInArray:removes];
}
@end
