//
//  FBHDWSSViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/25.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHDWSSViewController.h"


@interface FBHDWSSViewController ()<CashierDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;

@end

@implementation FBHDWSSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.SJScrollView];
  
}

#pragma mark - GET
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1600);
    }
    return _SJScrollView;
}


@end
