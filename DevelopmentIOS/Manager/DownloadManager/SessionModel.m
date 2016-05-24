//
//  SessionModel.m
//  DownManagerDemo
//
//  Created by 刘硕 on 16/5/6.
//  Copyright © 2016年 刘硕. All rights reserved.
//

#import "SessionModel.h"

@implementation SessionModel

-(float)calculateFileSizeInUnit:(unsigned long long)contentLength
{
    if (contentLength >= pow(1024, 3)) {
        return (float)(contentLength / (float)pow(1024, 3));
    }else if (contentLength >= pow(1024, 2)){
        return (float)(contentLength / (float)pow(1024, 2));
    }else if (contentLength >= pow(1024, 1)){
        return (float)(contentLength / (float)pow(1024, 1));
    }else{
        return (float)contentLength;
    }
}
-(NSString *)calculateUint:(unsigned long long)contentLength
{
    if (contentLength >= pow(1024, 3)) {
        return @"GB";
    }else if (contentLength >= pow(1024, 2)){
        return @"MB";
    }else if (contentLength >= 1024){
        return @"KB";
    }else{
        return @"B";
    }
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.url forKey:@"url"];
    [aCoder encodeObject:self.filename forKey:@"filename"];
    [aCoder encodeInteger:self.totalLength forKey:@"totalLength"];
    [aCoder encodeObject:self.totalSize forKey:@"totalSize"];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if ( self = [super init] ) {
        self.url = [aDecoder decodeObjectForKey:@"url"];
        self.filename = [aDecoder decodeObjectForKey:@"filename"];
        self.totalLength = [aDecoder decodeIntegerForKey:@"totalLength"];
        self.totalSize = [aDecoder decodeObjectForKey:@"totalSize"];
    }
    return self;
}
@end
