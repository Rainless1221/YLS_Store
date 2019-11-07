//
//  SelectedRemin.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "SelectedRemin.h"

@implementation SelectedRemin

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createUI];
        /** 视图点击 */
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesturRecognizer];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    self.layer.borderColor =UIColorFromRGB(0xEAEAEA).CGColor;
    self.layer.cornerRadius = 5;
    /**选择与否图标按钮*/
    [self addSubview:self.ReminIcon];
    [self.ReminIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(36, 36));
    }];
    
    
    /**温馨提示文本*/
    [self addSubview:self.ReminLable];
    [self.ReminLable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-20);
        make.left.equalTo(self.ReminIcon.mas_right).offset(0);
    }];
    
    
}
- (void)setStatus:(ReminVieWStatus)status{
    
    // 判断
    if (status == ReminVieWStatus_1) {
        self.layer.borderWidth = 1;

    }else if (status == ReminVieWStatus_2){
        self.layer.borderWidth = 0;
        [_ReminIcon setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        self.ReminIcon.userInteractionEnabled=NO;//交互关闭
        self.userInteractionEnabled =NO;
        UIView *yuan = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
        yuan.layer.cornerRadius = 5/2;
        yuan.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [self.ReminIcon addSubview:yuan];
        [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_offset(0);
            make.size.mas_offset(CGSizeMake(5, 5));
        }];
    }
    
}
#pragma mark - 视图点击事件
-(void)tapAction:(id)tap{
    self.ReminIcon.selected = !self.ReminIcon.selected;
    if (self.delagate && [self.delagate respondsToSelector:@selector(SelectedReminAction: and:)]) {
        [self.delagate SelectedReminAction:self and:self.ReminIcon];
    }
}
#pragma mark -点击事件
-(void)SeleAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (self.delagate && [self.delagate respondsToSelector:@selector(SelectedReminAction: and:)]) {
        [self.delagate SelectedReminAction:self and:sender];
    }
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    NSString *info_content = [NSString stringWithFormat:@"%@",Data[@"info_content"]];
    if ([[MethodCommon judgeStringIsNull:info_content] isEqualToString:@""]) {
        info_content = @"";
    }else{
        self.ReminLable.text = info_content;
    }
    
    NSString *info_id = [NSString stringWithFormat:@"%@",Data[@"info_id"]];
    if ([[MethodCommon judgeStringIsNull:info_id] isEqualToString:@""]) {
        info_id = @"";
    }else{
        self.ReminIcon.tag = [info_id integerValue];

    }

    
    NSString *is_selected = [NSString stringWithFormat:@"%@",Data[@"is_selected"]];
    if ([is_selected isEqualToString:@"1"]) {
        self.ReminIcon.selected = YES;
        if (self.delagate && [self.delagate respondsToSelector:@selector(SelectedReminAction: and:)]) {
            [self.delagate SelectedReminAction:self and:self.ReminIcon];
        }
    }
    
    
}
#pragma mark - 懒加载
-(UIButton *)ReminIcon{
    if (!_ReminIcon) {
        _ReminIcon = [UIButton buttonWithType:UIButtonTypeCustom];
        [_ReminIcon setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [_ReminIcon setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
        [_ReminIcon addTarget:self action:@selector(SeleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _ReminIcon;
}
-(UILabel *)ReminLable{
    if (!_ReminLable) {
        _ReminLable = [[UILabel alloc]initWithFrame:CGRectMake(36, 0, self.width-60, 36)];
        _ReminLable.textColor = UIColorFromRGB(0x222222);
        _ReminLable.font = [UIFont systemFontOfSize:15];
        _ReminLable.numberOfLines = 0;
    }
    return _ReminLable;
}
@end
