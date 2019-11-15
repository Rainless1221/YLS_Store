//
//  PeriodView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "PeriodView.h"

@implementation PeriodView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    [self addSubview:self.BaseView];
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.width.mas_offset(ScreenW-30);
        make.height.mas_offset(451);
    }];
    
    
    /*叉号*/
    UIButton *Btn =[UIButton buttonWithType:UIButtonTypeCustom];
    Btn.frame = CGRectMake(0, 0, 50, 50);
    [Btn setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [Btn addTarget:self action:@selector(PeriodV) forControlEvents:UIControlEventTouchUpInside];
    [self.BaseView addSubview:Btn];
    
    /* 标题 */
    UILabel *periodLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, self.BaseView.width-100, 50)];
    periodLabel.text = @"选择周期";
    periodLabel.textAlignment = 1;
    periodLabel.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:periodLabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 50,self.BaseView.width-20 , 1)];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.BaseView addSubview:line];
    
    
    CGFloat Bwidth = self.BaseView.width-60;
    CGFloat Bheight = 40;
    
    NSArray *Array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    [self.PerArray removeAllObjects];
    for (int i = 0; i < Array.count; i++) {
        [self.PerArray addObject:@""];
    }
    for (int i =0; i<Array.count; i++) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(30,100+i*40,self.BaseView.width-60 , 1)];
        line.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [self.BaseView addSubview:line];
        
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(30, i*Bheight+60, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
        [thirdBtn setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",Array[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusRight;
        thirdBtn.fl_padding = Bwidth-55;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.BaseView addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i;
        
        
    }
    /* 确定按钮 */
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, self.BaseView.width-60, 44);

    
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = queButton.bounds;
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [queButton.layer addSublayer:gl];
    
//    queButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    queButton.layer.shadowOffset = CGSizeMake(0,4);
//    queButton.layer.shadowOpacity = 1;
//    queButton.layer.shadowRadius = 9;
    queButton.layer.cornerRadius = 10;
    queButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [queButton setTitle:@"确定" forState:UIControlStateNormal];
    [queButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    
    [queButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(queButtonaction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.BaseView addSubview:queButton];
    [queButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
    
}
-(void)MerchantButton:(UIButton *)sender{
//    NSArray *Array = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
//    if (sender.selected == YES) {
//        [self.PerArray insertObject:@"" atIndex:sender.tag-1];
//        sender.selected = NO;
//
//    }else{
//        [self.PerArray insertObject:Array[sender.tag-1] atIndex:sender.tag-1];
//        sender.selected = YES;
//
//    }
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
//        [self.PerArray addObject:sender.titleLabel.text];
        [self.PerArray insertObject:sender.titleLabel.text atIndex:sender.tag];
    } else {
        [self.PerArray removeObjectAtIndex:sender.tag];
//        [self.PerArray removeObject:sender.titleLabel.text];
    }
}
#pragma mark - 确定
-(void)queButtonaction{
    
    NSString *persting = [[NSString alloc]init];
    for (int i =0; i<self.PerArray.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.PerArray[i]];
        
        if ([urlstring isEqualToString:@""]) {

        }else{
            if (i == self.PerArray.count) {
                persting = [persting stringByAppendingFormat:@"%@",urlstring];
            }else{
                persting = [persting stringByAppendingFormat:@"%@,",urlstring];
            }
        }

    }
    persting = [persting substringWithRange:NSMakeRange(0, [persting length] - 1)];
    NSLog(@" 选择的周期 ：%@",persting)
    
    
    if (self.PeriodBlock) {
        self.PeriodBlock(persting);
    }
    [self removeFromSuperview];
}
#pragma mark - 叉号
-(void)PeriodV{
    
    [self removeFromSuperview];
    
}
#pragma mark -GET
- (UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 368)];
        _BaseView.backgroundColor = [UIColor whiteColor];
        _BaseView.layer.cornerRadius = 6;
    }
    return _BaseView;
}
-(NSMutableArray *)PerArray{
    if (!_PerArray) {
        _PerArray = [NSMutableArray array];
    }
    return _PerArray;
}
@end
