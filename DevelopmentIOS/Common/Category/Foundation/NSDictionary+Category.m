//
//  NSDictionary+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NSDictionary+Category.h"

@implementation NSDictionary (Category)

-(NSData *)plistData
{
    return [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:kNilOptions error:NULL];
}
-(NSArray *)allKeysSorted
{
    return [[self allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
}

-(NSArray *)allValuesSortedByKeys
{
    NSArray *sortedKeys = [self allKeysSorted];
    NSMutableArray *arr = [NSMutableArray array];
    for (id key in sortedKeys) {
        [arr addObject:self[key]];
    }
    return [arr copy];
}

-(BOOL)containsObjectForKey:(id)key
{
    if (!key) {
        return NO;
    }
    return self[key] != nil;
}

-(NSString *)jsonStringEncoded
{
    if ( [NSJSONSerialization isValidJSONObject:self] ) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!error) {
            return json;
        }
    }
    return nil;
}


- (nullable NSString *)jsonPrettyStringEncoded
{
    if ([NSJSONSerialization isValidJSONObject:self]) {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:self options:0 error:&error];
        NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (!error) {
            return jsonString;
        }
    }
    return nil;
}
@end


@implementation NSMutableDictionary (Category)
-(id)popObjectForKey:(id)aKey
{
    if (!aKey) {
        return nil;
    }
    id value = self[aKey];
    [self removeObjectForKey:aKey];
    return value;
}
-(NSDictionary *)popEntriesForKeys:(NSArray *)keys
{
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    for(int i = 0; i<keys.count; i++)
    {
        id value = self[keys[i]];
        if (value) {
            [self removeObjectForKey:keys[i]];
            dic[keys[i]] = value;
        }
    }
    return [dic copy];
}

@end
