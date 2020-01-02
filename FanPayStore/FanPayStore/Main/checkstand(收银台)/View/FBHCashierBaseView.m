//
//  FBHCashierBaseView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHCashierBaseView.h"

@interface FBHCashierBaseView ()
/*[ 平均优惠力度 ]*/
@property (strong,nonatomic)YYLabel * Pingju;

@end

@implementation FBHCashierBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.today_income_String = @"00";
        self.cumulative_income_String = @"00";
        self.today_order_money_String = @"00";
        self.order_money_String = @"00";
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.View1];
//    [self addSubview:self.View2];
    [self addSubview:self.View3];
    [self.View1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(208.5);
    }];
//    [self.View2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.View1.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(139);
//    }];
    
#pragma mark - 今日营业流水（元）/ 未结算营业流水（元）
    [self addSubview:self.View4];
    [self addSubview:self.View5];
    [self.View4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.View1.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.height.mas_offset(68);
        make.width.mas_offset((ScreenW-45)/2);
    }];
    [self.View5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.View1.mas_bottom).offset(15);
        make.left.equalTo(self.View4.mas_right).offset(15);
        make.height.mas_offset(68);
        make.width.mas_offset((ScreenW-45)/2);
    }];
    
    UIImageView *view4Image = [[UIImageView alloc]init];
    view4Image.image = [UIImage imageNamed:@"ico_balance_today_done"];
    [self.View4 addSubview:view4Image];
    [view4Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.size.mas_offset(CGSizeMake(38, 38));
    }];
    UIImageView *view5Image = [[UIImageView alloc]init];
    view5Image.image = [UIImage imageNamed:@"ico_balance_today_undone"];
    [self.View5 addSubview:view5Image];
    [view5Image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.mas_offset(0);
        make.size.mas_offset(CGSizeMake(38, 38));
    }];
    
    //今日营业流水（元）
    UILabel *View4label = [[UILabel alloc] init];
    View4label.text = @"今日营业流水（元）";
    View4label.numberOfLines = 0;
    View4label.textColor = UIColorFromRGB(0xF7AE2A);
    View4label.font = [UIFont systemFontOfSize:10];
    [self.View4 addSubview:View4label];
    [View4label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4Image.mas_right).offset(5);
        make.top.mas_offset(68/2);
        make.right.mas_offset(0);
    }];
    [self.View4 addSubview:self.today_order_money];
    [self.today_order_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view4Image.mas_right).offset(5);
        make.right.mas_offset(0);
        make.bottom.equalTo(View4label.mas_top).offset(0);
    }];
    
    
    //未结算营业流水（元）
    UILabel *View5label = [[UILabel alloc] init];
    View5label.text = @"未结算营业流水（元）";
    View5label.numberOfLines = 0;
    View5label.textColor = UIColorFromRGB(0x3D8AFF);
    View5label.font = [UIFont systemFontOfSize:10];
    [self.View5 addSubview:View5label];
    [View5label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view5Image.mas_right).offset(5);
        make.top.mas_offset(68/2);
        make.right.mas_offset(0);
    }];
    
     [self.View5 addSubview:self.order_money];
    [self.order_money mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view5Image.mas_right).offset(5);
        make.right.mas_offset(0);
        make.bottom.equalTo(View5label.mas_top).offset(0);
    }];
    
    
    
    [self addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.View5.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 139));
    }];
#pragma mark -
    UIButton *button_TJ = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_TJ  setImage:[UIImage imageNamed:@"revenue_statistics_entrance"] forState:UIControlStateNormal];
    [button_TJ  setImage:[UIImage imageNamed:@"revenue_statistics_entrance"] forState:UIControlStateHighlighted];
    [button_TJ addTarget:self action:@selector(TJAction:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button_TJ];
    [button_TJ mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.orderView.mas_bottom).offset(15);
        make.left.right.mas_offset(0);
        make.height.mas_offset(65);
    }];
    
    [self.View3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button_TJ.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(self.IncomeArray.count*45+100);
    }];
#pragma mark -- 当前余额：
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 75, 15)];
    label1.text = @"当前余额：";
    label1.textColor = UIColorFromRGB(0x282828);
    label1.font = [UIFont systemFontOfSize:15];
    [self.View1 addSubview:label1];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(11);
        make.top.mas_offset(15);
        make.height.mas_offset(15);
    }];
    
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button1 setImage:[UIImage imageNamed:@"icn_eye_open"] forState:UIControlStateNormal];
    [button1 setImage:[UIImage imageNamed:@"icn_eye_close"] forState:UIControlStateSelected];
    [button1 addTarget:self action:@selector(isSetLook:) forControlEvents:UIControlEventTouchUpInside];
    self.lookButton = button1;
    [self.View1 addSubview:button1];
    [button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label1.mas_right).offset(-2);
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(25, 30));
    }];
    
    FL_Button *button2 = [FL_Button buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"去提现" forState:UIControlStateNormal];
    [button2 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [button2 setImage:[UIImage imageNamed:@"input_arrow_right_blue"] forState:UIControlStateNormal];
    button2.layer.borderWidth = 1;
    button2.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
    button2.status = FLAlignmentStatusCenter;
    button2.fl_padding = 5;
    button2.layer.cornerRadius = 22/2;
    button2.titleLabel.font = [UIFont systemFontOfSize:12];
    [button2 addTarget:self action:@selector(WithdrawAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.View1 addSubview:button2];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(label1.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(64, 22));
    }];
    [self.View1 addSubview:self.current_balance];
    [self.current_balance mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(60);
        make.left.right.mas_offset(0);
        make.height.mas_offset(27);
    }];
#pragma mark - [ 平均优惠力度 ]
    [self.View1 addSubview:self.Pingju];
    [self.Pingju mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.current_balance.mas_bottom).offset(13);
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(180), 24));
    }];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    label2.text = @"今日收入（元）";
    label2.textColor = UIColorFromRGB(0x999999);
    label2.font = [UIFont systemFontOfSize:12];
    label2.textAlignment = 1;
    [self.View1 addSubview:label2];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.current_balance.mas_bottom).offset(62);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    label3.text = @"累计收入（元）";
    label3.textColor = UIColorFromRGB(0x999999);
    label3.font = [UIFont systemFontOfSize:12];
    label3.textAlignment = 1;
    [self.View1 addSubview:label3];
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.current_balance.mas_bottom).offset(62);
        make.left.equalTo(label2.mas_right).offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    
    [self.View1 addSubview:self.today_income];
    [self.View1 addSubview:self.cumulative_income];
    [self.today_income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label2.mas_bottom).offset(10);
        make.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    
    
    
    [self.cumulative_income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label3.mas_bottom).offset(10);
        make.left.equalTo(label2.mas_right).offset(0);
        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
    }];
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 36)];
    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.View1 addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label2.mas_right).offset(0);
        make.top.equalTo(label2.mas_top).offset(0);
        make.size.mas_offset(CGSizeMake(1, 36));
    }];
#pragma mark -- 当前最新版本v2.0，请及时更新...
    
//    [self.View2 addSubview:self.icon2];
//    [self.icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(0);
//        make.left.mas_offset(10);
//        make.size.mas_offset(CGSizeMake(17, 16));
//    }];
    //    [self.View2 addSubview:self.More];
    //    [self.More mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_offset(0);
    //        make.right.mas_offset(-10);
    //        make.size.mas_offset(CGSizeMake(40, self.View2.height));
    //    }];
    
    //    UIView *moreLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 12)];
    //    moreLine.backgroundColor = UIColorFromRGB(0x999999);
    //    [self.View2 addSubview:moreLine];
    //    [moreLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_offset(0);
    //        make.right.equalTo(self.More.mas_left).offset(-1);
    //        make.size.mas_offset(CGSizeMake(1, 12));
    //    }];
//
//    UILabel *zuixin = [[UILabel alloc]initWithFrame:CGRectMake(self.icon2.right+10, 18, 30, 13)];
//    zuixin.text = @"最新";
//    zuixin.textAlignment = 1;
//    zuixin.font = [UIFont systemFontOfSize:10];
//    zuixin.textColor = UIColorFromRGB(0x3D8AFF);
//    zuixin.layer.cornerRadius = 1.5;
//    zuixin.layer.borderWidth = 1;
//    zuixin.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
//    [self.View2 addSubview:zuixin];

#pragma mark -订单模块
    CGFloat Bwidth = (ScreenW-50)/5;
    CGFloat Bheight = 88;
    
   
//    NSArray *orderArray = @[@"全部",@"待支付",@"已支付",@"已评价",@"退单/退款"];
//    NSArray *order_imageAry = @[@"icn_b_order_all",@"icn_b_order_tobepaid",@"icn_b_order_paid",@"icn_b_order_evaluated",@"icn_b_order_refund"];
    NSArray *orderArray = @[@"已付款",@"已预约",@"评价",@"退单/退款",@"全部"];
    NSArray *order_imageAry = @[@"icn_b_order_paid",@"icn_b_order_booking",@"icn_b_order_evaluated",@"icn_b_order_refund",@"icn_b_order_all"];
    UILabel *centerlabel4= [[UILabel alloc]init];
    centerlabel4.text =@"商家订单";
    centerlabel4.textColor = UIColorFromRGB(0x282828);
    centerlabel4.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:centerlabel4];
    [centerlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    for (int i = 0; i<orderArray.count; i++) {
        NSInteger index = i % 5;
        NSInteger page = i / 5;
        
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(index*Bwidth+10, page*Bheight+35, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:order_imageAry[i]] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",orderArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.orderView addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+20;
        if (i == 1) {
            self.thirdBtn = thirdBtn;
            [thirdBtn addSubview:self.badgeLable];
            CGFloat badgeW   = 17;
            CGSize imageSize = self.thirdBtn.imageView.frame.size;
            CGFloat imageX   = self.thirdBtn.imageView.frame.origin.x;
            CGFloat imageY   = self.thirdBtn.imageView.frame.origin.y;
            
            CGFloat badgeX = imageX + imageSize.width - badgeW*0.25;
            CGFloat badgeY = imageY - badgeW*0.5;
            
            [self.badgeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(badgeY);
                make.left.mas_offset(badgeX);
                make.size.mas_offset(CGSizeMake(badgeW, badgeW));
            }];
        }else if (i == 0){
            [thirdBtn addSubview:self.badgeLable1];
            CGFloat badgeW   = 17;
            CGSize imageSize = thirdBtn.imageView.frame.size;
            CGFloat imageX   = thirdBtn.imageView.frame.origin.x;
            CGFloat imageY   = thirdBtn.imageView.frame.origin.y;
            
            CGFloat badgeX = imageX + imageSize.width - badgeW*0.25;
            CGFloat badgeY = imageY - badgeW*0.5;
            
            [self.badgeLable1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(badgeY);
                make.left.mas_offset(badgeX);
                make.size.mas_offset(CGSizeMake(badgeW, badgeW));
            }];

//            [thirdBtn addSubview:self.badgeLableRed];
//            [self.badgeLableRed mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_offset(-20);
//                make.centerX.mas_offset(0);
//                make.height.mas_offset(30);
//
//            }];
        } else if (i == 3){
            
            [thirdBtn addSubview:self.badgeLable2];
            CGFloat badgeW   = 17;
            CGSize imageSize = thirdBtn.imageView.frame.size;
            CGFloat imageX   = thirdBtn.imageView.frame.origin.x;
            CGFloat imageY   = thirdBtn.imageView.frame.origin.y;
            
            CGFloat badgeX = imageX + imageSize.width - badgeW*0.25;
            CGFloat badgeY = imageY - badgeW*0.5;
            
            [self.badgeLable2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(badgeY);
                make.left.mas_offset(badgeX);
                make.size.mas_offset(CGSizeMake(badgeW, badgeW));
            }];
        }else if(i == 4){
            UIImageView *line = [[UIImageView alloc]initWithFrame:CGRectMake(index*Bwidth+16, page*Bheight+55, 4, Bheight-30)];
            line.image = [UIImage imageNamed:@"icn_b_order_cutline"];
            [self.orderView addSubview:line];
        }
        
    }
    
#pragma mark - 筛选数据

//    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 1)];
//    line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [self.View3 addSubview:line2];
//    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(40);
//        make.left.right.mas_offset(0);
//        make.height.mas_offset(1);
//    }];
//    /** 当天or七天or一个月 */
//    NSArray *titleArr = @[@"当天",@"7天",@"一个月"];
//    for (int i = 0; i<titleArr.count; i++) {
//        UIButton *TimeButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [TimeButton setTitle:[NSString stringWithFormat:@"%@",titleArr[i]] forState:UIControlStateNormal];
//        [TimeButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
//        [TimeButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//        TimeButton.titleLabel.font = [UIFont systemFontOfSize:autoScaleW(15)];
//        [TimeButton addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
//        [self.View3 addSubview:TimeButton];
//        [TimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.mas_offset(0);
//            make.left.mas_offset((self.View3.width/3)*i);
//            make.bottom.equalTo(line2.mas_top).offset(0);
//            make.width.mas_offset(self.View3.width/3);
//        }];
//        TimeButton.tag = i+1;
//
//        if (i==0) {
//            TimeButton.selected = YES;
//            self.TimeButton = TimeButton;
//            [self.View3 addSubview:self.timeline];
//            [self.timeline mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(TimeButton.mas_centerX).offset(0);
//                make.top.equalTo(TimeButton.mas_bottom).offset(-5);
//                make.size.mas_offset(CGSizeMake(13, 2));
//            }];
//        }
//    }
//
//
//    //    UIButton *TimeButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [TimeButton1 setTitle:@"当天" forState:UIControlStateNormal];
//    //    [TimeButton1 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
//    //    [TimeButton1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//    //    TimeButton1.titleLabel.font = [UIFont systemFontOfSize:15];
//    //    [TimeButton1 addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
//    //    [self.View3 addSubview:TimeButton1];
//    //    [TimeButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.top.mas_offset(0);
//    //        make.left.mas_offset(0);
//    //        make.bottom.equalTo(line2.mas_top).offset(0);
//    //        make.width.mas_offset(self.View3.width/3);
//    //    }];
//    //    UIButton *TimeButton2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [TimeButton2 setTitle:@"7天" forState:UIControlStateNormal];
//    //    [TimeButton2 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
//    //    [TimeButton2 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//    //    TimeButton2.titleLabel.font = [UIFont systemFontOfSize:15];
//    //    [TimeButton2 addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
//    //
//    //    [self.View3 addSubview:TimeButton2];
//    //    [TimeButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.top.mas_offset(0);
//    //        make.left.equalTo(TimeButton1.mas_right).offset(0);
//    //        make.bottom.equalTo(line2.mas_top).offset(0);
//    //        make.width.mas_offset(self.View3.width/3);
//    //    }];
//    //    UIButton *TimeButton3 = [UIButton buttonWithType:UIButtonTypeCustom];
//    //    [TimeButton3 setTitle:@"一个月" forState:UIControlStateNormal];
//    //    [TimeButton3 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
//    //    [TimeButton3 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
//    //    TimeButton3.titleLabel.font = [UIFont systemFontOfSize:15];
//    //    [TimeButton3 addTarget:self action:@selector(TimeAction:) forControlEvents:UIControlEventTouchUpInside];
//    //
//    //    [self.View3 addSubview:TimeButton3];
//    //    [TimeButton3 mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.top.mas_offset(0);
//    //        make.left.equalTo(TimeButton2.mas_right).offset(0);
//    //        make.bottom.equalTo(line2.mas_top).offset(0);
//    //        make.width.mas_offset(self.View3.width/3);
//    //    }];
//    //    [self.View3 addSubview:self.timeline];
//    //    [self.timeline mas_makeConstraints:^(MASConstraintMaker *make) {
//    //        make.centerX.equalTo(TimeButton1.mas_centerX).offset(0);
//    //        make.top.equalTo(TimeButton1.mas_bottom).offset(-5);
//    //        make.size.mas_offset(CGSizeMake(13, 1));
//    //    }];
//
//
//    UIView *timeView = [[UIView alloc]initWithFrame:CGRectMake(10, 50, ScreenW - 50, 24)];
//    timeView.backgroundColor = UIColorFromRGB(0xF7F7F7);
//    [self.View3 addSubview:timeView];
//    [timeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line2.mas_bottom).offset(20);
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(24);
//    }];
//    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
//    label4.text = @"    总营收";
//    label4.textColor = UIColorFromRGB(0x999999);
//    label4.font = [UIFont systemFontOfSize:13];
//    [self.View3 addSubview:label4];
//    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(timeView.mas_bottom).offset(30);
//        make.left.mas_offset(0);
//        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
//    }];
//
//    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
//    label5.text = @"    总支出";
//    label5.textColor = UIColorFromRGB(0x999999);
//    label5.font = [UIFont systemFontOfSize:12];
//    [self.View3 addSubview:label5];
//    [label5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(timeView.mas_bottom).offset(30);
//        make.left.equalTo(label4.mas_right).offset(0);
//        make.size.mas_offset(CGSizeMake((ScreenW-30)/2, 15));
//    }];
//
//
//    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 44)];
//    line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [self.View3 addSubview:line3];
//    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label4.mas_top).offset(0);
//        make.left.equalTo(label4.mas_right).offset(0);
//        make.size.mas_offset(CGSizeMake(1, 44));
//    }];
//
//    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 1)];
//    line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
//    [self.View3 addSubview:line4];
//    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(timeView.mas_bottom).offset(110);
//        make.left.mas_offset(10);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(1);
//    }];
//
    
    
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 14, 15)];
    icon1.image = [UIImage imageNamed:@"icn_order_record_list"];
    [self.View3 addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(line4.mas_bottom).offset(20);
        make.top.mas_offset(14.5);
        make.left.mas_offset(10.5);
        make.size.mas_offset(CGSizeMake(14, 15));
    }];
 
    
    UILabel *label6 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 15)];
    label6.text = @"营收记录";
    label6.textColor = UIColorFromRGB(0x222222);
    label6.font = [UIFont systemFontOfSize:15];
    [self.View3 addSubview:label6];
    [label6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon1.mas_centerY).offset(0);
        make.left.equalTo(icon1.mas_right).offset(12);
    }];
    
    FL_Button *button3 = [FL_Button buttonWithType:UIButtonTypeCustom];
    [button3 setTitle:@"查看更多" forState:UIControlStateNormal];
    [button3 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [button3 setImage:[UIImage imageNamed:@"input_arrow_right_blue"] forState:UIControlStateNormal];
    button3.status = FLAlignmentStatusRight;
    button3.fl_padding = 5;
    button3.titleLabel.font = [UIFont systemFontOfSize:12];
    [button3 addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.View3 addSubview:button3];
    [button3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(label6.mas_centerY).offset(0);
        make.size.mas_offset(CGSizeMake(80, 26));
    }];
    
    UIView *label6_line = [[UIView alloc] init];
    label6_line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.View3 addSubview:label6_line];
    [label6_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(44);
        make.left.right.mas_offset(0);
        make.height.mas_offset(0.5);
    }];
    
//    [self.View3 addSubview:self.total_income];
//    [self.View3 addSubview:self.total_expense];
//    [self.total_income mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label4.mas_bottom).offset(20);
//        make.left.mas_offset(10);
//        make.right.equalTo(line3.mas_left).offset(0);
//    }];
//    [self.total_expense mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(label4.mas_bottom).offset(20);
//        make.right.mas_offset(0);
//        make.left.equalTo(line3.mas_right).offset(10);
//    }];
    
//    [timeView addSubview:self.begin_date];
//    [timeView addSubview:self.end_date];
//    [self.begin_date mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_offset(0);
//        make.left.mas_offset(10);
//    }];
//    [self.end_date mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.mas_offset(0);
//        make.left.equalTo(self.begin_date.mas_right).offset(33);
//    }];
//
//    UIView *line5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 25, 1)];
//    line5.backgroundColor = UIColorFromRGB(0x3D8AFF);
//    [timeView addSubview:line5];
//    [line5 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(0);
//        make.left.equalTo(self.begin_date.mas_right).offset(10);
//        make.right.equalTo(self.end_date.mas_left).offset(-10);
//        make.height.mas_offset(1);
//    }];
    
    self.total_income.userInteractionEnabled = YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [self.total_income addGestureRecognizer:labelTapGestureRecognizer];
    
#pragma mark - 列表
    self.IncomeTableview = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenW-30, 220) style:UITableViewStylePlain];
    self.IncomeTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.IncomeTableview registerNib:[UINib nibWithNibName:@"CashierTableViewCell" bundle:nil] forCellReuseIdentifier:@"CashierTableViewCell"];
    self.IncomeTableview.delegate =  self;
    self.IncomeTableview.dataSource = self;
    self.IncomeTableview.backgroundColor = [UIColor clearColor];
    [self.View3 addSubview:self.IncomeTableview];
    self.IncomeTableview.defaultNoDataText = @"";
    self.IncomeTableview.defaultNoDataImage = [UIImage imageNamed:@"icn_function_tobedeveloped_title"];
    self.IncomeTableview.customNoDataView = [UIView new];
    self.IncomeTableview.backgroundView = [UIView new];
    self.IncomeTableview.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        
    };
    
    [self.IncomeTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label6_line.mas_bottom).offset(10);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-5);
    }];
    
}
#pragma mark - 快捷选择时间
-(void)TimeAction:(UIButton *)sender{
    for (int i = 0; i<3; i++) {
        if (sender.tag == i+1) {
            sender.selected = YES;
            self.timeline.centerX = sender.centerX;
            sender.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(15)];
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i+1];
        but.selected = NO;
        but.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(13)];
    }
    
    // 获取代表公历的NSCalendar对象
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // 获取当前日期
    NSDate* dt = [NSDate date];
    // 定义一个时间字段的旗标，指定将会获取指定年、月、日、时、分、秒的信息
    unsigned unitFlags = NSCalendarUnitYear |
    NSCalendarUnitMonth |  NSCalendarUnitDay |
    NSCalendarUnitHour |  NSCalendarUnitMinute |
    NSCalendarUnitSecond | NSCalendarUnitWeekday;
    // 获取不同时间字段的信息
    NSDateComponents* comp1 = [gregorian components: unitFlags
                                           fromDate:dt];
    NSDate *appointDate;
    NSTimeInterval oneDay = 24 * 60 * 60;
    switch (sender.tag) {
        case 1:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * 0)];
            break;
        case 2:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -7)];
            break;
        case 3:
            appointDate = [dt initWithTimeIntervalSinceNow: (oneDay * -30)];
            break;
        default:
            break;
    }
    // 获取不同时间字段的信息
    NSDateComponents* comp = [gregorian components: unitFlags
                                          fromDate:appointDate];
    
    self.begin_date.text= [NSString stringWithFormat:@"%ld-%ld-%ld",(long)comp.year,(long)comp.month,(long)comp.day];
    self.end_date.text = [NSString stringWithFormat:@"%ld-%ld-%ld",(long)comp1.year,(long)comp1.month,(long)comp1.day];
    
    
    /** 传时间值到控制器 */
    if (self.delagate && [self.delagate respondsToSelector:@selector(list_checkstand:andEnd:)]) {
        [self.delagate list_checkstand:self.begin_date.text andEnd:self.end_date.text];
    }
    
}


#pragma mark - 更多
-(void)MorebuttonAction{
    //    if (self.delagate && [self.delagate respondsToSelector:@selector(MoreAction)]) {
    //        [self.delagate MoreAction];
    //    }
}
#pragma mark - 余额是否可见
- (void)isSetLook:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.selected == YES) {
        [PublicMethods writeToUserD:@"YES" andKey:@"islook"];
        sender.selected = YES;
        self.current_balance.text = @"****";
        self.today_income.text = @"****";
        self.cumulative_income.text = @"****";
        self.current_balance_String1 = @"****";
        
        NSString *protocol = [NSString stringWithFormat:@"%@ 折 [ 平均优惠力度 ]",self.current_balance_String1];
        NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
        //设置字体颜色
        [attri_str setFont:[UIFont systemFontOfSize:12]];
        attri_str.color = [UIColor colorWithHexString:@"EE4E3E"];
        NSRange ProRange = [protocol rangeOfString:@"[ 平均优惠力度 ]"];
        
        [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"EE4E3E"] userInfo:nil];
        self.Pingju.attributedText = attri_str;
        self.Pingju.textAlignment = NSTextAlignmentCenter;
        
    }else{
        [PublicMethods writeToUserD:@"NO" andKey:@"islook"];
        sender.selected = NO;
        if ([[MethodCommon judgeStringIsNull:self.current_balance_String] isEqualToString:@""]) {
            self.current_balance.text =  [NSString stringWithFormat:@"¥ 00.00"];
        }else{
            self.current_balance.text =  [NSString stringWithFormat:@" %@",self.current_balance_String];
        }
        if ([[MethodCommon judgeStringIsNull:self.today_income_String] isEqualToString:@""]) {
            self.today_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.today_income.text =  [NSString stringWithFormat:@"+ %@",self.today_income_String];
        }
        if ([[MethodCommon judgeStringIsNull:self.cumulative_income_String] isEqualToString:@""]) {
            self.cumulative_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.cumulative_income.text =  [NSString stringWithFormat:@"+ %@",self.cumulative_income_String];
        }
        
        self.current_balance_String1 = [NSString  stringWithFormat:@"%@",self.Data[@"average_discount"]];
        if ([[MethodCommon judgeStringIsNull:self.current_balance_String1] isEqualToString:@""]) {
            self.current_balance_String1 =@"0.0";
        }
        NSString *protocol = [NSString stringWithFormat:@"%@ 折 [ 平均优惠力度 ]",self.current_balance_String1];
        NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
        //设置字体颜色
        [attri_str setFont:[UIFont systemFontOfSize:12]];
        attri_str.color = [UIColor colorWithHexString:@"EE4E3E"];
        NSRange ProRange = [protocol rangeOfString:@"[ 平均优惠力度 ]"];
        
        [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"EE4E3E"] userInfo:nil];
        self.Pingju.attributedText = attri_str;
        self.Pingju.textAlignment = NSTextAlignmentCenter;
        
    }
    
}
#pragma mark -去提现
-(void)WithdrawAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(getWithdraw)]) {
        [self.delagate getWithdraw];
    }
}
#pragma mark - 统计
-(void)TJAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(StatisticalAction)]) {
        [self.delagate StatisticalAction];
    }
}
#pragma mark -查看更多
-(void)moreAction:(UIButton *)sender{
    if (self.delagate && [self.delagate respondsToSelector:@selector(getincomeMore)]) {
        [self.delagate getincomeMore];
    }
}
-(void)labelTouchUpInside:(UITapGestureRecognizer *)recognizer{

    if (self.delagate && [self.delagate respondsToSelector:@selector(labelTouchUpInside)]) {
        [self.delagate labelTouchUpInside];
    }
}
-(void)MerchantButton:(UIButton*)Btn{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(OrderButtonAction:)]) {
        [self.delagate OrderButtonAction:Btn.tag];
    }
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    
    /* 当前余额 **/
    NSString *current_balance = [NSString  stringWithFormat:@"%@",Data[@"current_balance"]];
    if ([[MethodCommon judgeStringIsNull:current_balance] isEqualToString:@""]) {
        self.current_balance_String = [NSString stringWithFormat:@"¥ 00.00"];
    }else{
        self.current_balance_String = [NSString stringWithFormat:@"¥ %@",current_balance];
    }
   
#pragma mark - [ 平均优惠力度 ] 赋值
   self.current_balance_String1 = [NSString  stringWithFormat:@"%@",Data[@"average_discount"]];
    if ([[MethodCommon judgeStringIsNull:self.current_balance_String1] isEqualToString:@""]) {
        self.current_balance_String1 =@"0.0";
    }
    
   
    NSString *protocol = [NSString stringWithFormat:@"%@ 折 [ 平均优惠力度 ]",self.current_balance_String1];
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:12]];
    attri_str.color = [UIColor colorWithHexString:@"EE4E3E"];
    NSRange ProRange = [protocol rangeOfString:@"[ 平均优惠力度 ]"];

    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"EE4E3E"] userInfo:nil];
    self.Pingju.attributedText = attri_str;
    self.Pingju.textAlignment = NSTextAlignmentCenter;

    
    
    /*今日营收（元）*/
    NSString *today_income = [NSString stringWithFormat:@"%@",Data[@"today_income"]];
    if ([[MethodCommon judgeStringIsNull:today_income] isEqualToString:@""]) {
        self.today_income_String = [NSString stringWithFormat:@" 00.00"];
    }else{
        self.today_income_String = today_income;
        self.today_income.text = [NSString stringWithFormat:@"+%@",self.today_income_String];
    }

    /*累计营收（元）*/
    NSString *cumulative_income = [NSString stringWithFormat:@"%@",Data[@"cumulative_income"]];
    if ([[MethodCommon judgeStringIsNull:cumulative_income] isEqualToString:@""]) {
        self.cumulative_income_String = [NSString stringWithFormat:@" 00.00"];
    }else{
        self.cumulative_income_String = cumulative_income;
        self.cumulative_income.text = [NSString stringWithFormat:@"+%@",self.cumulative_income_String];

    }
    
//    今日营业流水（元）
    NSString *today_order_money = [NSString stringWithFormat:@"%@",Data[@"today_order_money"]];
    if ([[MethodCommon judgeStringIsNull:today_order_money] isEqualToString:@""]) {
        self.today_order_money_String = [NSString stringWithFormat:@" 00.00"];
    }else{
        self.today_order_money_String = today_order_money;
        self.today_order_money.text = [NSString stringWithFormat:@"%@",self.today_order_money_String];
        
    }
//   未结算营业流水（元）
    NSString *order_money = [NSString stringWithFormat:@"%@",Data[@"order_money"]];
    if ([[MethodCommon judgeStringIsNull:order_money] isEqualToString:@""]) {
        self.order_money_String = [NSString stringWithFormat:@" 00.00"];
    }else{
        self.order_money_String = order_money;
        self.order_money.text = [NSString stringWithFormat:@"%@",self.order_money_String];
        
    }
    
    
    
    NSString *islook = [PublicMethods readFromUserD:@"islook"];
    if ([islook isEqualToString:@"YES"]) {
        self.current_balance.text = @"****";
        self.today_income.text = @"****";
        self.cumulative_income.text = @"****";
        self.current_balance_String1 = @"****";
    }else{
        self.current_balance.text = self.current_balance_String;
        
        if ([[MethodCommon judgeStringIsNull:self.today_income_String] isEqualToString:@""]) {
            self.today_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.today_income.text =  [NSString stringWithFormat:@"+ %@",self.today_income_String];
        }
        if ([[MethodCommon judgeStringIsNull:self.cumulative_income_String] isEqualToString:@""]) {
            self.cumulative_income.text =  [NSString stringWithFormat:@"+ 00.00"];
        }else{
            self.cumulative_income.text =  [NSString stringWithFormat:@"+ %@",self.cumulative_income_String];
        }
    }
    
    
//    /*待支付*/
//    NSString *num = [NSString stringWithFormat:@"%@",Data[@"order_num_to_be_paid"]];
//    NSInteger order_num = [num integerValue];
//    if (order_num >0) {
//        self.badgeLable.width = order_num>9 ? 24:17;
//        self.badgeLable.text = [NSString stringWithFormat:@"%ld",order_num];
//        self.badgeLable.hidden = NO;
//    }else if (order_num == 0){
//        self.badgeLable.hidden = YES;
//
//    }
    //order_num_appointment 预约未到店订单数量
    NSString *num = [NSString stringWithFormat:@"%@",Data[@"order_num_appointment"]];
    NSInteger order_num = [num integerValue];
    if (order_num >0) {
        self.badgeLable.width = order_num>9 ? 24:17;
        self.badgeLable.text = [NSString stringWithFormat:@"%ld",order_num];
        self.badgeLable.hidden = NO;
    }else if (order_num == 0){
        self.badgeLable.hidden = YES;
        
    }
    /*已支付订单数量*/
    NSString *num1 = [NSString stringWithFormat:@"%@",Data[@"order_num_have_paid"]];
    NSInteger order_num1 = [num1 integerValue];
    if (order_num1 >0) {
        self.badgeLable1.width = order_num1>9 ? order_num1>99 ? 32 : 24 : 17;
//        self.badgeLable1.width = order_num1>99 ? 32:24;
        self.badgeLable1.text = [NSString stringWithFormat:@"%ld",order_num1];
        self.badgeLable1.hidden = NO;
        
     
        [self.badgeLableRed setTitle:[NSString stringWithFormat:@"   新增 %ld  ",order_num1] forState:UIControlStateNormal];
        self.badgeLableRed.hidden = NO;
        
    }else if (order_num1 == 0){
        self.badgeLable1.hidden = YES;
        
        self.badgeLableRed.hidden = YES;

    }
    /*待退款和待退单订单数量*/
    NSString *num2 = [NSString stringWithFormat:@"%@",Data[@"order_num_wait_to_refund"]];
    NSInteger order_num2 = [num2 integerValue];
    if (order_num2 >0) {
        self.badgeLable2.width = order_num2>9 ? order_num2>99 ? 32 : 24 : 17;
//        self.badgeLable2.width = order_num2>9 ? 24:17;
//        self.badgeLable2.width = order_num2>99 ? 32:24;
        self.badgeLable2.text = [NSString stringWithFormat:@"%ld",order_num2];
        self.badgeLable2.hidden = NO;
    }else if (order_num2 == 0){
        self.badgeLable2.hidden = YES;
    }
    
    
    
    
    /*notice*/
//    SGAdvertScrollView *NoticeScrollView = [[SGAdvertScrollView alloc]initWithFrame:CGRectMake(10, 0, ScreenW-60, 50)];
//    NoticeScrollView.titleColor = [[UIColor blackColor] colorWithAlphaComponent:0.7];
//    NoticeScrollView.scrollTimeInterval = 5;
//    NoticeScrollView.titleFont = [UIFont systemFontOfSize:14];
//    NoticeScrollView.delegate = self;
//    NSString *notice = [NSString stringWithFormat:@"%@",Data[@"notice"]];
//    if ([[MethodCommon judgeStringIsNull:notice] isEqualToString:@""]) {
//        NoticeScrollView.titles =@[@"当前最新版本v1.0.0，请及时更新...",@"当前最新版本v1.0.0，请及时更新..."];
//    }else{
//        NoticeScrollView.titles =@[notice];
//
//    }
//    [self.View2 addSubview:NoticeScrollView];
//    [NoticeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(0);
//        make.left.mas_offset(77);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(50);
//    }];
    
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.IncomeArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashierTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashierTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.Data = self.IncomeArray[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return IPHONEWIDTH(51);
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *ForFooterIn = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, IPHONEWIDTH(51))];
    ForFooterIn.backgroundColor = [UIColor whiteColor];
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:IPHONEWIDTH(12.5)];
    label.textColor =UIColorFromRGBA(0xDCDCDC, 1);
    label.textAlignment = 1;
    if (self.IncomeArray.count>0) {
        label.text  = @"  更多数据进入详情页查看  ";
    }else{
         label.text  = @"  暂无今日数据，更多数据请查看详情页  ";
    }
    [ForFooterIn addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.left.right.bottom.mas_offset(0);
    }];
    return ForFooterIn;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *Dict = self.IncomeArray[indexPath.row];
    if (self.delagate && [self.delagate respondsToSelector:@selector(Revenuedetails:)]) {
        [self.delagate Revenuedetails:Dict];
    }
}

#pragma mark -GET
- (UIView *)View1{
    if (!_View1) {
        _View1 = [[UIView alloc]init];
        _View1.backgroundColor = [UIColor whiteColor];
        _View1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _View1.layer.shadowOffset = CGSizeMake(0,2);
        _View1.layer.shadowOpacity = 1;
        _View1.layer.shadowRadius = 5;
        _View1.layer.cornerRadius = 5;
    }
    return _View1;
}

- (UILabel *)current_balance{
    if (!_current_balance) {
        _current_balance = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _current_balance.textColor =UIColorFromRGB(0xF7AE2A);
        _current_balance.font = [UIFont systemFontOfSize:36];
        _current_balance.textAlignment = 1;
        _current_balance.text = @"¥00.00";
    }
    return _current_balance;
}
- (UILabel *)today_income{
    if (!_today_income) {
        _today_income = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _today_income.textColor =UIColorFromRGB(0xF7AE2A);
        _today_income.font = [UIFont systemFontOfSize:15];
        _today_income.textAlignment = 1;
        //        _today_income.text = @"14228.00";
    }
    return _today_income;
}
- (UILabel *)cumulative_income{
    if (!_cumulative_income) {
        _cumulative_income = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _cumulative_income.textColor =UIColorFromRGB(0xF7AE2A);
        _cumulative_income.font = [UIFont systemFontOfSize:15];
        _cumulative_income.textAlignment = 1;
        //        _cumulative_income.text = @"14228.00";
    }
    return _cumulative_income;
}

- (UILabel *)today_order_money{
    if (!_today_order_money) {
        _today_order_money = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _today_order_money.textColor =UIColorFromRGB(0xF7AE2A);
        _today_order_money.font = [UIFont systemFontOfSize:16];
//        _today_order_money.textAlignment = 1;
        _today_order_money.text = @"00.00";
    }
    return _today_order_money;
}
- (UILabel *)order_money{
    if (!_order_money) {
        _order_money = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _order_money.textColor =UIColorFromRGB(0x3D8AFF);
        _order_money.font = [UIFont systemFontOfSize:16];
//        _order_money.textAlignment = 1;
        _order_money.text = @"00.00";
    }
    return _order_money;
}

- (UIView *)View2{
    if (!_View2) {
        _View2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 50)];
        _View2.backgroundColor = [UIColor whiteColor];
        
        _View2.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _View2.layer.shadowOffset = CGSizeMake(0,2);
        _View2.layer.shadowOpacity = 1;
        _View2.layer.shadowRadius = 5;
        _View2.layer.cornerRadius = 5;
    }
    return _View2;
}
- (UIView *)View3{
    if (!_View3) {
        _View3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 50)];
        _View3.backgroundColor = [UIColor whiteColor];
        
        _View3.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _View3.layer.shadowOffset = CGSizeMake(0,2);
        _View3.layer.shadowOpacity = 1;
        _View3.layer.shadowRadius = 5;
        _View3.layer.cornerRadius = 5;
    }
    return _View3;
}
- (UIView *)View4{
    if (!_View4) {
        _View4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (ScreenW-30)/2, 50)];
        _View4.backgroundColor = [UIColor whiteColor];
        
        _View4.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _View4.layer.shadowOffset = CGSizeMake(0,2);
        _View4.layer.shadowOpacity = 1;
        _View4.layer.shadowRadius = 5;
        _View4.layer.cornerRadius = 5;
    }
    return _View4;
}
- (UIView *)View5{
    if (!_View5) {
        _View5 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, (ScreenW-30)/2, 50)];
        _View5.backgroundColor = [UIColor whiteColor];
        
        _View5.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.1].CGColor;
        _View5.layer.shadowOffset = CGSizeMake(0,2);
        _View5.layer.shadowOpacity = 1;
        _View5.layer.shadowRadius = 5;
        _View5.layer.cornerRadius = 5;
    }
    return _View5;
}
- (UILabel *)total_income{
    if (!_total_income) {
        _total_income = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _total_income.textColor =UIColorFromRGB(0xF7AE2A);
        _total_income.font = [UIFont systemFontOfSize:24];
        //        _total_income.text = @"+1652.00";
    }
    return _total_income;
}
- (UILabel *)total_expense{
    if (!_total_expense) {
        _total_expense = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _total_expense.textColor =UIColorFromRGB(0x3D8AFF);
        _total_expense.font = [UIFont systemFontOfSize:24];
        //        _total_expense.text = @"2213.00";
    }
    return _total_expense;
}

- (UILabel *)begin_date{
    if (!_begin_date) {
        _begin_date = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _begin_date.textColor =UIColorFromRGB(0x222222);
        _begin_date.font = [UIFont systemFontOfSize:15];
        //        _begin_date.text = @"2018-12-12";
    }
    return _begin_date;
}
- (UILabel *)end_date{
    if (!_end_date) {
        _end_date = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 200, 27)];
        _end_date.textColor =UIColorFromRGB(0x222222);
        _end_date.font = [UIFont systemFontOfSize:15];
        //        _end_date.text = @"2018-12-12";
    }
    return _end_date;
}


-(UIImageView *)icon2{
    if (!_icon2) {
        _icon2 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 17, 17)];
        _icon2.image= [UIImage imageNamed:@"ico_notic_blue"];
    }
    return _icon2;
}
-(UIButton *)More{
    if (!_More) {
        _More = [UIButton buttonWithType:UIButtonTypeCustom];
        _More.frame = CGRectMake(0, 0, 40, 32);
        [_More setTitle:@"更多" forState:UIControlStateNormal];
        [_More setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _More.titleLabel.font = [UIFont systemFontOfSize:14];
        [_More addTarget:self action:@selector(MorebuttonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _More;
}

- (UIView *)timeline{
    if (!_timeline) {
        _timeline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 13, 2)];
        _timeline.backgroundColor = UIColorFromRGB(0x3D8AFF);
    }
    return _timeline;
}
-(NSMutableArray *)IncomeArray{
    if (!_IncomeArray) {
        _IncomeArray = [NSMutableArray array];
    }
    return _IncomeArray;
}
- (UIView *)orderView{
    if (!_orderView) {
        _orderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 250)];
        _orderView.backgroundColor = [UIColor whiteColor];
        _orderView.layer.cornerRadius = 5;
        _orderView.layer.masksToBounds = YES;
        
    }
    return _orderView;
}
-(UILabel *)badgeLable{
    if (!_badgeLable) {
        
        _badgeLable = [[UILabel alloc]init];
        _badgeLable.text = @"0";
        _badgeLable.textAlignment = NSTextAlignmentCenter;
        _badgeLable.textColor = [UIColor redColor];
        _badgeLable.font = [UIFont systemFontOfSize:12];
        _badgeLable.layer.cornerRadius = 17*0.5;
        _badgeLable.clipsToBounds = YES;
        _badgeLable.backgroundColor = [UIColor whiteColor];
        _badgeLable.layer.borderWidth = 1;
        _badgeLable.layer.borderColor = [UIColor redColor].CGColor;
        [_badgeLable sizeToFit];
        _badgeLable.hidden = YES;
        
    }
    return _badgeLable;
}
-(UILabel *)badgeLable1{
    if (!_badgeLable1) {
        _badgeLable1 = [[UILabel alloc]init];
        _badgeLable1.text = @"0";
        _badgeLable1.textAlignment = NSTextAlignmentCenter;
        _badgeLable1.textColor = [UIColor redColor];
        _badgeLable1.font = [UIFont systemFontOfSize:12];
        _badgeLable1.layer.cornerRadius = 17*0.5;
        _badgeLable1.clipsToBounds = YES;
        _badgeLable1.backgroundColor = [UIColor whiteColor];
        _badgeLable1.layer.borderWidth = 1;
        _badgeLable1.layer.borderColor = [UIColor redColor].CGColor;
        [_badgeLable1 sizeToFit];
        _badgeLable1.hidden = YES;
        
    }
    return _badgeLable1;
}
-(UILabel *)badgeLable2{
    if (!_badgeLable2) {
        _badgeLable2 = [[UILabel alloc]init];
        _badgeLable2.text = @"0";
        _badgeLable2.textAlignment = NSTextAlignmentCenter;
        _badgeLable2.textColor = [UIColor redColor];
        _badgeLable2.font = [UIFont systemFontOfSize:12];
        _badgeLable2.layer.cornerRadius = 17*0.5;
        _badgeLable2.clipsToBounds = YES;
        _badgeLable2.backgroundColor = [UIColor whiteColor];
        _badgeLable2.layer.borderWidth = 1;
        _badgeLable2.layer.borderColor = [UIColor redColor].CGColor;
        [_badgeLable2 sizeToFit];
        _badgeLable2.hidden = YES;
        
    }
    return _badgeLable2;
}
-(UIButton *)badgeLableRed{
    if (!_badgeLableRed) {
        _badgeLableRed = [UIButton buttonWithType:UIButtonTypeCustom];
        [_badgeLableRed setTitle:@"  新增    " forState:UIControlStateNormal];
        [_badgeLableRed setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        _badgeLableRed.titleLabel.font = [UIFont systemFontOfSize:15];
        _badgeLableRed.titleLabel.numberOfLines = 2;
        _badgeLableRed.backgroundColor = [UIColor redColor];
    }
    return _badgeLableRed;
}
-(YYLabel *)Pingju{
    if (!_Pingju) {
        _Pingju = [[YYLabel alloc]initWithFrame:CGRectMake(0, 0, 180, 24)];
        _Pingju.font = [UIFont systemFontOfSize:12];
        _Pingju.textColor = [UIColor colorWithHexString:@"999999"];
        _Pingju.layer.cornerRadius = 12;
        _Pingju.backgroundColor = [UIColor colorWithHexString:@"F9F9F9"];
        _Pingju.textAlignment = NSTextAlignmentCenter;
        _Pingju.text = @"[ 平均优惠力度 ]";
    }
    return _Pingju;
}
@end
