//
//  RevenueHeaderM.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "RevenueHeaderM.h"

@implementation RevenueHeaderM
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.TimeButton];
        [self.TimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.mas_offset(0);
            make.width.mas_offset(110);
        }];
        
        
        NSArray *ButtonArr = @[@"返佣",@"营收",@"全部"];
        for (int i = 0; i<ButtonArr.count; i++) {
            UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
            [Button setTitle:[NSString stringWithFormat:@"%@",ButtonArr[i]] forState:UIControlStateNormal];
            [Button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
            [Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateSelected];
            [Button.titleLabel setFont:[UIFont systemFontOfSize:14]];
            [Button addTarget:self action:@selector(TyAction:) forControlEvents:UIControlEventTouchUpInside];
            Button.tag = i+1;
            [self addSubview:Button];
            [Button mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(0);
                make.bottom.mas_offset(-5);
                make.right.mas_offset(-(120/3)*i-12);
                make.width.mas_offset(40);
            }];
            if (i == 2) {
                UIView *line = [[UIView alloc]initWithFrame:CGRectMake(ScreenW - ((120/3)*3+8), self.height - 18, 32, 2)];
                line.backgroundColor = UIColorFromRGB(0xF7AE2B);
//                line.centerX = Button.centerX;
                [self addSubview:line];
                self.line = line;
                Button.selected = YES;
            }
            
            
        }
        
        
        
        
    }
    return self;
}
#pragma mark - 时间选择
-(void)TimeAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(DateAction)]) {
        [self.delagate DateAction];
    }
}
#pragma mark - 类型
-(void)TyAction:(UIButton *)sender{

    for (int i = 1; i<4; i++) {
        
        if (sender.tag == i) {
            sender.selected = YES;
            self.line.centerX = sender.centerX;
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i];
        but.selected = NO;
 
    }
    if (self.delagate && [self.delagate respondsToSelector:@selector(RevenueButton:)]) {
        [self.delagate RevenueButton:sender.tag];
    }
    
}

#pragma mark - GET
- (FL_Button *)TimeButton{
    if (!_TimeButton) {
        _TimeButton = [FL_Button buttonWithType:UIButtonTypeCustom];
        _TimeButton.status = FLAlignmentStatusCenter;
        _TimeButton.fl_padding = 5;
//        [_TimeButton setTitle:@"2018年12月" forState:UIControlStateNormal];
        [_TimeButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        [_TimeButton setImage:[UIImage imageNamed:@"ico_arrow_down_blue"] forState:UIControlStateNormal];
        [_TimeButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [_TimeButton addTarget:self action:@selector(TimeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TimeButton;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
