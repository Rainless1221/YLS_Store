//
//  EnvironmentController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "EnvironmentController.h"
#import "EnvironmentView.h"

@interface EnvironmentController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;

@property (strong,nonatomic)EnvironmentView * StoreView;
@end

@implementation EnvironmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.StoreView];
    
}

#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 603);
    }
    return _SJScrollView;
}
-(EnvironmentView *)StoreView{
    if (!_StoreView) {
        _StoreView = [[EnvironmentView alloc]initWithFrame:CGRectMake(15, 75, ScreenW-30, 500)];
        _StoreView.backgroundColor = [UIColor whiteColor];
        _StoreView.layer.cornerRadius = 5;
//        _StoreView.delagate = self;
    }
    return _StoreView;
}
@end
