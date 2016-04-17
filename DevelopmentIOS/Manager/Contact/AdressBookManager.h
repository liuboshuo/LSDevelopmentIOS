//
//  AdressBookManager.h
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AddressBook/AddressBook.h>
#import "ABPerson.h"
#import "SingletonTemplate.h"
#import "ChineseToPinyin.h"

@interface AdressBookManager : NSObject{
    
    ABAddressBookRef _addressBook;
    
}

singletonInterface(AdressBookManager);

@property(nonatomic, copy) void (^AdressBookBlock)(NSMutableArray<ABPerson *>*persons);

@property(nonatomic , strong)NSMutableArray<ABPerson *> *peoples;


-(void)getAdressBookOfAllPeople:(void (^)(NSMutableArray<ABPerson *> *peoples))adressBookBlock;


-(ABRecordRef)getABRecordFromABPerson:(ABPerson *)person;

-(ABPerson *)getABPersonFromABRecordRef:(ABRecordRef)abRecordRef;

@end
