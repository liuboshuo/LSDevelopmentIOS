//
//  LSInfiniteScrollView.m
//  LSDevelopmentIOS
//
//  Created by 刘硕 on 16/4/15.
//  Copyright © 2016年 liushuo. All rights reserved.
//

#import "LSInfiniteScrollView.h"
#import "UIImageView+WebCache.h"

#define pageSize 16


#define ScrollWidth self.frame.size.width
#define ScrollHeight self.frame.size.height

@interface LSInfiniteScrollView ()<UIScrollViewDelegate>


@property(nonatomic , strong)NSArray *imagesArray;


@property(nonatomic , weak)UIImageView *leftImageView;

@property(nonatomic , weak)UIImageView *centerImageView;

@property(nonatomic , weak)UIImageView *rightImageView;

@property(nonatomic , weak)UIScrollView *scrollView;

@property(nonatomic , weak)UIPageControl *pageControl;

@property(nonatomic , strong)NSTimer *timer;

@property(nonatomic , assign)NSInteger currentIndex;

@property(nonatomic , assign)NSInteger maxImageCount;

@property(nonatomic , assign)BOOL isLocalImage;;

@end

@implementation LSInfiniteScrollView

-(instancetype)initWithFrame:(CGRect)frame localImageNames:(NSArray<NSString *> *)imagesNames
{
    if (imagesNames.count < 2) {
        return nil;
    }
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _isLocalImage = YES;
        
        [self createScrollView];
        
        [self setImagesArray:imagesNames];
        
        [self setMaxImageCount:imagesNames.count];
    }
    
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame netURLs:(NSArray<NSString *> *)urls
{
    if (urls.count < 2) {
        return nil;
    }
    self = [super initWithFrame:frame];
    if (self) {
        _isLocalImage = NO;
        [self createScrollView];
        
        [self setImagesArray:urls];
        
        [self setMaxImageCount:urls.count];
    }
    return self;
}


-(void)createScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    
    [self addSubview:scrollView];
    
    self.layer.masksToBounds = YES;
    
    scrollView.backgroundColor = [UIColor clearColor];
    
    scrollView.pagingEnabled = YES;
    
    scrollView.showsHorizontalScrollIndicator = NO;
    
    scrollView.delegate = self;
    scrollView.contentSize = CGSizeMake(ScrollWidth * 3, 0);
    _autoScrollDelay = 0;
    
    _currentIndex = 0;
    
    self.scrollView = scrollView;
}

-(void)setImagesArray:(NSArray *)imagesArray
{
    
    if (!_isLocalImage) {
        _imagesArray = [imagesArray copy];
    }else{
        NSMutableArray *images = [NSMutableArray array];
        for (NSString *imageName in imagesArray) {
            [images addObject:[UIImage imageNamed:imageName]];
        }
        _imagesArray = [images copy];
    }
}
-(void)createPageControl
{
    UIPageControl *pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, ScrollHeight - pageSize, ScrollWidth,10)];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:67.0/255.0 green:199.0/255.0 blue:176.0/255.0 alpha:1];
    pageControl.numberOfPages = self.maxImageCount;
    pageControl.currentPage = 0;
    
    [self addSubview:pageControl];
    
    self.pageControl = pageControl;
}
-(void)setUpTimer
{
    self.timer = [NSTimer timerWithTimeInterval:_autoScrollDelay target:self selector:@selector(scroll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
-(void)scroll
{
    [self.scrollView setContentOffset:CGPointMake(((int)_scrollView.contentOffset.x / ScrollWidth + 1) * ScrollWidth, 0) animated:YES];
}

-(void)setMaxImageCount:(NSInteger)maxImageCount
{
    
    _maxImageCount = maxImageCount;
    
    [self initImageVies];
    
    [self createPageControl];
    
    [self setUpTimer];
    
    [self changeImageLeft:_maxImageCount - 1 center:0 right:1];
    
}
-(void)initImageVies
{
    UIImageView *leftImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScrollWidth, ScrollHeight)];
    [self.scrollView addSubview:leftImageView];
    _leftImageView = leftImageView;
    
    UIImageView *centerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollWidth, 0, ScrollWidth, ScrollHeight)];
    centerImageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTap)];
    [centerImageView addGestureRecognizer:tapGestureRecognizer];
    [self.scrollView addSubview:centerImageView];
    _centerImageView = centerImageView;
    UIImageView *rightImageView = [[UIImageView alloc] initWithFrame:CGRectMake(ScrollWidth * 2, 0, ScrollWidth, ScrollHeight)];
    [self.scrollView addSubview:rightImageView];
    self.rightImageView = rightImageView;
}
-(void)imageViewTap
{
    [self.netDelegate didSelectNetImageAtIndex:_currentIndex];
    [self.localDelegate didSelectLocalImageAtIndex:_currentIndex];
}
-(void)changeImageLeft:(NSInteger)leftIndex center:(NSInteger)centerIndex right:(NSInteger)rightIndex
{
    if (!_isLocalImage)
    {
        
        [_leftImageView sd_setImageWithURL:[NSURL URLWithString:_imagesArray[leftIndex]] placeholderImage:_placeholderImage];
        [_centerImageView sd_setImageWithURL:[NSURL URLWithString:_imagesArray[centerIndex]] placeholderImage:_placeholderImage];
        [_rightImageView sd_setImageWithURL:[NSURL URLWithString:_imagesArray[rightIndex]] placeholderImage:_placeholderImage];
        
    }else
    {
        _leftImageView.image = _imagesArray[leftIndex];
        _centerImageView.image = _imagesArray[centerIndex];
        _rightImageView.image = _imagesArray[rightIndex];
    }
    
    [_scrollView setContentOffset:CGPointMake(ScrollWidth, 0)];
    
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setUpTimer];
}
-(void)removeTimer
{
    if (_timer == nil) {
        return;
    }
    [_timer invalidate];
    _timer = nil;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self changeImageWithScrollViewOffset:self.scrollView.contentOffset.x];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeTimer];
}
-(void)changeImageWithScrollViewOffset:(CGFloat)offsetX
{
    if (offsetX >= ScrollWidth * 2) {
        _currentIndex ++;
        
        if (_currentIndex == _maxImageCount -1) {
            [self changeImageLeft:_currentIndex - 1 center:_currentIndex right:0];
        }else if (_currentIndex == _maxImageCount){
            _currentIndex = 0;
            [self changeImageLeft:_maxImageCount - 1 center:0 right:1];
        }else{
            [self changeImageLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex + 1];
        }
        _pageControl.currentPage = _currentIndex;
    }
    if (offsetX <= 0) {
        _currentIndex--;
        if (_currentIndex == 0) {
            [self changeImageLeft:_maxImageCount - 1 center:0 right:1];
        }else if (_currentIndex == -1){
            _currentIndex = _maxImageCount - 1;
            [self changeImageLeft:_currentIndex - 1 center:_currentIndex right:0];
        }else{
            [self changeImageLeft:_currentIndex - 1 center:_currentIndex right:_currentIndex +1];
        }
        _pageControl.currentPage = _currentIndex;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scrollView.frame = CGRectMake(0, 0, ScrollWidth, ScrollHeight);
    self.pageControl.frame = CGRectMake(0, ScrollHeight - pageSize, ScrollWidth, 10);
    
    self.leftImageView.frame = CGRectMake(0, 0, ScrollWidth, ScrollHeight);
    self.centerImageView.frame = CGRectMake(ScrollWidth, 0, ScrollWidth, ScrollHeight);
    self.rightImageView.frame = CGRectMake(ScrollWidth*2, 0, ScrollWidth, ScrollHeight);
    
}
-(void)dealloc
{
    [self removeTimer];
}
-(void)setAutoScrollDelay:(NSTimeInterval)autoScrollDelay
{
    _autoScrollDelay = autoScrollDelay;
    
    [self removeTimer];
    [self setUpTimer];
}
@end
