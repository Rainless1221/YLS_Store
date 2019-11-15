//
//  WithdrawView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "WithdrawView.h"

@implementation WithdrawView
-(instancetype)initWithFrame:(CGRect)frame{
    if( self== [super initWithFrame:frame]){
        self = [[[NSBundle mainBundle] loadNibNamed:@"WithdrawView"owner:self options:nil]lastObject];
        self.frame = frame;
    }
    return self;

}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    //可提现模块
    self.DangqiImage.frame = CGRectMake(10, 15, ScreenW - 20, 170);
    self.dangqiLabel.frame = CGRectMake(31, 45, 150, 25);
    self.dangqiM.frame = CGRectMake(31, self.dangqiLabel.bottom+30, ScreenW - 50, 40);
    //提现模块
    self.shuruView.frame = CGRectMake(10, self.DangqiImage.bottom+12, ScreenW - 20, 192);
    self.lable1.frame = CGRectMake(10, 18, 150, 15);
    [self.lable1 sizeToFit];
    self.fuwu.frame = CGRectMake(self.lable1.right+5, 18, self.shuruView.width-150, 15);
    self.tupiao1.frame = CGRectMake(10, self.lable1.bottom+20, 25, 25);
    self.henxi.frame = CGRectMake(10, self.tupiao1.bottom+13, ScreenW - 40, 1);
    self.henxi.backgroundColor = UIColorFromRGB(0xEAEAEA);
    
    self.tupiao2.frame = CGRectMake(10, self.henxi.bottom+13, 25, 25);
    self.tupiao3.frame = CGRectMake(self.shuruView.width -20, self.tupiao1.top, 10, 25);
    /*银行卡展示*/
    self.cardTextButton.frame = CGRectMake(self.tupiao1.right+10, self.tupiao1.top, self.shuruView.width - self.tupiao1.right , 25);
    [self.cardTextButton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    self.cardTextButton.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.JEField.frame = CGRectMake(self.tupiao2.right+10, self.tupiao2.top,self.cardTextButton.width-10, 25);
    self.JEField.clearButtonMode = UITextFieldViewModeWhileEditing;
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, self.JEField.bottom+10, self.shuruView.width-20, 1)];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.shuruView addSubview:line];
    
    
    self.fuwuLabel.frame = CGRectMake(10, line.bottom, self.shuruView.width-80, 44);
//    self.fuwuLabel.text = @"可提现金额 0元";
    self.fuwuLabel.textColor =UIColorFromRGBA(0xCCCCCC, 1);
    
    self.allButton.frame =CGRectMake(self.shuruView.width - 55, line.bottom, 45, 44);

    
    //提示与按钮
    self.tishi.frame = CGRectMake(10, self.shuruView.bottom+10, ScreenW - 20, 20);
    
    
    self.notarizeButton.frame = CGRectMake(15, self.tishi.bottom + 15, ScreenW - 30, 44);

    
    self.NotButton.frame = self.notarizeButton.frame;

    [self addSubview:self.NotButton];

    
#pragma mark - 提示
    self.TisiLabel1.frame = CGRectMake(15, self.notarizeButton.bottom+48, 150, 18);
    
    self.Tisiimag1.frame = CGRectMake(16, self.TisiLabel1.bottom+15, 10, 10);
    self.TisiLabel2.frame = CGRectMake(30, self.TisiLabel1.bottom+15, 150, 15);
    self.TisiLabel3.frame = CGRectMake(30, self.TisiLabel2.bottom, ScreenW-60, 30);
    
    self.Tisiimag2.frame = CGRectMake(16, self.TisiLabel3.bottom+17, 10, 10);
    self.TisiLabel4.frame = CGRectMake(30, self.TisiLabel3.bottom+15, 150, 15);
    self.TisiLabel5.frame = CGRectMake(30, self.TisiLabel4.bottom, ScreenW-60, 37);
    
    self.Tisiimag3.frame = CGRectMake(16, self.TisiLabel5.bottom+17, 10, 10);
    self.TisiLabel6.frame = CGRectMake(30, self.TisiLabel5.bottom+15, 150, 15);
    self.TisiLabel7.frame = CGRectMake(30, self.TisiLabel6.bottom, ScreenW-55, 45);
    
    self.Tisiimag4.frame = CGRectMake(16, self.TisiLabel7.bottom+17, 10, 10);
    self.TisiLabel8.frame = CGRectMake(30, self.TisiLabel7.bottom+15, 150, 15);
    self.TisiLabel9.frame = CGRectMake(30, self.TisiLabel8.bottom+7, ScreenW-45, 50);
    
    /** 设置相关 */
    self.JEField.keyboardType = UIKeyboardTypeDecimalPad;
    
}
//确认
- (IBAction)notarizeAction:(UIButton *)sender {
    
    if (self.notarizeBlock) {
        self.notarizeBlock();
    }
    
}
/** 选择银行卡 **/
- (IBAction)CardAction:(id)sender {
    if (self.CardBlock) {
        self.CardBlock();
    }
}
//全部
- (IBAction)allAction:(id)sender {
    if (self.allBlock) {
        self.allBlock();
    }
}

#pragma mark - 懒加载
-(UIButton *)NotButton{
    if (!_NotButton) {
        _NotButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _NotButton.frame = self.notarizeButton.frame;
        _NotButton.width = ScreenW-30;
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,ScreenW-30,44);
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//        gl.locations = @[@(0.0),@(0.5),@(1.0)];
//        gl.cornerRadius = 10;
//        [_NotButton.layer addSublayer:gl];
//
//        _NotButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//        _NotButton.layer.shadowOffset = CGSizeMake(0,1);
//        _NotButton.layer.shadowOpacity = 1;
//        _NotButton.layer.shadowRadius = 9;
       _NotButton.layer.cornerRadius = 10;
        _NotButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [_NotButton setTitle:@"确认提现" forState:UIControlStateNormal];
        [_NotButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_NotButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        [_NotButton addTarget:self action:@selector(notarizeAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _NotButton;
}
@end
