//
//  BannerView.m
//  ConcreteClass
//
//  Created by macPro on 2018/11/30.
//  Copyright © 2018年 蒲仁飞. All rights reserved.
//

#import "BannerView.h"

@interface BannerView ()<UIScrollViewDelegate>

@property (strong, nonatomic) NSArray *images;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;
@property (copy, nonatomic) TapActionBlock tapBlock;

@end

@implementation BannerView

+(void)showBannerWithFrame:(CGRect)frame images:(nonnull NSArray *)images superView:(nonnull UIView *)superView tapBlock:(nonnull TapActionBlock)tapBlock{
    
    BannerView *banner = [[BannerView alloc]initWithFrame:frame images:images];
    banner.tapBlock = tapBlock;
    [superView addSubview:banner];
}

-(instancetype)initWithFrame:(CGRect)frame images:(NSArray *)images{
    
    self = [super initWithFrame:frame];
    if (self) {
        self.images = images;
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self setBannerView];
//        [self setTimer];
    }
    return self;
}

-(void)setTimer{
    
    __weak typeof(self)weakSelf = self;
    [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
       CGFloat x = weakSelf.scrollView.contentOffset.x;
        if (x>=weakSelf.scrollView.contentSize.width) {
            [weakSelf.scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            [weakSelf.scrollView setContentOffset:CGPointMake(CGRectGetWidth(weakSelf.frame), 0) animated:YES];
            weakSelf.pageControl.currentPage = 0;
        }else{
            [weakSelf.scrollView setContentOffset:CGPointMake(x+CGRectGetWidth(weakSelf.frame), 0) animated:YES];
            weakSelf.pageControl.currentPage = x/CGRectGetWidth(weakSelf.frame);
        }
    }];
}

-(void)setBannerView{
    
//    第一张
//    UIImageView *firstImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//    firstImg.image = [UIImage imageNamed:self.images.lastObject];//最后一张图片
//    firstImg.contentMode = UIViewContentModeScaleAspectFill;
//    [self.scrollView addSubview:firstImg];
//    中间
    for (NSInteger i=0; i<self.images.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake((CGRectGetWidth(self.frame)*(i)), 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
        imgView.image = [UIImage imageNamed:self.images[i]];//x中间图片
        imgView.contentMode = UIViewContentModeScaleAspectFill;
        imgView.userInteractionEnabled = YES;
        imgView.tag = i;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [imgView addGestureRecognizer:tap];
        [self.scrollView addSubview:imgView];
    }
//    最后一张
//    UIImageView *lastImg = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame)+1, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))];
//    lastImg.image = [UIImage imageNamed:self.images.firstObject];//最后一张图片
//    lastImg.contentMode = UIViewContentModeScaleAspectFill;
//    [self.scrollView addSubview:lastImg];
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*self.images.count, CGRectGetHeight(self.frame));
    self.scrollView.contentOffset = CGPointMake(0, 0);
    /// 图片总数
    self.pageControl.numberOfPages = self.images.count;
    self.pageControl.currentPage = 0;
}

-(void)tapAction:(UITapGestureRecognizer*)gester{
    
    self.tapBlock(gester.view.tag);
}

-(UIScrollView *)scrollView{
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:self.bounds];
        _scrollView.scrollEnabled = YES;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = YES;
        _scrollView.delegate = self;
        _scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.frame)*(2+self.images.count), CGRectGetHeight(self.frame));
    }
    return _scrollView;
}

-(UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.frame)-10, CGRectGetWidth(self.frame), 50)];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
        _pageControl.currentPageIndicatorTintColor = UIColorFromRGB(0x3D8AFF);//[UIColor blueColor];
    }
    return _pageControl;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    CGFloat offsetX = scrollView.contentOffset.x;
//    if (offsetX>=(self.images.count)*(CGRectGetWidth(self.frame))) {
//        scrollView.contentOffset = CGPointMake(CGRectGetWidth(self.frame), 0);
//        self.pageControl.currentPage = 0;
//    }else{
        self.pageControl.currentPage = offsetX/CGRectGetWidth(self.frame);
//    }
}


@end
