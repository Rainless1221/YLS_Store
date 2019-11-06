//
//  RoomsViewtwo.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsViewtwo.h"

@implementation RoomsViewtwo

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    [self addSubview:self.BaseView_1];
    [self addSubview:self.BaseView_2];
    [self addSubview:self.BaseView_3];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15,20,100,14.5);
    label_1.numberOfLines = 0;
    label_1.text = @"设施";
    [self addSubview:label_1];
    
    NSArray *Arr_1= @[@"WIFI",@"有线网络",@"停车位",@"健身房",@"门禁系统",@"电梯",@"书桌/工作台",@"阳台/露台",@"公园",@"菜市场",@"游泳池",@"会议室"];
    for (int i =0; i<Arr_1.count; i++) {
        int x = i%2;
        int y = i/2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(self.BaseView_1.width-20)/2*x, 20+40*y, (self.BaseView_1.width-20)/2, 40);
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@" %@",Arr_1[i]] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
        [button addTarget:self action:@selector(SetupAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.BaseView_1 addSubview:button];
    }
    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"卫浴";
    [self addSubview:label_2];
    
    NSArray *Arr_2= @[@"热水淋浴",@"浴缸",@"牙刷",@"毛巾",@"浴巾",@"拖鞋",@"沐浴露/洗发水"];
    for (int i =0; i<Arr_2.count; i++) {
        int x = i%2;
        int y = i/2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(self.BaseView_1.width-20)/2*x, 20+40*y, (self.BaseView_1.width-20)/2, 40);
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@" %@",Arr_2[i]] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
        [button addTarget:self action:@selector(SetupAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.BaseView_2 addSubview:button];
    }
    
    
#pragma mark ----------------------
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(15,self.BaseView_2.bottom+20,100,14.5);
    label_3.numberOfLines = 0;
    label_3.text = @"客房服务";
    [self addSubview:label_3];
    
    NSArray *Arr_3= @[@"24小时入住",@"自助入住",@"早餐",@"床品每客更换",@"接送机"];
    for (int i =0; i<Arr_3.count; i++) {
        int x = i%2;
        int y = i/2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+(self.BaseView_1.width-20)/2*x, 20+40*y, (self.BaseView_1.width-20)/2, 40);
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [button setTitle:[NSString stringWithFormat:@" %@",Arr_3[i]] forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
        [button addTarget:self action:@selector(SetupAction:) forControlEvents:UIControlEventTouchUpInside];

        [self.BaseView_3 addSubview:button];
    }
    
}
/*选择*/
-(void)SetupAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 296)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 204)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+49, ScreenW-30, 158)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_3;
}

@end
