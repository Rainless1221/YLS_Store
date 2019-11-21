//
//  DetailsAmountView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/24.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DetailsAmountView.h"

@implementation DetailsAmountView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
        // 监听键盘的位置改变
        // 监听键盘的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
#pragma mark -键盘弹出添加监听事件
        // 键盘出现的通知
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
        // 键盘消失的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHiden:) name:UIKeyboardWillHideNotification object:nil];
        
        
        //默认yes
        self.isFirst = YES;
        [self createUI];

    }
    return self;
}
/**
 键盘通知方法
 */
- (void)keyboardWillChangeFrame:(NSNotification *)noty
{
    CGRect keyboardFrame = [noty.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = keyboardFrame.size.height;
    
//    if (self.isFirst) {
//        self.isFirst = NO;
        //设置bottomView的高度为所有控件的高度和空隙之和
        CGRect bottomFrame = self.backView.frame;
        bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.BeiZhu.frame);
        bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
        self.backView.frame = bottomFrame;
//        NSLog(@"   高度 ： %f",self.backView.frame.origin.y)
//    }
    
}
#pragma mark -键盘监听方法
- (void)keyboardWasShown:(NSNotification *)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = keyboardFrame.size.height;
    CGRect bottomFrame = self.backView.frame;
    bottomFrame.size.height = self.keyBoardHeight + CGRectGetMaxY(self.BeiZhu.frame)+20;
    bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
    self.backView.frame = bottomFrame;
//    NSLog(@"   高度 ： %f",self.backView.frame.origin.y)

}
- (void)keyboardWillBeHiden:(NSNotification *)notification{
    
    CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    self.keyBoardHeight = keyboardFrame.size.height;
    CGRect bottomFrame = self.backView.frame;
    bottomFrame.size.height =  CGRectGetMaxY(self.BeiZhu.frame)+154;
    bottomFrame.origin.y = self.bounds.size.height - bottomFrame.size.height;
    self.backView.frame = bottomFrame;
}
#pragma mark - UI
-(void)createUI{
    /*背景view*/
    self.backView = [[UIView alloc] init];
    self.backView.frame = CGRectMake(0,self.bounds.size.height - 358.5,self.bounds.size.width,358.5);
    self.backView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.backView.layer.cornerRadius = 5;
    [self addSubview:self.backView];

    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(50,0,ScreenW-100,50);
    label1.numberOfLines = 0;
    label1.textAlignment = 1;
    label1.text=@"输入退款金额";
    label1.font = [UIFont systemFontOfSize:15];
    label1.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:label1];
 
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [queButton setImage:[UIImage imageNamed:@"suspension_layer_btn_back_normal"] forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(QueAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:queButton];
    [queButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.height.mas_offset(50);
        make.width.mas_offset(50);
    }];
    /*横线*/
    UIView *line1 = [[UIView alloc] init];
    line1.frame = CGRectMake(0,50,ScreenW,0.5);
    line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.backView addSubview:line1];
    
    /*横线*/
    UIView *line2 = [[UIView alloc] init];
    line2.frame = CGRectMake(0,358.5-134,ScreenW,0.5);
    line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.backView addSubview:line2];
   
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(15,50,ScreenW - 30,50);
    label2.numberOfLines = 0;
    label2.text=@"退款金额为商家和用户协商的退款金额";
    label2.font = [UIFont systemFontOfSize:15];
    label2.textColor = UIColorFromRGB(0x222222);
    [self.backView addSubview:label2];

    
    /*金额*/
    self.AmountTF = [[UITextField alloc]initWithFrame:CGRectMake(15, label2.bottom+3, ScreenW - 30, 80)];
    self.AmountTF.font = [UIFont systemFontOfSize:40];
    self.AmountTF.textColor = [UIColor blackColor];
    self.AmountTF.textAlignment = 1;
    self.AmountTF.backgroundColor = UIColorFromRGB(0xF6F6F6);
    self.AmountTF.text = @"¥";
    self.AmountTF.delegate = self;
    self.AmountTF.keyboardType = UIKeyboardTypeDecimalPad;
    [self.backView addSubview:self.AmountTF];
//    [self.AmountTF mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(80);
//        make.bottom.equalTo(self.BeiZhu.mas_top).offset(0);
//    }];
    
    /**备注*/
    self.BeiZhu = [[UITextField alloc]initWithFrame:CGRectMake(15, self.AmountTF.bottom+5, ScreenW-25, 40)];
    self.BeiZhu.font = [UIFont systemFontOfSize:15];
    self.BeiZhu.textColor = [UIColor blackColor];
    self.BeiZhu.placeholder = @"添加退款备注（20字之内）";
    [self.backView addSubview:self.BeiZhu];
//    [self.BeiZhu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(15);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(40);
//        make.bottom.mas_offset(-135);
//    }];
    
    UIButton *TKButton = [UIButton buttonWithType:UIButtonTypeCustom];
    TKButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    TKButton.layer.cornerRadius = 10;
    [TKButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [TKButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    TKButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [TKButton addTarget:self action:@selector(AmountAction) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:TKButton];
    [TKButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
        make.bottom.mas_offset(-40);
    }];
    
   
}
#pragma mark - 退出事件
-(void)QueAction{
    //退出键盘
    [self.AmountTF endEditing:YES];
    [self removeFromSuperview];
}
#pragma mark - 确认退款事件
-(void)AmountAction{
    //退出键盘
    [self.AmountTF endEditing:YES];

    if (self.delagate && [self.delagate respondsToSelector:@selector(AmountConfirm)]) {
        [self.delagate AmountConfirm];
    }

}
#pragma mark - 懒加载
//-(UITextField *)AmountTF{
//    if (!_AmountTF) {
//        _AmountTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 150, 40)];
//        _AmountTF.font = [UIFont systemFontOfSize:40];
//        _AmountTF.textColor = [UIColor blackColor];
//        _AmountTF.textAlignment = 1;
//        _AmountTF.backgroundColor = UIColorFromRGB(0xF6F6F6);
//        _AmountTF.text = @"¥";
//        _AmountTF.delegate = self;
//        _AmountTF.keyboardType = UIKeyboardTypeDecimalPad;
//    }
//    return _AmountTF;
//}
//-(UITextField *)BeiZhu{
//    if (!_BeiZhu) {
//        _BeiZhu = [[UITextField alloc]initWithFrame:CGRectMake(0, 224, 150, 40)];
//        _BeiZhu.font = [UIFont systemFontOfSize:15];
//        _BeiZhu.textColor = [UIColor blackColor];
//        _BeiZhu.placeholder = @"添加退款备注（20字之内）";
//    }
//    return _BeiZhu;
//}
@end
