//
//  PreferlistHeader.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PreferlistHeader.h"

@implementation PreferlistHeader

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = UIColorFromRGB(0xF6F6F6);
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.baseView_1];
    [self addSubview:self.baseView_2];
    [self addSubview:self.baseView_3];

    
    NSArray *SArray = @[@"全部",@"进行中",@"已结束",@"未开始 "];
    self.SArrayTag = @[@"1",@"2",@"3",@"4"];

    CGFloat Bwidth = (ScreenW-60)/4;

    
    for (int i =0; i<SArray.count; i++) {
        
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(i*(Bwidth+5), 0, Bwidth, 50);
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",SArray[i]] forState:UIControlStateNormal];

        [thirdBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.baseView_1 addSubview:thirdBtn];
        NSString *tagint = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];
        thirdBtn.tag = [tagint integerValue]+10;
        
        if (i==0) {
            thirdBtn.selected = YES;
            
            UIView *view_line = [[UIView alloc] init];
            view_line.frame = CGRectMake(thirdBtn.left,thirdBtn.bottom-2,20,2);
            view_line.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
            view_line.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.4].CGColor;
            view_line.layer.shadowOffset = CGSizeMake(0,1);
            view_line.layer.shadowOpacity = 1;
            view_line.layer.shadowRadius = 3;
            view_line.layer.cornerRadius = 1;
            view_line.centerX = thirdBtn.centerX;
            self.view_line = view_line;
            [self.baseView_1 addSubview:view_line];
        }
        
    }
    
#pragma mark - 统计
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,10,120,13.5);
    label.numberOfLines = 0;
    label.text = @"活动统计";
    label.font = [UIFont systemFontOfSize:14];
    [self.baseView_2 addSubview:label];
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 22, 22)];
    icon.image = [UIImage imageNamed:@"icn_acti_index_up"];
    [self.baseView_2 addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(22, 22));
    }];
    
//    UILabel *label_2 = [[UILabel alloc] init];
//    label_2.frame = CGRectMake(10,33,200,11.5);
//    label_2.numberOfLines = 0;
//    label_2.text = @"截止：";
//    label_2.font = [UIFont systemFontOfSize:12];
//    label_2.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
//    [label_2 sizeToFit];
    [self.baseView_2 addSubview:self.expiry_date];
    
    UILabel *label_22 = [[UILabel alloc] init];
    label_22.frame = CGRectMake(10,72,100,11.5);
    label_22.numberOfLines = 0;
    label_22.text = @"订单数";
    label_22.font = [UIFont systemFontOfSize:12];
    label_22.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [label_22 sizeToFit];
    [self.baseView_2 addSubview:label_22];
    
    UILabel *label_222 = [[UILabel alloc] init];
    label_222.frame = CGRectMake(91,72,100,11.5);
    label_222.numberOfLines = 0;
    label_222.text = @"成交额";
    label_222.font = [UIFont systemFontOfSize:12];
    label_222.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    [label_222 sizeToFit];
    [self.baseView_2 addSubview:label_222];
    
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(80,70,1,30);
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.baseView_2 addSubview:line];
    
    
    
    [self.baseView_2 addSubview:self.order_num];
    [self.baseView_2 addSubview:self.order_amount];
    


#pragma mark - 添加
    
    UILabel *label_add = [[UILabel alloc] init];
    label_add.frame = CGRectMake(0,79,120,13.5);
    label_add.numberOfLines = 0;
    label_add.text = @"新增活动 ";
    label_add.textAlignment = 1;
    label_add.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_add.font = [UIFont systemFontOfSize:14];
    [self.baseView_3 addSubview:label_add];
    
    UIImageView *icon_add = [[UIImageView alloc]initWithFrame:CGRectMake(44, 27, 32, 32)];
    icon_add.image = [UIImage imageNamed:@"icn_acti_plus_blue"];
    [self.baseView_3 addSubview:icon_add];
    
    
    
    UILabel *label_list = [[UILabel alloc] init];
    label_list.frame = CGRectMake(16,223,200,13.5);
    label_list.numberOfLines = 0;
    label_list.text=@"活动列表";
    label_list.font = [UIFont systemFontOfSize:14];
    [self addSubview:label_list];
    
}
-(void)event:(UITapGestureRecognizer *)gesture{
    if (self.addActionBlock) {
        self.addActionBlock();
    }
}
-(void)MerchantButton:(UIButton *)sender{
    for (int i = 0; i<self.SArrayTag.count; i++) {
        NSString *tagstr = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];
        
        if (sender.tag == [tagstr integerValue]+10) {
            sender.selected = YES;
            self.view_line.centerX = sender.centerX;
            
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:[tagstr integerValue]+10];
        but.selected = NO;
    }
    
    NSString *tagstr = [NSString stringWithFormat:@"%ld",(long)sender.tag-10];
    if (self.Menublock) {
        self.Menublock(tagstr);
    }
}
- (void)setIsSelete:(NSInteger)isSelete{
    
    
    for (int i = 0; i<self.SArrayTag.count; i++) {
        NSString *tagstr = [NSString stringWithFormat:@"%@",self.SArrayTag[i]];
        
        if ([tagstr integerValue] == isSelete) {
            UIButton *but = (UIButton *)[self viewWithTag:isSelete+10];
            but.selected = YES;
            self.view_line.centerX = but.centerX;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:[tagstr integerValue]+10];
        but.selected = NO;
    }
    
}

#pragma mark 赋值
-(void)setData:(NSDictionary *)Data{
    //截止日期
    NSString *expiry = [NSString stringWithFormat:@"%@",Data[@"expiry_date"]];
    NSArray *array = [expiry componentsSeparatedByString:@" "];
    self.expiry_date.text = [NSString stringWithFormat:@"%@",array[0]];
    //订单数
    self.order_num.text = [NSString stringWithFormat:@"%@",Data[@"order_num"]];
    //成交额 订单金额
    self.order_amount.text = [NSString stringWithFormat:@"%@",Data[@"order_amount"]];
    
}
#pragma mark 懒加载
-(UIView *)baseView_1{
    if (!_baseView_1) {
        _baseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 50)];
        _baseView_1.backgroundColor = [UIColor whiteColor];
        _baseView_1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
        _baseView_1.layer.shadowOffset = CGSizeMake(0,2);
        _baseView_1.layer.shadowOpacity = 1;
        _baseView_1.layer.shadowRadius = 12;
        _baseView_1.layer.cornerRadius = 5;
    }
    return _baseView_1;
}
-(UIView *)baseView_2{
    if (!_baseView_2) {
        _baseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, 84, autoScaleW(215), autoScaleW(120))];
        _baseView_2.backgroundColor = [UIColor whiteColor];
        _baseView_2.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
        _baseView_2.layer.shadowOffset = CGSizeMake(0,2);
        _baseView_2.layer.shadowOpacity = 1;
        _baseView_2.layer.shadowRadius = 12;
        _baseView_2.layer.cornerRadius = 5;
    }
    return _baseView_2;
}
-(UIView *)baseView_3{
    if (!_baseView_3) {
        _baseView_3 = [[UIView alloc]initWithFrame:CGRectMake(self.baseView_2.right+10, 84, autoScaleW(120), autoScaleW(120))];
        _baseView_3.backgroundColor = [UIColor whiteColor];
        _baseView_3.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.06].CGColor;
        _baseView_3.layer.shadowOffset = CGSizeMake(0,2);
        _baseView_3.layer.shadowOpacity = 1;
        _baseView_3.layer.shadowRadius = 12;
        _baseView_3.layer.cornerRadius = 5;
        _baseView_3.userInteractionEnabled = YES;
        UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(event:)];
        [tapGesture setNumberOfTapsRequired:1];
        [_baseView_3 addGestureRecognizer:tapGesture];
    }
    return _baseView_3;
}
-(UILabel *)expiry_date{
    if (!_expiry_date) {
        _expiry_date = [[UILabel alloc] init];
        _expiry_date.frame = CGRectMake(10,33,200,11.5);
        _expiry_date.numberOfLines = 0;
        _expiry_date.text = @"截止：";
        _expiry_date.font = [UIFont systemFontOfSize:12];
        _expiry_date.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1.0];
    }
    return _expiry_date;
}
-(UILabel *)order_num{
    if (!_order_num) {
        _order_num = [[UILabel alloc] init];
        _order_num.frame = CGRectMake(10,93,80,10);
        _order_num.numberOfLines = 0;
        _order_num.font = [UIFont systemFontOfSize:14];
        _order_num.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    }
    return _order_num;
}
-(UILabel *)order_amount{
    if (!_order_amount) {
        _order_amount = [[UILabel alloc] init];
        _order_amount.frame = CGRectMake(92,93,140,10);
        _order_amount.numberOfLines = 0;
        _order_amount.font = [UIFont systemFontOfSize:14];
        _order_amount.textColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:42/255.0 alpha:1.0];
    }
    return _order_amount;
}
@end
