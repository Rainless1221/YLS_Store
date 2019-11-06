//
//  SYGuideView.m
//  zhangshaoyu
//
//  Created by zhangshaoyu on 15/8/21.
//  Copyright (c) 2015年 zhangshaoyu. All rights reserved.
//

#import "SYGuideView.h"

/********************************************************/

// 图片名称命名示例：guideImage_1_640x960.png，即" guideImage_1 "、" _640x960.png "
static NSString *const image4  = @"_640x960";
static NSString *const image5  = @"_640x1136";
static NSString *const image6  = @"_750x1334";
static NSString *const image6P = @"_1242x2208";

#define isiPhone4  ([[UIScreen mainScreen] bounds].size.height < 568.0)
#define isiPhone5  ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define isiPhone6  ([[UIScreen mainScreen] bounds].size.height == 667.0)
#define isiPhone6P ([[UIScreen mainScreen] bounds].size.height > 667.0)

/********************************************************/

@interface SYGuideView () <UIScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *imageviewArray;
@property (nonatomic, strong) UIButton *actionButton;

@property (nonatomic, assign, readonly) NSInteger imageCount;
@property (nonatomic, assign, readonly) CGFloat imageWidth;
/**
 圆点
 */
@property (nonatomic,strong) UIPageControl *pageControl;
/**
 未选中圆点颜色
 */
@property (nonatomic,strong)UIColor *pageIndicatorColor;

/**
 选中圆点颜色
 */
@property (nonatomic,strong)UIColor *currentPageIndicatorColor;

@end

@implementation SYGuideView

@synthesize isSlide = _isSlide;

- (instancetype)initWithImages:(NSArray *)array
{
    self = [super init];
    if (self)
    {
        [UIApplication sharedApplication].statusBarHidden = YES;
        self.animationTime = 0.6;
        
        UIView *bgView = [UIApplication sharedApplication].delegate.window;
        [bgView addSubview:self];
        self.frame = bgView.bounds;
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.userInteractionEnabled = YES;
        self.delegate = self;

        [self setUIWithImages:array];
        [self createPageControl];

    }
    
    return self;
}

#pragma mark - 创建视图

- (void)setUIWithImages:(NSArray *)array
{
    if (array)
    {
        NSInteger count = array.count;
        self.imageviewArray = [[NSMutableArray alloc] initWithCapacity:count];
        for (NSInteger i = 0; i < count; i++)
        {
            CGRect rect = CGRectMake((i * self.frame.size.width), 0.0, self.frame.size.width, self.frame.size.height);
            NSString *imageName = array[i];
            imageName = [[NSString alloc] initWithFormat:@"%@%@", imageName, typeName()];
            
            UIImageView *imageview = [[UIImageView alloc] initWithFrame:rect];
            [self addSubview:imageview];
            imageview.backgroundColor = [UIColor clearColor];
            imageview.contentMode = UIViewContentModeScaleAspectFill;
            imageview.image = [UIImage imageNamed:imageName];
            
            [self.imageviewArray addObject:imageview];
            
            if (i == count - 1)
            {
                imageview.userInteractionEnabled = YES;
                
                
                
                
                /**
                 * 最后一张图片下添加按钮或是视图等
                 **/
                
                UIView *View_text = [[UIView alloc]initWithFrame:CGRectMake(0,0,120,30)];
                CAGradientLayer *gl = [CAGradientLayer layer];
                gl.frame = CGRectMake(0,0,120,30);
                gl.startPoint = CGPointMake(0, 0);
                gl.endPoint = CGPointMake(1, 1);
                gl.colors = @[(__bridge id)[UIColor colorWithRed:255/255.0 green:50/255.0 blue:100/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:255/255.0 green:0/255.0 blue:0/255.0 alpha:1.0].CGColor];
                gl.locations = @[@(0.0),@(1.0)];
                [View_text.layer addSublayer:gl];
                View_text.layer.cornerRadius = 15;
                View_text.layer.masksToBounds = YES;
                [imageview addSubview:View_text];
                [View_text mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.centerX.mas_offset(0);
                    make.width.mas_offset(120);
                    make.height.mas_offset(30);
                    make.bottom.mas_offset(-(kIs_iPhoneX ? 74:54));
                }];
                
                UILabel *view = [[UILabel alloc] init];
                view.frame = CGRectMake(0,0,120,30);
                view.text= @"进入体验";
                view.textColor = [UIColor whiteColor];
                view.textAlignment = 1;
//                view.backgroundColor = [UIColor colorWithRed:0/255.0 green:144/255.0 blue:255/255.0 alpha:1.0];
                view.layer.cornerRadius = 15;
                view.layer.masksToBounds = YES;
                [View_text addSubview:view];
                [view mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.left.right.bottom.mas_offset(0);
                }];
                
               
                
                self.actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
                [imageview addSubview:self.actionButton];
                self.actionButton.frame = imageview.bounds;
                self.actionButton.backgroundColor = [UIColor clearColor];
                [self.actionButton addTarget:self action:@selector(buttonActionClick) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
        
        self.contentSize = CGSizeMake(count * self.frame.size.width, self.frame.size.height);
    }
}
- (void)createPageControl
{
    _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, ScreenH - 45, ScreenW, 30)];
    _pageControl.hidden = NO;
    _pageControl.pageIndicatorTintColor = _pageIndicatorColor;
    _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorColor;
    _pageControl.numberOfPages = self.imageviewArray.count;
    [self.window addSubview:_pageControl];
    
}

#pragma mark - 响应事件

- (void)buttonActionClick
{
    if (self.buttonClick)
    {
        self.buttonClick();
    }
    
    [self hiddenImageView];
}

#pragma mark - 方法

- (void)hiddenImageView
{
    [UIApplication sharedApplication].statusBarHidden = NO;
    
    if (self.isSlide)
    {
        // 向左滑动消失
        UIImageView *imageview = self.imageviewArray.lastObject;

        [UIView animateWithDuration:self.animationTime animations:^{
            CGRect rect = imageview.frame;
            rect.origin.x -= self.imageWidth;
            imageview.frame = rect;
            imageview.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.pageControl removeFromSuperview];
        }];
    }
    else
    {
        if (SYGuideAnimationTypeDefault == self.animationType)
        {
            // 直接消失
            [self removeFromSuperview];
            [self.pageControl removeFromSuperview];

        }
        else if (SYGuideAnimationTypeZoomIn == self.animationType)
        {
            // 放大淡化再消失
            UIImageView *imageview = self.imageviewArray.lastObject;
            
            [UIView animateWithDuration:self.animationTime animations:^{
                imageview.transform = CGAffineTransformMakeScale(1.6, 1.6);
                imageview.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self.pageControl removeFromSuperview];

            }];
        }
        else if (SYGuideAnimationTypeZoomOut == self.animationType)
        {
            // 缩小淡化再消失
            UIImageView *imageview = self.imageviewArray.lastObject;
            
            [UIView animateWithDuration:self.animationTime animations:^{
                imageview.transform = CGAffineTransformMakeScale(0.3, 0.3);
                imageview.alpha = 0.0;
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
                [self.pageControl removeFromSuperview];

            }];
        }
    }
}

NSString *typeName(void)
{
    if (isiPhone4)
    {
        return image4;
    }
    else if (isiPhone5)
    {
        return image5;
    }
    else if (isiPhone6)
    {
        return image6;
    }
    else if (isiPhone6P)
    {
        return image6P;
    }
    
    return image4;
}

#pragma mark - setter/getter

- (UIButton *)button
{
    return self.actionButton;
}

- (NSInteger)imageCount
{
    return self.imageviewArray.count;
}

- (CGFloat)imageWidth
{
    return self.frame.size.width;
}

- (void)setIsSlide:(BOOL)isSlide
{
    _isSlide = isSlide;
    if (_isSlide)
    {
        self.delegate = self;
        self.actionButton.hidden = YES;
    }
    else
    {
        self.actionButton.hidden = NO;
    }
}

- (BOOL)isSlide
{
    return _isSlide;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetWidth = scrollView.contentOffset.x;
    int pageNum = offsetWidth / self.imageWidth;
    self.pageControl.currentPage = pageNum;

    if (self.isSlide)
    {
        CGFloat offsetX = scrollView.contentOffset.x;
        NSInteger page = offsetX / self.imageWidth;
        

        if (page >= self.imageCount - 1)
        {
            self.bounces = YES;
            
            CGFloat hiddenOffsetX = ((self.imageCount - 1) * self.imageWidth + self.imageWidth / 5);
            if (offsetX >= hiddenOffsetX)
            {
                [self hiddenImageView];
            }
        }
        else
        {
            self.bounces = NO;
        }
    }
    
}

/************************************************************/

#pragma mark - 状态设置

/// 是否首次使用
+ (BOOL)readAppStatus
{
    NSNumber *number = [[NSUserDefaults standardUserDefaults] objectForKey:@"SaveAppStatusUsing"];
    return number.boolValue;
}

/// 设置使用状态（非首次）
+ (void)saveAppStatus
{
    NSNumber *number = [NSNumber numberWithBool:1];
    [[NSUserDefaults standardUserDefaults] setObject:number forKey:@"SaveAppStatusUsing"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/************************************************************/


@end
