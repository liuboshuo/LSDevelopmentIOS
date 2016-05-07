
//
//  NSObject+Category.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/1/29.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "NSObject+Category.h"
#import <objc/runtime.h>

static const int block_key;

@interface NSObjectKVOBlockTarget : NSObject

@property(nonatomic , copy) void (^block)(__weak id obj , id oldValue , id newValue);

-(id)initWithBlock:(void(^)(__weak id obj , id oldValue , id newValue))block;


@end


@implementation NSObjectKVOBlockTarget

static const int *userInfoKey;

-(void)setUserInfo:(NSDictionary *)userInfo
{
    objc_setAssociatedObject(self, &userInfoKey, userInfo, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(NSDictionary *)userInfo
{
    return objc_getAssociatedObject(self, &userInfoKey);
}


-(id)initWithBlock:(void (^)(__weak id, id, id))block
{
    if (self = [super init]) {
        self.block = [block copy];
    }
    return self;
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    if (!self.block) {
        return;
    }
    BOOL isPrior = [[change objectForKey:NSKeyValueChangeNotificationIsPriorKey] boolValue];
    if (isPrior) {
        return;
    }
    NSKeyValueChange changeKind = [[change objectForKey:NSKeyValueChangeKindKey] integerValue];
    if (changeKind != NSKeyValueChangeSetting) {
        return;
    }
    
    id oldValue = [change objectForKey:NSKeyValueChangeOldKey];
    if (oldValue == [NSNull null]) {
        oldValue = nil;
    }
    id newValue = [change objectForKey:NSKeyValueChangeNewKey];
    if (newValue == [NSNull null]) {
        newValue = nil;
    }
    self.block(object , oldValue , newValue);
}
@end

@implementation NSObject (Category)


-(void)encodeWithCoder:(NSCoder *)aCoder
{
    unsigned count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar var = ivars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithFormat:@"%s",name];
        id value = [self valueForKeyPath:key];
        if (value == nil) {
            value = @"";
        }
        [aCoder encodeObject:value forKey:key];
    }
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    unsigned count = 0;
    Ivar *ivars = class_copyIvarList([self class], &count);
    for (int i=0; i<count; i++) {
        Ivar var = ivars[i];
        const char *name = ivar_getName(var);
        NSString *key = [NSString stringWithFormat:@"%s",name];
        id value = [aDecoder decodeObjectForKey:key];
        if (value != nil) {
            [self setValue:value forKey:key];
        }
    }
    return self;
}
+ (NSString *)className {
    return NSStringFromClass(self);
}

- (NSString *)className {
    return [NSString stringWithUTF8String:class_getName([self class])];
}
-(void)addObserverBlockForKeyPath:(NSString *)keyPath block:(void (^)(id _Nonnull, id _Nullable, id _Nullable))block
{
    if (!keyPath || ! block) {
        return;
    }
    
    NSObjectKVOBlockTarget *target = [[NSObjectKVOBlockTarget alloc] initWithBlock:block];
    NSMutableDictionary *dic = [self allNSObjectKVOBlockTargets];
    NSMutableArray *arr = dic[keyPath];
    if (!arr) {
        arr = [NSMutableArray array];
        dic[keyPath] = arr;
    }
    [arr addObject:target];
    [self addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
}

-(void)removeObserverBlocksForKeyPath:(NSString *)keyPath
{
    if (!keyPath) {
        return;
    }
    NSMutableDictionary *dic = [self allNSObjectKVOBlockTargets];
    NSMutableArray *arr = dic[keyPath];
    [arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self removeObserver:obj forKeyPath:keyPath];
    }];
}
-(void)removeObserverBlocks
{
    NSMutableDictionary *dic = [self allNSObjectKVOBlockTargets];
    [dic enumerateKeysAndObjectsUsingBlock:^(NSString  *key, NSArray *value, BOOL * _Nonnull stop) {
        [value enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self removeObserver:obj forKeyPath:key];
        }];
    }];
    [dic removeAllObjects];
}
-(NSMutableDictionary *)allNSObjectKVOBlockTargets
{
    NSMutableDictionary *targtes = objc_getAssociatedObject(self, &block_key);
    if (!targtes) {
        targtes = [NSMutableDictionary new];
        objc_setAssociatedObject(self, &block_key, targtes, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return targtes;
}

@end
