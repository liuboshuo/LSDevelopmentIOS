//
//  NSKeyedUnarchiver+Category.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/7.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "NSKeyedUnarchiver+Category.h"

@implementation NSKeyedUnarchiver (Category)

+(id)unarchiveObjectWithData:(NSData *)data exception:(NSException *__autoreleasing  _Nullable *)exception
{
    id object = nil;
    
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException *e) {
        if (exception) {
            *exception = e;
        }
    }
    return object;
}

+(id)unarchiveObjectWithFile:(NSString *)path exception:(NSException *__autoreleasing  _Nullable *)exception
{
    id object = nil;
    
    
    @try {
        object = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    @catch (NSException *e) {
        if (exception) {
            *exception = e;
        }
    }
    return object;
}
@end
