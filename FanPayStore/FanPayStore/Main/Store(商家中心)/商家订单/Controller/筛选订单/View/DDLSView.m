//
//  DDLSView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/1.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "DDLSView.h"

@implementation DDLSView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect {
    CGFloat Btn_W = (self.width-45)/4;
    
    self.Label1.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label1.frame = CGRectMake(15, self.TextLbel.bottom+15, Btn_W, 50);
    self.Label2.frame = CGRectMake(self.Label1.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Label3.frame = CGRectMake(self.Label2.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Label4.frame = CGRectMake(self.Label3.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Label5.frame = CGRectMake(15, self.Label1.bottom+15, Btn_W, 50);
    self.Label6.frame = CGRectMake(self.Label5.right+5, self.Label1.bottom+15, Btn_W, 50);
    
    self.Button1.frame = CGRectMake(15, self.TextLbel.bottom+15, Btn_W, 50);
    self.Button2.frame = CGRectMake(self.Button1.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Button3.frame = CGRectMake(self.Button2.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Button4.frame = CGRectMake(self.Button3.right+5, self.TextLbel.bottom+15, Btn_W, 50);
    self.Button5.frame = CGRectMake(15, self.Button1.bottom+15, Btn_W, 50);
    self.Button6.frame = CGRectMake(self.Button5.right+5, self.Button1.bottom+15, Btn_W, 50);
}
#pragma mark - 选择方式

- (IBAction)BtnAction1:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label2.textColor = UIColorFromRGB(0x222222);
    self.Label3.textColor = UIColorFromRGB(0x222222);
    self.Label4.textColor = UIColorFromRGB(0x222222);
    self.Label5.textColor = UIColorFromRGB(0x222222);
    self.Label6.textColor = UIColorFromRGB(0x222222);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
    
}
- (IBAction)BtnAction2:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0x222222);
    self.Label2.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label3.textColor = UIColorFromRGB(0x222222);
    self.Label4.textColor = UIColorFromRGB(0x222222);
    self.Label5.textColor = UIColorFromRGB(0x222222);
    self.Label6.textColor = UIColorFromRGB(0x222222);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
}
- (IBAction)BtnAction3:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0x222222);
    self.Label2.textColor = UIColorFromRGB(0x222222);
    self.Label3.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label4.textColor = UIColorFromRGB(0x222222);
    self.Label5.textColor = UIColorFromRGB(0x222222);
    self.Label6.textColor = UIColorFromRGB(0x222222);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
}
- (IBAction)BtnAction4:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0x222222);
    self.Label2.textColor = UIColorFromRGB(0x222222);
    self.Label3.textColor = UIColorFromRGB(0x222222);
    self.Label4.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label5.textColor = UIColorFromRGB(0x222222);
    self.Label6.textColor = UIColorFromRGB(0x222222);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
}
- (IBAction)BtnAction5:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0x222222);
    self.Label2.textColor = UIColorFromRGB(0x222222);
    self.Label3.textColor = UIColorFromRGB(0x222222);
    self.Label4.textColor = UIColorFromRGB(0x222222);
    self.Label5.textColor = UIColorFromRGB(0xF7AE2B);
    self.Label6.textColor = UIColorFromRGB(0x222222);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
}
- (IBAction)BtnAction6:(UIButton *)sender {
    self.Label1.textColor = UIColorFromRGB(0x222222);
    self.Label2.textColor = UIColorFromRGB(0x222222);
    self.Label3.textColor = UIColorFromRGB(0x222222);
    self.Label4.textColor = UIColorFromRGB(0x222222);
    self.Label5.textColor = UIColorFromRGB(0x222222);
    self.Label6.textColor = UIColorFromRGB(0xF7AE2B);
    
    for (int i = 0; i<6; i++) {
        if (sender.tag == i+10) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+10];
        but.selected = NO;
    }
    if (self.KuaiTimeBlock) {
        self.KuaiTimeBlock(sender);
    }
}



//开始时间
- (IBAction)KStimeAction:(UIButton *)sender {
    if (self.TimeBlock) {
        self.TimeBlock(sender);
    }
}

//截止时间
- (IBAction)JZtimeAction:(UIButton *)sender {
    if (self.TimeBlock) {
        self.TimeBlock(sender);
    }
}

//确定开始筛选

- (IBAction)Begin_dateAction:(UIButton *)sender {
    if (self.DataTimeBlock) {
        self.DataTimeBlock();
    }
    
}

@end
