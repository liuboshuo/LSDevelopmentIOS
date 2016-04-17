//
//  ShowBigImageView.m
//  SCFinanceAppiOS
//
//  Created by 刘硕 on 16/2/18.
//  Copyright © 2016年 scfinance. All rights reserved.
//

#import "ShowBigImageView.h"
#import "UIView+Extension.h"
#import "UIImageView+WebCache.h"
#import "UIPropertyConstant.h"
@interface ShowBigImageView ()

@property(nonatomic , strong)UIImageView *imageView;

@property(nonatomic , assign)CGRect originFrame;


@property(nonatomic , strong)UIImage *image;
@property(nonatomic , assign)CGFloat currentScale;






@property(nonatomic , assign)CGFloat minScale;
@property(nonatomic , assign)CGFloat maxScale;

@property(nonatomic , assign)CGPoint point;

@property(nonatomic , assign)CGSize deviation;

@end

@implementation ShowBigImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.imageView = [[UIImageView alloc] init];
        self.alpha = 0;
        self.backgroundColor = [UIColor blackColor];
        _minScale = 0.5;
        _maxScale = 1.5;
        //点击大图时，不作任何事情
        self.imageView.userInteractionEnabled = YES;
        self.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click)]];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click1)];
        tap.numberOfTapsRequired = 1;
        [self.imageView addGestureRecognizer:tap];
    }
    return self;
}
-(void)setSmallImageView:(UIImageView *)smallImageView
{
    _smallImageView = smallImageView;
    //    [self setBigImageViewWithSmall:_smallImageView bigImageIcon:_bigImageIcon];
}

-(void)setBigImageIcon:(NSString *)bigImageIcon
{
    _bigImageIcon = bigImageIcon;
    if (_smallImageView != nil) {
        [self setBigImageViewWithSmall:_smallImageView bigImageIcon:_bigImageIcon];
    }
}
-(void)setBigImageViewWithSmall:(UIImageView *)smallImageView bigImageIcon:(NSString *)bigImgaeIcon
{
    self.currentScale = 1;
    CGRect frame = [_smallImageView convertRect:_smallImageView.bounds toView:UICurrentWindow];
    self.originFrame = frame;
    self.imageView.frame = frame;
    self.image = _smallImageView.image;
    if (bigImgaeIcon == nil) {
        
        
    }else{
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:bigImgaeIcon] placeholderImage:self.image completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [self addSubview:self.imageView];
            [UIView animateWithDuration:0.6 animations:^{
                if (image.size.width < UIScreenWidth) {
                    if (image.size.height < UIScreenHeight) {
                        self.imageView.width = image.size.width;
                        self.imageView.height = image.size.height;
                    }else{
                        self.imageView.width = image.size.width;
                        self.imageView.height = image.size.height;
                    }
                }else{
                    self.imageView.width = UIScreenWidth;
                    self.imageView.height = image.size.height * UIScreenWidth / image.size.width ;
                }
                self.alpha = 1;
                self.imageView.center = UICurrentWindow.center;
            } completion:^(BOOL finished) {
                
            }];
        }];
    }
}
//消失
-(void)click
{
    [UIView animateWithDuration:0.3 animations:^{
        self.imageView.frame = self.originFrame;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
//处理点击事件
-(void)click1
{
    [self click];
}
@end
