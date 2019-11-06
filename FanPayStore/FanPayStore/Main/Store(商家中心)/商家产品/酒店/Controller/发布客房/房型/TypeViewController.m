//
//  TypeViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "TypeViewController.h"
#import "Fangtype.h"

@interface TypeViewController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)Fangtype * scrollView;
@property (strong,nonatomic)UIButton * SaveButton;

@end

@implementation TypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"床型";
    [self createUI];
    
}

#pragma mark - UI
-(void)createUI{
    
    
    
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(-59);
    }];
 
    [self.SJScrollView addSubview:self.scrollView];
    self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView.height);
        
    [self.view addSubview:self.SaveButton];
    [self.SaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.left.mas_offset(15);
    }];
    
    
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 761);
    }
    return _SJScrollView;
}
-(Fangtype *)scrollView{
    if (!_scrollView) {
        _scrollView = [[Fangtype alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 761)];
        _scrollView.backgroundColor = MainbackgroundColor;
        //        _scrollView.delagate = self;
        
    }
    return _scrollView;
}
-(UIButton *)SaveButton{
    if (!_SaveButton) {
        _SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveButton.frame = CGRectMake(15,897,ScreenW-30,40);
        _SaveButton.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        [_SaveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_SaveButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_SaveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _SaveButton.layer.cornerRadius = 20;
        
    }
    return _SaveButton;
}
@end
