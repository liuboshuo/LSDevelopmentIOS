//
//  AdressBookViewController.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/14.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "AdressBookViewController.h"
#import "LSDevelopmetIOS.h"
#import <AddressBookUI/AddressBookUI.h>
#import <AddressBook/AddressBook.h>
#import "AdressBookManager.h"

@interface AdressBookViewController ()<ABPeoplePickerNavigationControllerDelegate , ABPersonViewControllerDelegate,ABNewPersonViewControllerDelegate,UITableViewDataSource,UITableViewDelegate>

@property(nonatomic , strong)UITableView *tableView;
@property(nonatomic , strong)NSMutableArray<ABPerson *> *arrays;

@property(nonatomic , strong)OrderedDictionaryOC *datas;


@end

@implementation AdressBookViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [self rightButtonItemWithTitle:@"打开通讯录"];
    
    [[AdressBookManager sharedAdressBookManager] getAdressBookOfAllPeople:^(NSMutableArray<ABPerson *> *peoples) {
        NSLog(@"%@",peoples);
        self.arrays = peoples;
        
        _datas = [[OrderedDictionaryOC alloc] initWithKeys:self.arrays sel:@selector(name)];
        
        [self.tableView reloadData];
    }];
    
    if (iOS7) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    _tableView = tableView;
}
#pragma mark tableView的代理


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _datas.keysArr.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSArray *key = [_datas valueWithIndex:section];
    return key.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *AdressBookCellId = @"AdressBookCellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AdressBookCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:AdressBookCellId];
    }
    
    NSArray *values = [_datas valueWithIndex:indexPath.section];
    
    ABPerson *person = values[indexPath.row];
    cell.textLabel.text = person.name;
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    return _datas.keysArr[section];
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *values = [_datas valueWithIndex:indexPath.section];
    
    /**
     *  查看联系人详细信息
     */
    ABPerson *person = values[indexPath.row];
    ABPersonViewController *personViewController = [[ABPersonViewController alloc] init];
    personViewController.displayedPerson = [[AdressBookManager sharedAdressBookManager] getABRecordFromABPerson:person];
    personViewController.allowsEditing = YES;
    [self.navigationController pushViewController:personViewController animated:YES];
}
#pragma mark 通讯录的 delegate
/**
 *  取消
 *
 *  @param peoplePicker <#peoplePicker description#>
 */
-(void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker
{
    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
}




/**
 *  ios8
 *   选择phone的dismissViewController的回调
 */
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone, identifier);
    NSString *phoneNo = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phone, index));
    if ([phoneNo hasPrefix:@"+"]) {
        phoneNo = [phoneNo substringFromIndex:3];
    }
    phoneNo = [phoneNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@",phoneNo);
    ABPerson *person0 = [[AdressBookManager sharedAdressBookManager] getABPersonFromABRecordRef:person];
    [self.datas inserValue:person0];
    [self.tableView reloadData];
}

/**
 *  选择联系人的回调
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 */
-(void)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker didSelectPerson:(ABRecordRef)person
{
    ABPersonViewController *personViewController = [[ABPersonViewController alloc ] init];
    personViewController.displayedPerson = person;
    [peoplePicker pushViewController:personViewController animated:YES];
}



-(BOOL)personViewController:(ABPersonViewController *)personViewController shouldPerformDefaultActionForPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    return YES;
}


//新建完成
-(void)newPersonViewController:(ABNewPersonViewController *)newPersonView didCompleteWithNewPerson:(ABRecordRef)person
{
    NSLog(@"%s,%@",__func__ , person);
    [newPersonView dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  ios7
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 */
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person
{
    return YES;
}

/**
 *  选择phone的dismissViewController的回调  YES是dismiss  NO是不去dismiss
 *
 *  @param peoplePicker <#peoplePicker description#>
 *  @param person       <#person description#>
 *  @param property     <#property description#>
 *  @param identifier   <#identifier description#>
 *
 *  @return <#return value description#>
 */
-(BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier
{
    ABMultiValueRef phone = ABRecordCopyValue(person, kABPersonPhoneProperty);
    long index = ABMultiValueGetIndexForIdentifier(phone, identifier);
    NSString *phoneNo = (__bridge NSString *)(ABMultiValueCopyValueAtIndex(phone, index));
    if ([phoneNo hasPrefix:@"+"]) {
        phoneNo = [phoneNo substringFromIndex:3];
    }
    phoneNo = [phoneNo stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSLog(@"%@",phoneNo);
    
    ABPerson *person0 = [[AdressBookManager sharedAdressBookManager] getABPersonFromABRecordRef:person];
    [self.datas inserValue:person0];
    [self.tableView reloadData];
    //    [peoplePicker dismissViewControllerAnimated:YES completion:nil];
    return YES;
}

-(void)righBtnClick:(UIBarButtonItem *)rightButtonItem
{
    
    /**
     通讯录
     */
    ABPeoplePickerNavigationController *abPeoplePicker = [[ABPeoplePickerNavigationController alloc] init];
    abPeoplePicker.peoplePickerDelegate = self;
    if (iOS8) {
        //允许点击查看详情
        abPeoplePicker.predicateForSelectionOfPerson = [NSPredicate predicateWithValue:false];
    }
    [self presentViewController:abPeoplePicker animated:YES completion:nil];
}
/**
 *  懒加载
 *
 *  @return <#return value description#>
 */
-(NSMutableArray<ABPerson *> *)arrays
{
    if (_arrays == nil) {
        _arrays = [NSMutableArray array];
    }
    return _arrays;
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
