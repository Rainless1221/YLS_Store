//
//  Suspended_View.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Suspended_View.h"

@implementation Suspended_View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    UIView *base_view = [[UIView alloc] init];
    base_view.frame = CGRectMake(25,134.5,325,398);
    base_view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    base_view.layer.cornerRadius = 6;
    [self addSubview:base_view];
    [base_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-50, 398));
    }];
    
    
    //line
    UIView *line_view = [[UIView alloc] init];
    line_view.frame = CGRectMake(25,482,325,0.5);
    line_view.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    [base_view addSubview:line_view];
    [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-50);
        make.height.mas_offset(0.5);
    }];
    
    
    
    //按钮
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"我知道了" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:16];
    [base_view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    
    //icon
    UIImageView *icon= [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"icn_store_medium"];
    [base_view addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.mas_offset(30);
        make.size.mas_offset(CGSizeMake(160, 160));
    }];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(122,350.5,70.5,17);
    label_1.numberOfLines = 0;
    label_1.text = @"营业状态";
    label_1.font = [UIFont systemFontOfSize:18];
    [base_view addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(26);
        make.centerX.mas_offset(-50);
    }];
    
    UILabel *label_Z = [[UILabel alloc] init];
    label_Z.frame = CGRectMake(122,350.5,70.5,17);
    label_Z.numberOfLines = 0;
    label_Z.textAlignment = 1;
    label_Z.text = @"暂停合作";
    label_Z.font = [UIFont systemFontOfSize:12];
    label_Z.textColor = UIColorFromRGB(0x666666);
    label_Z.backgroundColor = UIColorFromRGB(0xEDEDED);
    label_Z.layer.borderWidth =1;
    label_Z.layer.borderColor = UIColorFromRGB(0xDADADA).CGColor;
    label_Z.layer.cornerRadius = 9;
    label_Z.layer.masksToBounds = YES;

    [base_view addSubview:label_Z];
    [label_Z mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon.mas_bottom).offset(26);
        make.centerX.mas_offset(50);
        make.size.mas_offset(CGSizeMake(65, 18));
    }];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(122,350.5,70.5,17);
    label_2.numberOfLines = 1;
    label_2.textAlignment = 1;
    label_2.text = @"当前店铺的营业状态为暂停合作";
    label_2.font = [UIFont systemFontOfSize:13];
    label_2.textColor = UIColorFromRGB(0x666666);
    [base_view addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_1.mas_bottom).offset(45);
        make.left.right.mas_offset(0);
    }];
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(122,350.5,70.5,17);
    label_3.numberOfLines = 1;
    label_3.textAlignment = 1;
    label_3.text = @"如有疑问，请前往商家反馈，提交申述";
    label_3.font = [UIFont systemFontOfSize:13];
    label_3.textColor = UIColorFromRGB(0x666666);
    [base_view addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_2.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
    }];
    
}
-(void)buttonAction{
    [self removeFromSuperview];
}

@end
