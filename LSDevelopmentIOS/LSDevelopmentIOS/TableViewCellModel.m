//
//  TableViewCellModel.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "TableViewCellModel.h"

@implementation TableViewCellModel


-(id)initWithName:(NSString *)functionName className:(Class)className isSpector:(BOOL)isSpector
{
    if (self = [super init]) {
        self.name = functionName;
        self.className = className;
        self.isSepctor = isSpector;
    }
    return self;
}

-(id)initWithName:(NSString *)functionName className:(Class)className
{
    return [self initWithName:functionName className:className isSpector:NO];
}
@end
