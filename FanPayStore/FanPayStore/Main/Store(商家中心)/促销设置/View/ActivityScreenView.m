//
//  ActivityScreenView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/29.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ActivityScreenView.h"

@implementation ActivityScreenView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.Screenbutton];
        [self.Screenbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(autoScaleW(15));
            make.right.mas_offset(-15);
            make.width.mas_offset(autoScaleW(115));
            make.height.mas_offset(28);
        }];
        
    }
    return self;
}
#pragma mark ---  ---
-(void)ScreenAction{
    
    self.Activity_Pop.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.Activity_Pop.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.25];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(autoScaleW(245),117+(kIs_iPhoneX ? 22:0),autoScaleW(115),91);
    view.backgroundColor = [UIColor colorWithRed:235/255.0 green:243/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 8;
    
    view.layer.borderWidth = 1;
    view.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
    
    /*line*/
    UIView *view_line = [[UIView alloc] init];
    view_line.frame = CGRectMake(0,30,view.width,1);
    view_line.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
    [view addSubview:view_line];
    
    UIView *view_line1 = [[UIView alloc] init];
    view_line1.frame = CGRectMake(0,60,view.width,1);
    view_line1.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
    [view addSubview:view_line1];
    
    /* 按钮*/
    FL_Button *allButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    allButton.frame = CGRectMake(0, 0, view.width, 30);
    [allButton setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
    [allButton setTitle:@"全部活动" forState:UIControlStateNormal];
    [allButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [allButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    allButton.status = FLAlignmentStatusCenter;
    allButton.fl_padding = 13;
    [allButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    allButton.tag = 1;

    [view addSubview:allButton];
    
    
    FL_Button *ongoingButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    ongoingButton.frame = CGRectMake(0, view_line.bottom, view.width, 30);
    [ongoingButton setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
    [ongoingButton setTitle:@"进行中活动" forState:UIControlStateNormal];
    [ongoingButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [ongoingButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    ongoingButton.status = FLAlignmentStatusCenter;
    ongoingButton.fl_padding = 6;
    [ongoingButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    ongoingButton.tag = 2;

    [view addSubview:ongoingButton];
    
    
    
    FL_Button *HasEndedButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    HasEndedButton.frame = CGRectMake(0, view_line1.bottom, view.width, 30);
    [HasEndedButton setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
    [HasEndedButton setTitle:@"已结束活动" forState:UIControlStateNormal];
    [HasEndedButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(15)]];
    [HasEndedButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    HasEndedButton.status = FLAlignmentStatusCenter;
    HasEndedButton.fl_padding = 6;
    [HasEndedButton addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    HasEndedButton.tag = 3;

    [view addSubview:HasEndedButton];
    
    
    [self.Activity_Pop addSubview:view];
    [self.window addSubview:self.Activity_Pop];
    
    
    
    /** 视图点击 */
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.Activity_Pop addGestureRecognizer:tapGesturRecognizer];
    
    
}

-(void)tapAction:(id)tap{
    [self.Activity_Pop removeFromSuperview];
}

#pragma mark --- 选择 ---
- (void)ButtonAction:(UIButton *)sender {
    
    for (int i = 1; i<4; i++) {
        if (sender.tag == i) {
            self.ActivityButton = sender;
            sender.selected = YES;
            if (self.ActivityBlock) {
                self.ActivityBlock(sender,sender.titleLabel.text);
            }
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i];
        but.selected = NO;
    }
    
    [self.Activity_Pop removeFromSuperview];
    
}
#pragma mark --- 懒加载 ---
-(UIButton *)Screenbutton{
    if (!_Screenbutton) {
        _Screenbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _Screenbutton.frame = CGRectMake(245,79,115,28);
        [_Screenbutton setImage:[UIImage imageNamed:@"icn_banbei_list_filter"] forState:UIControlStateNormal];
        [_Screenbutton setTitle:@" 全部活动" forState:UIControlStateNormal];
        [_Screenbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        _Screenbutton.titleLabel.font = [UIFont systemFontOfSize:autoScaleW(16)];
        _Screenbutton.layer.cornerRadius = 14;
        _Screenbutton.backgroundColor = UIColorFromRGB(0xEBF3FF);
        _Screenbutton.layer.borderWidth = 1;
        _Screenbutton.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        [_Screenbutton addTarget:self action:@selector(ScreenAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Screenbutton;
}
-(UIView *)Activity_Pop{
    if (!_Activity_Pop) {
        _Activity_Pop = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    }
    return _Activity_Pop;
}
@end
