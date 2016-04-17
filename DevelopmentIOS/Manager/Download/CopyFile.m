
//
//  CopyFile.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/16.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "CopyFile.h"

@implementation CopyFile

-(void)doCopy
{
    NSString *tagPath = self.desPath;
    NSFileManager *manger = [NSFileManager defaultManager];
    NSFileHandle *inFile = [NSFileHandle fileHandleForReadingAtPath:self.srcPath];
    
    NSFileHandle *outFile = [NSFileHandle fileHandleForWritingAtPath:tagPath];
    NSDictionary *fileAttri = [manger attributesOfItemAtPath:self.srcPath error:nil];
    
    NSNumber *fileSize = [fileAttri objectForKey:NSFileSize];
    NSInteger size = [fileSize longValue];
    NSInteger readSize = 0;
    
    BOOL end = YES;
    
    while (end) {
        NSInteger sub = size - readSize;
        NSData *data = nil;
        if(sub < 500){
            end = NO;
            data = [inFile readDataToEndOfFile];
        }else{
            data = [inFile readDataOfLength:500];
            readSize += 500;
            [inFile seekToFileOffset:readSize];
        }
        [outFile writeData:data];
    }
    [outFile closeFile];
    [inFile closeFile];
}
@end
