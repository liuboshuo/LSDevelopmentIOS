//
//  OrderedDictionaryOC.m
//  besttoneMobile
//
//  Created by 刘硕 on 15/9/4.
//  Copyright (c) 2015年 Besttone. All rights reserved.
//

#import "OrderedDictionaryOC.h"
#import <UIKit/UIKit.h>

@interface OrderedDictionaryOC ()

@property(nonatomic , assign)SEL selector;


@property(nonatomic , strong)NSMutableArray *values;


@end

@implementation OrderedDictionaryOC


-(instancetype)initWithKeys:(NSArray *)objects sel:(SEL)selector
{
    if (self = [super init]) {
        
        _selector = selector;
        
        _values = objects;
        
        
        UILocalizedIndexedCollation *index = [UILocalizedIndexedCollation currentCollation];
        NSArray *titles = [index sectionTitles];
        self.keysArr = [NSMutableArray array];
        [self.keysArr addObjectsFromArray:titles];
        
        
        self.valuesDictionary = [NSMutableDictionary dictionary];
        
        for (int i = 0; i < titles.count; i++) {
            NSString *ti = titles[i];
            self.valuesDictionary[ti] = [NSMutableArray array];
        }
        
        
        for (int i = 0; i<objects.count; i++) {
            NSInteger k = [index sectionForObject:objects[i] collationStringSelector:selector];
            char ch = k + (int)'A';
            NSString *st = [NSString stringWithFormat:@"%c",ch];
            NSMutableArray *a = (NSMutableArray *)self.valuesDictionary[st];
            [a addObject:objects[i]];
        }
        
        for (int i = 0; i<self.keysArr.count; i++) {
            NSArray *value = self.valuesDictionary[self.keysArr[i]];
            self.valuesDictionary[self.keysArr[i]] =  [NSMutableArray arrayWithArray:[index sortedArrayFromArray:value collationStringSelector:selector]];
        }
        
        
        for (int i = 0; i<self.valuesDictionary.count; i++) {
            NSString *key = self.keysArr[i];
            NSArray *value = self.valuesDictionary[key];
            if (value.count == 0) {
                [self removeWithIndex:i];
                i--;
            }
        }
    }
    
    return  self;
}


-(NSArray *)valueWithIndex:(NSInteger)index
{
    NSString *key = self.keysArr[index];
    return self.valuesDictionary[key];
}

-(void)insertWithValue:(id)value key:(id)key index:(int)index
{
    int temp = index;
    
    id tempvalue = self.valuesDictionary[key];
    if (tempvalue != nil) {
        int exitI = [self.keysArr indexOfObject:key];
        if (exitI < index) {
            temp --;
        }
        [self.keysArr removeObjectAtIndex:exitI];
    }
    
    [self.keysArr insertObject:key atIndex:temp];
    self.valuesDictionary[key] = value;
    
}

-(void)removeWithIndex:(int)index
{
    id key = self.keysArr[index];
    [self.keysArr removeObjectAtIndex:index];
    [self.valuesDictionary removeObjectForKey:key];
}

-(void)inserValue:(id)value
{
    UILocalizedIndexedCollation *index = [UILocalizedIndexedCollation currentCollation];
    
    NSInteger k = [index sectionForObject:value collationStringSelector:_selector];
    char ch = k + (int)'A';
    NSString *st = [NSString stringWithFormat:@"%c",ch];
    
    if (![self.keysArr containsObject:st]) {
        NSMutableArray *array = [NSMutableArray array];
        self.valuesDictionary[st] = array;
        [array addObject:value];
        [self.keysArr addObject:st];
        [self.keysArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            return [obj1 compare:obj2];
        }];
    }else{
        NSMutableArray *values = self.valuesDictionary[st];
        [values addObject:value];
        values = [NSMutableArray arrayWithArray:[index sortedArrayFromArray:values collationStringSelector:_selector]];
    }
}
@end
