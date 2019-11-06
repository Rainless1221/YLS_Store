//
//  YlsCheckstandController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YlsCheckstandController.h"
#import "YlsCheckstandView.h"

@interface YlsCheckstandController ()
@property (strong,nonatomic)UIScrollView *ScrollView;
@property (strong,nonatomic)YlsCheckstandView *CashierView;

@end

@implementation YlsCheckstandController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"";
    /*
     * 导航栏
     */
    [self setupNav];
    /*
     * UI
     */
    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    
    UIBarButtonItem *lefttitem=[[UIBarButtonItem alloc]initWithCustomView:self.leftbutton];
    self.navigationItem.leftBarButtonItem = lefttitem;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 80, 44);
    [rightbutton setTitle:@"收银细则" forState:UIControlStateNormal];
    [rightbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:14];
//    [rightbutton addTarget:self action:@selector(RightAction) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.ScrollView];
    [self.ScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    [self.ScrollView addSubview:self.CashierView];

}
#pragma mark - 懒加载
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ScrollView.backgroundColor =[UIColor clearColor];
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 980);
//        _ScrollView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(ViewheaderRereshing)];
    }
    return _ScrollView;
}
-(UIButton *)leftbutton{
    if (!_leftbutton) {
        _leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftbutton.frame = CGRectMake(0, 0, autoScaleW(170), 44);
        [_leftbutton setTitle:@"大房子创意菜" forState:UIControlStateNormal];
        [_leftbutton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _leftbutton.titleLabel.font = [UIFont systemFontOfSize:autoScaleW(16)];
    }
    return _leftbutton;
}
-(YlsCheckstandView *)CashierView{
    if (!_CashierView) {
        _CashierView =[[ YlsCheckstandView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 935)];
    }
    return _CashierView;
}
@end
