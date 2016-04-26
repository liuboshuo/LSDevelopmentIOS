//
//  CoreTextText.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/22.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "CoreTextTest.h"
#import "LSSecondViewController.h"
#import "LSDevelopmetIOS.h"
@interface CoreTextTest ()<TTTAttributedLabelDelegate>

@end

@implementation CoreTextTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    TTTAttributedLabel *label = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 95, self.view.bounds.size.width, 40)];
    label.numberOfLines = 0;
    [self.view addSubview:label];
    
    label.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    label.delegate = self;
    
    label.text = @"Fork me on GitHub";
    
    NSRange range = [label.text rangeOfString:@"me"];
    [label addLinkToURL:[NSURL URLWithString:@"http://github.com/liuboshuo"] withRange:range];
    
    
    
    
    TTTAttributedLabel *label1 = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 145, self.view.bounds.size.width, 40)];
    label1.numberOfLines = 0;
    [self.view addSubview:label1];
    
    label1.enabledTextCheckingTypes = NSTextCheckingTypeLink;
    
    label1.delegate = self;
    
    label1.linkAttributes = @{ NSForegroundColorAttributeName : [UIColor redColor] };
    
    label1.text = @"当前日期";
    
    NSRange range1 = [label1.text rangeOfString:@"当前日期"];
    
    [label1 addLinkToDate:[NSDate date] withRange:range1];
    TTTAttributedLabel *labelPhone = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 205, self.view.bounds.size.width, 40)];
    labelPhone.numberOfLines = 0;
    [self.view addSubview:labelPhone];
    
    labelPhone.delegate = self;
    
    labelPhone.text = @"13298171128";
    NSRange rangePhone = [labelPhone.text rangeOfAll];
    [labelPhone addLinkToDate:[NSDate date] withRange:rangePhone];
    
    UILabel *labelHTML = [[UILabel alloc] init];
    NSString *htmlString = @"<p>网页富文本</p><p>网页富文本</p>";
    __block NSAttributedString *attrStr;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
        NSLog(@"%@",[NSThread currentThread]);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            labelHTML.frame = CGRectMake(10, 265, 300, 40);
            labelHTML.attributedText = attrStr;
            [self.view addSubview:labelHTML];
            
            TTTAttributedLabel *attributeLabel = [[TTTAttributedLabel alloc] initWithFrame:CGRectMake(0, 305, self.view.bounds.size.width, 60)];
            attributeLabel.numberOfLines = 0;
            attributeLabel.enabledTextCheckingTypes = NSTextCheckingTypeLink;
            attributeLabel.text = attrStr;
            [self.view addSubview:attributeLabel];
        });
    });
}


-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithURL:(NSURL *)url
{
    NSLog(@"--%@",url);
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"事件" message:[NSString stringWithFormat:@"点击了%@",url] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [ale show];
}
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithDate:(NSDate *)date
{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"事件" message:[NSString stringWithFormat:@"点击了%@",date] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [ale show];
}
-(void)attributedLabel:(TTTAttributedLabel *)label didSelectLinkWithPhoneNumber:(NSString *)phoneNumber
{
    UIAlertView *ale = [[UIAlertView alloc] initWithTitle:@"事件" message:[NSString stringWithFormat:@"点击了%@",phoneNumber] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [ale show];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]]];
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
