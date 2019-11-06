//
//  FeedbackViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Feedback_View.h"

@interface FeedbackViewController ()
@property (strong,nonatomic)UIScrollView * ScrollView;
@property (strong,nonatomic)Feedback_View * feedbckView;
@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家反馈";

    [self createUI];
}
#pragma mark - UI
-(void)createUI{
     [self.view addSubview:self.ScrollView];
    [self.ScrollView addSubview:self.feedbckView];
    
    //提交按钮
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setTitle:@"提交" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Button.backgroundColor = UIColorFromRGB(0xF7AE2B);
    Button.titleLabel.font = [UIFont systemFontOfSize:18];
    Button.layer.cornerRadius = 10;
    [self.view addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 40));
    }];
}

#pragma mark - 懒加载
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-50)];
        _ScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 680);
    }
    return _ScrollView;
}
-(Feedback_View *)feedbckView{
    if (!_feedbckView) {
        _feedbckView = [[Feedback_View alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
    }
    return _feedbckView;
}
@end
