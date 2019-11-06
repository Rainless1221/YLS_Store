//
//  DXXView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/12.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "DXXView.h"

@implementation DXXView
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    

    NSString * oneStr = @"示例图";
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@",oneStr]];
    //修改某个范围内的字体大小
    //    [str addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Arial-BoldItalicMT" size:16.0] range:NSMakeRange(7,2)];
    //修改某个范围内字的颜色
    [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0x3D8AFF)  range:NSMakeRange(0,[str length])];
    //在某个范围内增加下划线
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [str length])];
    
    [self.SLbutton setAttributedTitle:str forState:UIControlStateNormal];
    [self.SLbutton1 setAttributedTitle:str forState:UIControlStateNormal];
    
    
    self.reminder.delegate = self;
    
#pragma mark -- /* 温馨提示 */
    //icn_input_pen
    [self.reminderView addSubview:self.TEXTView];
    [self.TEXTView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-20);
        make.height.mas_offset(80);
    }];
    
    [self.TEXTView addSubview:self.reminder];
    [self.reminder mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(36);
        make.right.mas_offset(-5);
        make.bottom.mas_offset(-5);
        make.top.mas_offset(0);
    }];
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 16, 16)];
    icon.image = [UIImage imageNamed:@"icn_input_pen"];
    [self.TEXTView addSubview:icon];
    
    [self.TEXTView addSubview:self.placeholderLabel];
    [self.placeholderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(38);
        make.right.mas_offset(-5);
        make.top.mas_offset(5);
    }];
    
    #pragma mark -- 勾选的提示
    
    
}


#pragma mark -- 门店
- (IBAction)facePicAction:(UIButton *)sender {
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(nil,sender);
    }
}

#pragma mark - 选择地址
- (IBAction)AddanAction:(UIButton *)sender {
    if (self.AddBlock) {
        self.AddBlock();
    }
    
}
#pragma mark - 选择周期

- (IBAction)periodAction:(UIButton *)sender {
    
    if (self.periodBlock) {
        self.periodBlock(nil,sender);
    }
}
#pragma mark - 选择时间

- (IBAction)TimesAction:(UIButton *)sender {
    
    if (self.TimesBlock) {
        self.TimesBlock(nil,sender);
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{    if (![text isEqualToString:@""])
    
    {
    
            _placeholderLabel.hidden = YES;
    
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1)
        
    {
        
        _placeholderLabel.hidden = NO;
        
    }
    
    return YES;
    
}

#pragma mark - 懒加载
-(UIView *)TEXTView{
    if (!_TEXTView) {
        _TEXTView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, self.reminderView.width-20, 80)];
        _TEXTView.layer.cornerRadius = 5;
        _TEXTView.layer.borderWidth = 1;
        _TEXTView.layer.borderColor = UIColorFromRGB(0xEAEAEA).CGColor;
    }
    return _TEXTView;
}
-(UITextView *)reminder{
    if (!_reminder) {
        _reminder = [[UITextView alloc]initWithFrame:CGRectMake(36, 0, self.TEXTView.width-40, 70)];
        _reminder.font = [UIFont systemFontOfSize:13];
    }
    return _reminder;
}
-(UILabel *)placeholderLabel{
    if (!_placeholderLabel) {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(36, 0, self.TEXTView.width-40, 50)];
        _placeholderLabel.text = @"您还可以输入需要补充的提醒内容。";
        _placeholderLabel.textColor = UIColorFromRGB(0xCCCCCC);
        _placeholderLabel.font = [UIFont systemFontOfSize:13];
    }
    return _placeholderLabel;
}
@end
