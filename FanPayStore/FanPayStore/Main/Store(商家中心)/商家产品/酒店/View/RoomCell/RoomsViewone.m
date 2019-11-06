//
//  RoomsViewone.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsViewone.h"

@implementation RoomsViewone

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
    label_1.text = @"房间信息";
    [self addSubview:label_1];
    
    /*line*/
    UIView *line_1 = [[UIView alloc] init];
    line_1.frame = CGRectMake(10,50,self.BaseView_1.width-20,0.5);
    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line_1];
    
    UIView *line_11 = [[UIView alloc] init];
    line_11.frame = CGRectMake(10,line_1.bottom+50,self.BaseView_1.width-20,0.5);
    line_11.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_1 addSubview:line_11];
    
    NSArray *labelArr_1 = @[@"名称",@"面积",@"房间数"];
    
    for (int i =0; i<labelArr_1.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_1[i]];
        [self.BaseView_1 addSubview:label_1];
        
       
        
       
    }
    
    [self.BaseView_1 addSubview:self.Name];
    [self.BaseView_1 addSubview:self.area];
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.area mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(94);
        make.top.equalTo(line_1.mas_bottom).offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    UILabel *label_11 = [[UILabel alloc] init];
    label_11.frame = CGRectMake(self.BaseView_1.right-80,line_1.bottom+19,30,15);
    label_11.numberOfLines = 0;
    label_11.font = [UIFont systemFontOfSize:15];
    label_11.text = @"m2";
    [self.BaseView_1 addSubview:label_11];
    
    UIImageView *icon_1 = [[UIImageView alloc]initWithFrame:CGRectMake(self.BaseView_1.right-30, label_11.centerY, 6, 10)];
    icon_1.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.BaseView_1 addSubview:icon_1];
    
    [self.BaseView_1 addSubview:self.numberButton_1];
    self.numberButton_1.currentNumber = 0;

    [self.numberButton_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_offset(0);
        make.height.mas_offset(50);
        make.width.mas_offset(120);
    }];
    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"其他信息";
    [self addSubview:label_2];
    
    /*line*/
    UIView *line_2 = [[UIView alloc] init];
    line_2.frame = CGRectMake(10,50,self.BaseView_2.width-20,0.5);
    line_2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_2];
    
    UIView *line_22 = [[UIView alloc] init];
    line_22.frame = CGRectMake(10,line_2.bottom+50,self.BaseView_2.width-20,0.5);
    line_22.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView_2 addSubview:line_22];
    
    
    NSArray *labelArr_2 = @[@"床型",@"可住人数",@"卫生间"];
    
    for (int i =0; i<labelArr_2.count; i++) {
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.frame = CGRectMake(10,15+i*50,150,14.5);
        label_1.numberOfLines = 0;
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = [NSString stringWithFormat:@"%@",labelArr_2[i]];
        [self.BaseView_2 addSubview:label_1];
        
    }
    [self.BaseView_2 addSubview:self.Bedtype];
    
    UIImageView *icon_2 = [[UIImageView alloc]initWithFrame:CGRectMake(self.BaseView_2.right-30, self.Bedtype.centerY, 6, 10)];
    icon_2.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [self.BaseView_2 addSubview:icon_2];
    
    
    NSArray *labelArr_22 = @[@"独卫",@"公卫"];
    for (int i =0; i<labelArr_22.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(self.BaseView_2.width-130+i*65, line_22.bottom, 65, 50);
        [button setTitle:[NSString stringWithFormat:@"%@",labelArr_22[i]] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(weiAction:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = i+1;
        [self.BaseView_2 addSubview:button];
        
    }
    
    [self.BaseView_2 addSubview:self.numberButton_2];
    self.numberButton_2.currentNumber = 0;
    
    [self.numberButton_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(0);
        make.bottom.equalTo(line_22.mas_top).offset(0);
        make.height.mas_offset(50);
        make.width.mas_offset(120);
    }];
    
#pragma mark ----------------------
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(15,self.BaseView_2.bottom+20,100,14.5);
    label_3.numberOfLines = 0;
    label_3.text = @"其他信息";
    [self addSubview:label_3];
    
    self.textv = [[XMTextView alloc] initWithFrame:CGRectMake(2, 0, self.BaseView_3.width-4, self.BaseView_3.height)];
    self.textv.placeholder = @"可以详细描述房间的信息，比如位置、装修、便利设施、使用方法、周边风景等等，让用户了解房间的情况";
    self.textv.placeholderColor = UIColorFromRGB(0xCCCCCC);
    self.textv.borderLineColor = [UIColor clearColor];
    self.textv.textColor = UIColorFromRGB(0x222222);
    self.textv.textFont = [UIFont systemFontOfSize:13];
    self.textv.textMaxNum = 500;
    self.textv.maxNumState = XMMaxNumStateNormal;
    [self.BaseView_3 addSubview:self.textv];
    self.textv.textViewListening = ^(NSString *textViewStr) {
        NSLog(@"tv2监听输入的内容：%@",textViewStr);
        
    };
    
    
    
}
/*选择床型*/
-(void)BedAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(BedAtion:)]) {
        [self.delagate BedAtion:sender];
    }
}
/*选卫生间*/
-(void)weiAction:(UIButton *)sender{
    sender.selected = !sender.selected;
}

#pragma mark - PPNumberButtonDelegate
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    if (numberButton == self.numberButton_1) {
        NSLog(@"添加房间数 == %ld",number);
        if (number == 0) {
            _numberButton_1.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
        }else{
            _numberButton_1.decreaseImage = [UIImage imageNamed:@"btn_delete_shop_info_image_normal"];
        }
    }else{
        NSLog(@"添加人数      == %ld",number);
        if (number == 0) {
            _numberButton_2.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
        }else{
            _numberButton_2.decreaseImage = [UIImage imageNamed:@"btn_delete_shop_info_image_normal"];
        }
    }
    
//    _model.number = number;
}

#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 151)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
        _BaseView_1.layer.cornerRadius = 5;
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 151)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
        _BaseView_2.layer.cornerRadius = 5;
    }
    return _BaseView_2;
}
-(UIView *)BaseView_3{
    if (!_BaseView_3) {
        _BaseView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_2.bottom+49, ScreenW-30, 180)];
        _BaseView_3.backgroundColor = [UIColor whiteColor];
        _BaseView_3.layer.cornerRadius = 5;
    }
    return _BaseView_3;
}
-(UITextField *)Name{
    if (!_Name) {
        _Name = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _Name.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _Name.font = [UIFont systemFontOfSize:14];
        _Name.placeholder = @"请输入房间名称";
    }
    return _Name;
}
-(UITextField *)area{
    if (!_area) {
        _area = [[UITextField alloc]initWithFrame:CGRectMake(94, 0, self.BaseView_1.width-104, 50)];
        _area.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _area.font = [UIFont systemFontOfSize:14];
        _area.placeholder = @"请输入房间面积";
    }
    return _area;
}
-(UIButton *)Bedtype{
    if (!_Bedtype) {
        _Bedtype = [UIButton buttonWithType:UIButtonTypeCustom];
        _Bedtype.frame   =CGRectMake(94, 0, self.BaseView_1.width-94, 50);
        [_Bedtype setTitleColor:[UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0] forState:UIControlStateNormal];
        [_Bedtype setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateSelected];
        [_Bedtype.titleLabel setFont:[UIFont systemFontOfSize:15]];
        [_Bedtype setTitle:@"请选择床型" forState:UIControlStateNormal];
        _Bedtype.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
        
        [_Bedtype addTarget:self action:@selector(BedAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Bedtype;
}
- (PPNumberButton *)numberButton_1
{
    if (!_numberButton_1) {
        _numberButton_1 = [PPNumberButton numberButtonWithFrame:CGRectMake(0, 0, 150, 50)];
        _numberButton_1.delegate = self;
        // 初始化时隐藏减按钮
        _numberButton_1.decreaseHide = NO;
        _numberButton_1.increaseImage = [UIImage imageNamed:@"increase_eleme"];
        _numberButton_1.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
        
        _numberButton_1.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            NSLog(@"%f",number);
        };
    }
    return _numberButton_1;
}
- (PPNumberButton *)numberButton_2
{
    if (!_numberButton_2) {
        _numberButton_2 = [PPNumberButton numberButtonWithFrame:CGRectMake(0, 0, 150, 50)];
        _numberButton_2.delegate = self;
        // 初始化时隐藏减按钮
        _numberButton_2.decreaseHide = NO;
        _numberButton_2.increaseImage = [UIImage imageNamed:@"increase_eleme"];
        _numberButton_2.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];

        _numberButton_2.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
//            NSLog(@"%ld",number);
        };
    }
    return _numberButton_2;
}
@end
