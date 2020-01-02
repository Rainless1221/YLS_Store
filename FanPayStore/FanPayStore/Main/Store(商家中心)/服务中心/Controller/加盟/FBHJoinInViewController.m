//
//  FBHJoinInViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHJoinInViewController.h"

@interface FBHJoinInViewController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)JoinInView * scrollView;

@end

@implementation FBHJoinInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"加盟代理";
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
}

#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 667);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}

-(JoinInView *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"JoinInView" owner:nil options:nil][0];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 667 );
        YBWeakSelf
        _scrollView.joinblock = ^{
            [weakSelf.navigationController pushViewController:[FBHJoinInTController new] animated:YES];

//            [SVProgressHUD setMinimumDismissTimeInterval:0.5];
//            [SVProgressHUD showErrorWithStatus:@"此功能暂未开发"];
            
        };
    }
    return _scrollView;
}

@end
