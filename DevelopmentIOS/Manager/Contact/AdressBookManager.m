//
//  AdressBookManager.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "AdressBookManager.h"


@interface AdressBookManager ()

@property(nonatomic , assign)BOOL grand;



@end
@implementation AdressBookManager


singletonImplementation(AdressBookManager);



-(void)getAdressBookOfAllPeople:(void (^)(NSMutableArray<ABPerson *> *peoples))adressBookBlock
{
    if (_addressBook == nil) {
        _addressBook = ABAddressBookCreateWithOptions(NULL, NULL);
    }
    if (self.grand) {
        adressBookBlock(_peoples);
    }else{
        [self checkAddressBookAccess:adressBookBlock];
    }
}


-(void)checkAddressBookAccess:(void (^)(NSMutableArray<ABPerson *> *peoples))adressBookBolck
{
    _AdressBookBlock = adressBookBolck;
    
    switch (ABAddressBookGetAuthorizationStatus()) {
        case kABAuthorizationStatusAuthorized:
        {
            _grand = YES;
            [self accessGrantedForAddressBook];
            break;
        }
        case kABAuthorizationStatusNotDetermined:
        {
            [self requestAddressBookAccess];
            break;
        }
        default:
            NSLog(@"没有访问通讯录权限");
            break;
    }
}

-(void)accessGrantedForAddressBook
{
    /**
     *  访问所有的联系人
     *
     *  @param addressBook#> <#addressBook#> description#>
     *
     *  @return <#return value description#>
     */
    CFIndex allPeopleCount = ABAddressBookGetPersonCount(_addressBook);
    CFArrayRef allRecords = ABAddressBookCopyArrayOfAllPeople(_addressBook);
    for (int i = 0; i<allPeopleCount; i++) {
        
        ABRecordRef person = CFArrayGetValueAtIndex(allRecords, i);
        
        
        ABPerson *person0 = [self getABPersonFromABRecordRef:person];
        
        [self.peoples addObject:person0];
    }
    self.AdressBookBlock(self.peoples);
}

-(void)requestAddressBookAccess
{
    ABAddressBookRequestAccessWithCompletion(_addressBook, ^(bool granted, CFErrorRef error) {
        if (granted) {
            _grand = YES;
            [self accessGrantedForAddressBook];
        }
    });
}

-(ABRecordRef)getABRecordFromABPerson:(ABPerson *)person
{
    return ABAddressBookGetPersonWithRecordID(_addressBook, person.personId);
}
-(ABPerson *)getABPersonFromABRecordRef:(ABRecordRef)person
{
    ABRecordID recordId = ABRecordGetRecordID(person);
    
    //联系人名称
    NSString *name = (__bridge NSString *)(ABRecordCopyCompositeName(person));
    
    
    ABMultiValueRef phoneRef = (ABRecordCopyValue(person, kABPersonPhoneProperty));
    //获取第一个
    NSString *phoneStr = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phoneRef, 0));
    if ([phoneStr hasPrefix:@"+"]) {
        phoneStr = [phoneStr substringFromIndex:3];
    }
    phoneStr = [phoneStr stringByReplacingOccurrencesOfString:@"-" withString:@""];
    
    //读取头像
    NSData *image = (__bridge NSData*)ABPersonCopyImageData(person);
    
    ABPerson *person0 = [[ABPerson alloc] init];
    person0.name = name;
    person0.phone = phoneStr;
    person0.personId = recordId;
    if (image != nil) {
        person0.image = [UIImage imageWithData:image];
    }
    return person0;
}
-(NSMutableArray<ABPerson *> *)peoples
{
    if (_peoples == nil) {
        _peoples = [NSMutableArray array];
    }
    return _peoples;
}




@end
