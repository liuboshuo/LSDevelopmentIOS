//
//  TableViewCellModel.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableViewCellModel : NSObject

@property(nonatomic , copy)NSString *name;

@property(nonatomic , assign)Class className;

@property(nonatomic , assign)BOOL isSepctor;
-(id)initWithName:(NSString *)functionName className:(Class)className;
-(id)initWithName:(NSString *)functionName className:(Class)className isSpector:(BOOL)isSpector;
@end
