//
//  Feedback_View.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Feedback_View.h"

@implementation Feedback_View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UIView *view_1 = [[UIView alloc] init];
    view_1.frame = CGRectMake(15,79,345,183);
    view_1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_1.layer.cornerRadius = 5;
    [self addSubview:view_1];
    [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(183);
    }];
    
    
    UIView *Line_view = [[UIView alloc] init];
    Line_view.frame = CGRectMake(15,128.5,345,0.5);
    Line_view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view_1 addSubview:Line_view];
    [Line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
    
    [view_1 addSubview:self.TixtLabel];
    [self.TixtLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(50);
        make.width.mas_offset(200);
    }];
    
    
   
    UIImageView *icon = [[UIImageView alloc]init];
    icon.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    [view_1 addSubview:icon];
    [icon  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.mas_offset(20);
        make.size.mas_offset(CGSizeMake(6, 10));
    }];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"请选择" forState:UIControlStateNormal];
    [button setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:12];
    [button addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
    [view_1 addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.mas_offset(0);
        make.height.mas_offset(50);
        make.width.mas_offset(90);
    }];
    
    
    self.textv = [[XMTextView alloc] initWithFrame:CGRectMake(-3, 70, ScreenW-30, 110)];
    self.textv.placeholder = @"请输入反馈内容";
    self.textv.placeholderColor = UIColorFromRGB(0x999999);
    self.textv.borderLineColor = [UIColor clearColor];
    self.textv.textColor = UIColorFromRGB(0x222222);
    self.textv.textFont = [UIFont systemFontOfSize:13];
    self.textv.textMaxNum = 200;
    self.textv.backgroundColor = [UIColor clearColor];
    self.textv.maxNumState = XMMaxNumStateNormal;
    self.textv.numLabel.hidden = YES;
    [view_1 addSubview:self.textv];
   
    self.textv.textViewListening = ^(NSString *textViewStr) {
        NSLog(@"tv2监听输入的内容：%@",textViewStr);
        
    };
    
    UILabel *label_1= [[UILabel alloc] init];
    label_1.frame = CGRectMake(25,139,51.5,12);
    label_1.numberOfLines = 0;
    label_1.textColor = [UIColor blackColor];
    label_1.font = [UIFont systemFontOfSize:13];
    label_1.text = @"反馈内容";
    [view_1 addSubview:label_1];
    [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(60);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
    }];
    
    
    
    
#pragma mark - 图片
    UIView *view_2 = [[UIView alloc] init];
    view_2.frame = CGRectMake(15,79,345,183);
    view_2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_2.layer.cornerRadius = 5;
    [self addSubview:view_2];
    [view_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view_1.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(189);
    }];
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(25,292,88,14);
    label_2.numberOfLines = 0;
    label_2.text = @"上传凭证照片";
    label_2.textColor = UIColorFromRGB(0x222222);
    label_2.font = [UIFont systemFontOfSize:15];
    [view_2 addSubview:label_2];
    [label_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(10);
    }];
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(25,292,88,14);
    label_3.numberOfLines = 0;
    label_3.text = @"凭证照片，最多只能上传3张";
    label_3.textColor = UIColorFromRGB(0xCCCCCC);
    label_3.font = [UIFont systemFontOfSize:13];
    [view_2 addSubview:label_3];
    [label_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(39);
        make.left.mas_offset(10);
    }];
    
}
-(void)BtnAction{
    
    self.suspen = [[UIView alloc] init];
    self.suspen.frame = CGRectMake(0,0,ScreenW,ScreenH);
    self.suspen.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:self.suspen];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,419.5,369.5,247.5);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.suspen addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(248);
    }];
    
    //line
    UIView *view_line1 = [[UIView alloc] init];
    view_line1.frame = CGRectMake(0,469.5,369.5,0.5);
    view_line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view addSubview:view_line1];
    [view_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(50);
        make.height.mas_offset(0.5);
    }];
    
    UIView *view_line2 = [[UIView alloc] init];
    view_line2.frame = CGRectMake(0,469.5,369.5,0.5);
    view_line2.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view addSubview:view_line2];
    [view_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(100);
        make.height.mas_offset(0.5);
    }];
    
    //确定按钮
    UIButton *QXButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QXButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [QXButton addTarget:self action:@selector(QXAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:QXButton];
    [QXButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    //确定按钮
    UIButton *QueButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [QueButton setTitle:@"确认" forState:UIControlStateNormal];
    [QueButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    QueButton.titleLabel.font = [UIFont systemFontOfSize:18];
    QueButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    QueButton.layer.cornerRadius = 10;
    [QueButton addTarget:self action:@selector(QueAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:QueButton];
    [QueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_offset(-15);
        make.left.mas_offset(15);
        make.height.mas_offset(44);
    }];
    
    
    UILabel *label_yiwen = [[UILabel alloc] init];
    label_yiwen.frame = CGRectMake(16,487.5,58,14.5);
    label_yiwen.numberOfLines = 0;
    label_yiwen.text = @"商家疑问";
    label_yiwen.font = [UIFont systemFontOfSize:15];
    [view addSubview:label_yiwen];
    [label_yiwen mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(view_line1.mas_bottom).offset(0);
    }];
    UILabel *label_shensu = [[UILabel alloc] init];
    label_shensu.frame = CGRectMake(16.5,538,58.5,14.5);
    label_shensu.numberOfLines = 0;
    label_shensu.text = @"商家申诉";
    label_shensu.font = [UIFont systemFontOfSize:15];
    [view addSubview:label_shensu];
    [label_shensu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(16);
        make.height.mas_offset(50);
        make.top.equalTo(view_line2.mas_bottom).offset(0);
    }];
    
    
    for (int i =0; i<2; i++) {
        UIButton *xuan_1 = [UIButton buttonWithType:UIButtonTypeCustom];
        [xuan_1 setImage:[UIImage imageNamed:@"btn_check_box_disable"] forState:UIControlStateNormal];
        [xuan_1 setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        xuan_1.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        xuan_1.tag = i+100;
        [xuan_1 addTarget:self action:@selector(XuanAction:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:xuan_1];
        [xuan_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(16);
            make.right.mas_offset(-16);
            make.height.mas_offset(50);
            make.top.equalTo(view_line1.mas_bottom).offset(i*50);
        }];
        if (i ==0) {
            xuan_1.selected = YES;
        }
    }

}
-(void)QueAction{
    [self.suspen removeFromSuperview];
    
    for (int i = 0; i<2; i++) {
        UIButton *but = (UIButton *)[self.suspen viewWithTag:i+100];
        if (but.selected == YES) {
            if (but.tag == 100) {
                self.TixtLabel.text = @"商家疑问";
            }else{
                self.TixtLabel.text = @"商家申诉";
                
            }
        }
    }
    
}
-(void)QXAction{
    [self.suspen removeFromSuperview];
}
-(void)XuanAction:(UIButton *)sender{
    
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+100) {
            sender.selected = YES;
            continue;
        }
        UIButton *but = (UIButton *)[self.suspen viewWithTag:i+100];
        but.selected = NO;
    }

    
}
#pragma mark - 懒加载
-(UILabel *)TixtLabel{
    if (!_TixtLabel) {
        _TixtLabel = [[UILabel alloc]init];
        _TixtLabel.font = [UIFont systemFontOfSize:16];
        _TixtLabel.textColor = [UIColor blackColor];
        _TixtLabel.text = @"商家疑问";
    }
    return _TixtLabel;
}
@end
