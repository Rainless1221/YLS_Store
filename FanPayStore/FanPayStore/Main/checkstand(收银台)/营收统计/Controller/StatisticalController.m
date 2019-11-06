//
//  StatisticalController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StatisticalController.h"

@interface StatisticalController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)TotalRevenue * StoreView;
@property (strong,nonatomic)Distribution * StoreView1;
@property (strong,nonatomic)DistributionList * StoreView2;
@end

@implementation StatisticalController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"营收统计";
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.StoreView];
    [self.SJScrollView addSubview:self.StoreView1];
    [self.SJScrollView addSubview:self.StoreView2];
}

#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1334);
    }
    return _SJScrollView;
}
-(TotalRevenue *)StoreView{
    if (!_StoreView) {
        _StoreView = [[TotalRevenue alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 266)];
        _StoreView.backgroundColor = [UIColor whiteColor];
        _StoreView.layer.cornerRadius = 5;
        //        _StoreView.delagate = self;
    }
    return _StoreView;
}
-(Distribution *)StoreView1{
    if (!_StoreView1) {
        _StoreView1 = [[Distribution alloc]initWithFrame:CGRectMake(15, self.StoreView.bottom+15, ScreenW-30, 396)];
        _StoreView1.backgroundColor = [UIColor whiteColor];
        _StoreView1.layer.cornerRadius = 5;
        //        _StoreView.delagate = self;
    }
    return _StoreView1;
}
-(DistributionList *)StoreView2{
    if (!_StoreView2) {
        _StoreView2 = [[DistributionList alloc]initWithFrame:CGRectMake(15, self.StoreView1.bottom+15, ScreenW-30, 544)];
        _StoreView2.backgroundColor = [UIColor whiteColor];
        _StoreView2.layer.cornerRadius = 5;
        //        _StoreView.delagate = self;
    }
    return _StoreView2;
}
@end
