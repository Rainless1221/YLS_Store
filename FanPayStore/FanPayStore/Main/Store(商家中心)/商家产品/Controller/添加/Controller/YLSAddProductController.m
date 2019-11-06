//
//  YLSAddProductController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddProductController.h"
#import "YLSAddProductView.h"
#define  image_H 0

@interface YLSAddProductController ()
@property (strong,nonatomic)UIScrollView * ProductScrollView;
@property (strong,nonatomic)YLSAddProductView *  ProductView;

@end

@implementation YLSAddProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";

    /**
     UI
     */
    [self createUI];
    
}
#pragma mark - UI
-(void)createUI{
     [self.view addSubview:self.ProductScrollView];
    self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1200+image_H);
    [self.ProductScrollView addSubview:self.ProductView];
    
}
#pragma mark - 懒加载
-(UIScrollView *)ProductScrollView{
    if (!_ProductScrollView) {
        _ProductScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ProductScrollView.backgroundColor = MainbackgroundColor;
        _ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1200+image_H);
    }
    return _ProductScrollView;
}
-(YLSAddProductView *)ProductView{
    if (!_ProductView) {
        _ProductView = [[YLSAddProductView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH*1.3)];
    }
    return _ProductView;
}
@end
