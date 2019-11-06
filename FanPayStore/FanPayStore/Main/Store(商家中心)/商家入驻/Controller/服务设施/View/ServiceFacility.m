//
//  ServiceFacility.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ServiceFacility.h"

@implementation ServiceFacility

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


    UILabel *Textlable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    Textlable.font = [UIFont systemFontOfSize:15];
    Textlable.textColor = UIColorFromRGB(0x222222);
    Textlable.text = @"酒店服务";
    [self.BaseView_1 addSubview:Textlable];
    
    /*line*/
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, Textlable.bottom, self.width-20, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line];
    
    
    UILabel *Textlable_1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    Textlable_1.font = [UIFont systemFontOfSize:15];
    Textlable_1.textColor = UIColorFromRGB(0x222222);
    Textlable_1.text = @"公共设施";
    [self.BaseView_2 addSubview:Textlable_1];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, Textlable_1.bottom, self.width-20, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line1];
    
    
    
    
    NSArray *arr = @[@"免费停车",@"24小时服务",@"行李寄存",@"洗衣服务",@"票务服务",@"送餐服务",@"租车"];
    for (int i =0; i<arr.count; i++) {
        NSInteger y = i/2;
        NSInteger x = i%2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+x*self.BaseView_1.width/2, line.bottom +y*35+15, self.BaseView_1.width/2, 35);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
        NSString *buttiti= [NSString stringWithFormat:@"%@",arr[i]];
        [button setTitle:buttiti forState:UIControlStateNormal];
        [button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.BaseView_1 addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;

    }
    
    
    NSArray *arr1 = @[@"前台",@"咖啡厅",@"会议室",@"健身房",@"大堂吧",@"游泳池",@"行政酒廊",@"自助厨房",@"保险柜",@"自动取款机",@"电梯"];
    for (int i =0; i<arr1.count; i++) {
        NSInteger y = i/2;
        NSInteger x = i%2;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(10+x*self.BaseView_1.width/2, line1.bottom +y*35+15, self.BaseView_1.width/2, 35);
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        [button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
        NSString *buttiti= [NSString stringWithFormat:@"%@",arr1[i]];
        [button setTitle:buttiti forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+20;
        
        [self.BaseView_2 addSubview:button];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
    }
    
}
#pragma mark - 选择
-(void)ButtonAction:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Facility: and:)]) {
        [self.delagate Facility:self and:sender];
    }
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, 255)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(0, self.BaseView_1.bottom+15, self.width, 347)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_2;
}
@end
