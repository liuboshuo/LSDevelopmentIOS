//
//  ABPersonModel.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
@interface ABPerson : NSObject

@property(nonatomic , assign)ABRecordID personId;

@property(nonatomic , copy)NSString *name;

@property(nonatomic , copy)NSString *phone;


@property(nonatomic , strong)UIImage *image;

-(instancetype)initWithId:(ABRecordID)personId name:(NSString *)name  phone:(NSString *)phone image:(UIImage *)image;



@end
