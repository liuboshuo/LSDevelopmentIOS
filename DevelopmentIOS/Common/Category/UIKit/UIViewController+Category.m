//
//  UIViewController+Category.m
//  LSTestCategory
//
//  Created by 刘硕 on 15/12/16.
//  Copyright (c) 2015年 ls. All rights reserved.
//

#import "UIViewController+Category.h"
#import "LSBarButtonItem.h"
#import <objc/runtime.h>

//static const CGFloat currentScrollOffsetY = 600;

@interface UIViewController ()

@property(nonatomic , strong) UIImage *navBarBackgroundImage;

@property(nonatomic , weak)UIScrollView *keyScrollView;

@property(nonatomic , assign)HiddenControlOption options;

@property(nonatomic , assign)CGFloat scrollOffsetY;

@end

@implementation UIViewController (Category)

- (void)setupForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    
    __weak UIViewController *weakSelf = self;
    
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [weakSelf.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}

static const int *leftButtonItemKey;

-(void)setLeftButtonItem:(UIBarButtonItem *)leftButtonItem
{
    objc_setAssociatedObject(self, &leftButtonItemKey, leftButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIBarButtonItem *)leftButtonItem
{
    return objc_getAssociatedObject(self, &leftButtonItemKey);
}

static const int *rightButtonItemKey;

-(void)setRightButtonItem:(UIBarButtonItem *)rightButtonItem
{
    objc_setAssociatedObject(self, &rightButtonItemKey, rightButtonItem, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIBarButtonItem *)rightButtonItem
{
    return  objc_getAssociatedObject(self, &rightButtonItemKey);
}
static const char *keyScrollViewKey = "keyScrollViewKey";
-(void)setKeyScrollView:(UIScrollView *)keyScrollView
{
    objc_setAssociatedObject(self, &keyScrollViewKey, keyScrollView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIScrollView *)keyScrollView
{
    return objc_getAssociatedObject(self, &keyScrollViewKey);
    
}
static const char *navBarBackgroundImageKey = "navBarBackgroundImageKey";
-(void)setNavBarBackgroundImage:(UIImage *)navBarBackgroundImage
{
    objc_setAssociatedObject(self, &navBarBackgroundImageKey, navBarBackgroundImage, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(UIImage *)navBarBackgroundImage
{
    return objc_getAssociatedObject(self, &navBarBackgroundImageKey);
}
static const char *scrollViewOffsetKey = "scrollViewOffsetKey";
-(void)setScrollOffsetY:(CGFloat)scrollOffsetY
{
    objc_setAssociatedObject(self, &scrollViewOffsetKey, @(scrollOffsetY), OBJC_ASSOCIATION_ASSIGN);
}
-(CGFloat)scrollOffsetY
{
    return [objc_getAssociatedObject(self, &scrollViewOffsetKey) floatValue];
}
static const char *hiddenControlOptionKey = "hiddenControlOptionKey";
-(void)setOptions:(HiddenControlOption)options
{
    objc_setAssociatedObject(self, &hiddenControlOptionKey, @(options), OBJC_ASSOCIATION_ASSIGN);
}
-(HiddenControlOption)options
{
    return [objc_getAssociatedObject(self, &hiddenControlOptionKey) unsignedIntegerValue];
}
-(void)setBackBarButtonItemWithTitle:(NSString *)text
{
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:text style:UIBarButtonItemStylePlain target:nil action:nil];
}

-(UIBarButtonItem *)leftButtonItemWithTitle:(NSString *)text isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    return [self leftButtonItemWithTitle:text image:nil isBackBarButtonItem:isBackBarButtonItem];
}
-(UIBarButtonItem *)leftButtonItemWithImage:(NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    return [self leftButtonItemWithTitle:nil image:imageName isBackBarButtonItem:isBackBarButtonItem];
}

-(UIBarButtonItem *)leftButtonItemWithTitle:(NSString *)text image:(NSString *)imageName isBackBarButtonItem:(BOOL)isBackBarButtonItem
{
    if (!self.leftButtonItem) {
        self.leftButtonItem = [LSBarButtonItem itemWithTitle:text image:imageName isBackButtonItem:isBackBarButtonItem target:self action:@selector(leftBtnClick:)];
    }
    return self.leftButtonItem;
}


-(UIBarButtonItem *)rightButtonItemWithTitle:(NSString *)text
{
    if (!self.rightButtonItem)
    {
        self.rightButtonItem = [LSBarButtonItem itemWithTitle:text isBackButtonItem:NO target:self action:@selector(righBtnClick:)];
    }
    return self.rightButtonItem;
}

-(UIBarButtonItem *)rightButtonItemWithImage:(NSString *)imageName
{
    if (!self.rightButtonItem) {
        self.rightButtonItem = [LSBarButtonItem itemWithImage:imageName isBackButtonItem:NO target:self action:@selector(righBtnClick:)];
    }
    return self.rightButtonItem;
}
- (void)leftBtnClick:(UIBarButtonItem *)leftButtonItem
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)righBtnClick:(UIBarButtonItem *)rightButtonItem
{
    //防止编译器提示，只需在子类重写就OK
}

-(void)setInViewWillAppear
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        self.navBarBackgroundImage = [self.navigationController.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
    });
    [self.navigationController.navigationBar setBackgroundImage:self.navBarBackgroundImage forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

-(void)setInViewWillDisappear
{
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:1];
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}
-(void)setScrollVew:(UIScrollView *)scrollView scrollOffsetY:(CGFloat)scrollOffsetY options:(HiddenControlOption)options
{
    self.keyScrollView = scrollView;
    self.options = options;
    self.scrollOffsetY = scrollOffsetY;
    [self.keyScrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
}

static CGFloat alpha = 0;

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    CGFloat offsetY = self.scrollOffsetY;
    CGPoint point = self.keyScrollView.contentOffset;
    alpha = point.y / offsetY;
    alpha = (alpha <= 0) ? 0 : alpha;
    alpha = (alpha >= 1) ? 1 : alpha;
    
    NSLog(@"%@",self.navigationItem.leftBarButtonItem.customView);
    NSLog(@"%@",self.navigationItem.titleView);
    
    
    self.navigationItem.leftBarButtonItem.customView.alpha = self.options & 1 ? alpha : 1;
    self.navigationItem.titleView.alpha = self.options >> 1 & 1 ? alpha : 1;
    self.navigationItem.rightBarButtonItem.customView.alpha = self.options >> 2 & 1? alpha : 1;
    
    [[[self.navigationController.navigationBar subviews] objectAtIndex:0] setAlpha:alpha];
}
@end
