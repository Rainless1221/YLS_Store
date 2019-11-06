//
//  SureguideView.m
//  app
//
//  Created by mocoo_ios on 2019/4/19.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SureguideView.h"
#import "AppDelegate.h"

@implementation SureguideView

+ (instancetype)sureGuideViewWithImageName:(NSString*)imageName
                                imageCount:(NSInteger)imageCount{
    return [[self alloc]initWithImageName:imageName imageCount:imageCount];
}

- (instancetype)initWithImageName:(NSString*)imageName
                       imageCount:(NSInteger)imageCount{
    if (self = [super init]) {
        self.imageName = imageName;
        self.imageCount = imageCount;
        [self createUI];
    }
    return self;
}
- (void)createUI {
    self.backgroundColor = [UIColor colorWithRed:2/255 green:45/255 blue:95/255 alpha:0.5];;
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:self.imageName];
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(touchImageView:)];
    [imageView addGestureRecognizer:tap];

    if (self.imageCount == 1) {
        if (ISIPHONE5) {
            imageView.frame = CGRectMake(SizeScale*20, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:autoScaleW(90)) - (ISIPHONE6P ? 65:0), 367/2 , SizeScale*448/2);
        }else{
            imageView.frame = CGRectMake(SizeScale*20, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:170) - (ISIPHONE6P ? 65:0), 367/2 , SizeScale*448/2);

        }

    }else if(self.imageCount == 2){
        if (ISIPHONE5) {
            imageView.frame = CGRectMake(SizeScale*20+kScreenWidth/2.25, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:autoScaleW(90))- (ISIPHONE6P ? 65:0), 367/2 , SizeScale*448/2);

        }else{
            imageView.frame = CGRectMake(SizeScale*20+kScreenWidth/2.25, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:170)- (ISIPHONE6P ? 65:0), 367/2 , SizeScale*448/2);

        }

    }else{
        if (ISIPHONE5) {
            imageView.frame = CGRectMake(SizeScale*20+kScreenWidth/2.5, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:autoScaleW(90)) - (ISIPHONE6P ? 65:0), SizeScale*367/2 , SizeScale*448/2);

        }else{
            imageView.frame = CGRectMake(SizeScale*20+kScreenWidth/2.5, kScreenHeight-(SizeScale*448)/2-(kIs_iPhoneX ? 270:170) - (ISIPHONE6P ? 65:0), SizeScale*367/2 , SizeScale*448/2);
        }

    }

    [self addSubview:imageView];
    
    
    [self show];
}
- (void)touchImageView:(UITapGestureRecognizer*)tap {
    [self hide];
}
- (void)show {
    [UIApplication sharedApplication].statusBarHidden = YES;
    AppDelegate *appDel = (AppDelegate*)[UIApplication sharedApplication].delegate;
    [appDel.window addSubview:self];
}

- (void)hide{
    [UIApplication sharedApplication].statusBarHidden = NO;
    [self removeFromSuperview];
}
@end
