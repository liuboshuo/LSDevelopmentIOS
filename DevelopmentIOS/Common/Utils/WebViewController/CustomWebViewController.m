//
//  CustomWebViewController.m
//  LSWebViewProject
//
//  Created by 刘硕 on 15/12/25.
//  Copyright © 2015年 liushuo. All rights reserved.
//

#import "CustomWebViewController.h"


#define WebViewNav_TintColor ([UIColor blueColor])


@interface CustomWebViewController ()<UIWebViewDelegate>

@property(nonatomic , assign)NSUInteger loadCount;
@property(nonatomic , strong)UIProgressView *progressView;
@property(nonatomic , strong)UIWebView *webView;
@property(nonatomic , strong)UIButton *colseButton;
@property(nonatomic , strong)UIBarButtonItem *backBarButtonItem;
@end

@interface CustomWebViewController ()

@end

@implementation CustomWebViewController



-(CustomWebViewController *)initProgressWebViewWithURLStr:(NSString *)urlStr withTitle:(NSString *)title
{
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    CustomWebViewController *webViewVc = [[CustomWebViewController alloc] init];
    webViewVc.homeURL = [NSURL URLWithString:urlStr];
    
    [webViewVc configUI];
    [webViewVc configBackItem];
    
    return webViewVc;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)configUI
{
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    progressView.tintColor = WebViewNav_TintColor;
    progressView.trackTintColor = [UIColor whiteColor];
    [self.view addSubview:progressView];
    self.progressView = progressView;
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webView.scalesPageToFit = YES;
    webView.backgroundColor = [UIColor whiteColor];
    webView.delegate = self;
    [self.view insertSubview:webView belowSubview:progressView];
    NSURLRequest *request = [NSURLRequest requestWithURL:_homeURL];
    [webView loadRequest:request];
    self.webView = webView;
}

-(void)setNavigatemColor:(UIColor *)navigatemColor
{
    [self.colseButton setTitleColor:navigatemColor forState:UIControlStateNormal];
    self.backBarButtonItem.tintColor = navigatemColor;
    _navigatemColor = navigatemColor;
}
-(void)setProgressColor:(UIColor *)progressColor
{
    self.progressView.tintColor = progressColor;
    _progressColor = progressColor;
}

-(void)configBackItem
{
    UIBarButtonItem *leftNegativeSpacer = [[ UIBarButtonItem alloc ] initWithBarButtonSystemItem : UIBarButtonSystemItemFixedSpace
                                                                                          target : nil action : nil ];
    leftNegativeSpacer.width = -10;
    self.navigationItem.leftBarButtonItems = @[leftNegativeSpacer,self.backBarButtonItem];
}

- (void)configColseItem {
    UIBarButtonItem *colseItem = [[UIBarButtonItem alloc] initWithCustomView:self.colseButton];
    NSMutableArray *newArr = [NSMutableArray arrayWithObjects:self.navigationItem.leftBarButtonItems[0],self.navigationItem.leftBarButtonItems[1],colseItem, nil];
    self.navigationItem.leftBarButtonItems = newArr;
}

-(void)backButtonPressed:(id)sender
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        if (self.navigationItem.leftBarButtonItems.count >= 1) {
            [self configColseItem];
        }
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)colseBtnPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)setLoadCount:(NSUInteger)loadCount
{
    _loadCount = loadCount;
    if (loadCount == 0) {
        self.progressView.hidden = YES;
        [self.progressView setProgress:0 animated:NO];
    }else{
        self.progressView.hidden = NO;
        CGFloat oldP = self.progressView.progress;
        CGFloat newP = (1.0 - oldP) / (loadCount + 1) + oldP;
        if (newP > 0.95) {
            newP = 0.95;
        }
        [self.progressView setProgress:newP animated:YES];
    }
}
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    self.loadCount++;
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.loadCount--;
    self.navigationItem.title = [self.webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    self.loadCount--;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(UIButton *)colseButton
{
    if (_colseButton == nil) {
        // 导航栏的关闭按钮
        UIButton *colseBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        colseBtn.tintColor = self.navigatemColor;
        [colseBtn setTitle:@"关闭" forState:UIControlStateNormal];
        [colseBtn addTarget:self action:@selector(colseBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
        [colseBtn sizeToFit];
        _colseButton = colseBtn;
    }
    return _colseButton;
}
-(UIBarButtonItem *)backBarButtonItem
{
    if (_backBarButtonItem == nil) {
        UIImage *backImage = [UIImage imageNamed:@"cc_webview_back"];
        backImage = [backImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
        [backBtn setBackgroundImage:backImage forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *closeItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        _backBarButtonItem = closeItem;
    }
    return _backBarButtonItem;
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
