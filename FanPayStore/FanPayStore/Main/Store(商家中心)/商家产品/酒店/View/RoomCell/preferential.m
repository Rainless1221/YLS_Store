//
//  preferential.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "preferential.h"

@implementation preferential

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
    label_1.frame = CGRectMake(15,20,200,14.5);
    label_1.numberOfLines = 0;
    label_1.text = @"设置优惠，获得更多订单";
    [self addSubview:label_1];
    
    
    
    NSArray *labelArr_1 = @[@"连住优惠"];
    
    for (int i =0; i<labelArr_1.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_1[i]];
        [self.BaseView_1 addSubview:label_1];
        
        
    }
    
    
    
#pragma mark ----------------------
   
    
    NSArray *labelArr_2 = @[@"新房特惠"];
    
    for (int i =0; i<labelArr_2.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_2[i]];
        [self.BaseView_2 addSubview:label_1];
        
        
    }
    
#pragma mark ----------------------
    
    NSArray *labelArr_3 = @[@"今夜特价"];
    
    for (int i =0; i<labelArr_3.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_3[i]];
        [self.BaseView_3 addSubview:label_1];
        
        
    }
    
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 60)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
        _BaseView_1.layer.cornerRadius = 5;
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+15, ScreenW-30, 60)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
        _BaseView_2.layer.cornerRadius = 5;
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+15, ScreenW-30, 60)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
        _BaseView_3.layer.cornerRadius = 5;
    }
    return _BaseView_3;
}

@end
