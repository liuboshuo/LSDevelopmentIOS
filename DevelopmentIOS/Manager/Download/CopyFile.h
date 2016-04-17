//
//  CopyFile.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/16.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CopyFile : NSObject

@property(nonatomic ,copy)NSString *srcPath;

@property(nonatomic , copy)NSString *desPath;

-(void)doCopy;

@end
