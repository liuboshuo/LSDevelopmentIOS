//
//  ABPersonModel.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "ABPerson.h"

@implementation ABPerson


-(instancetype)initWithId:(ABRecordID)personId name:(NSString *)name phone:(NSString *)phone image:(UIImage *)image
{
    if (self = [super init]) {
        _personId = personId;
        _phone = phone;
        _name = name;
        _image = image;
    }
    return self;
}

-(NSString *)description
{
    NSString *description = [NSString stringWithFormat:@"名字:%@--电话:%@",self.name,self.phone];
    return description;
}
@end
