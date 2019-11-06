//
//  WorkbenchBaseView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "WorkbenchBaseView.h"

@implementation WorkbenchBaseView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    
    //    UIView *baseviewe =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 250)];
    //    baseviewe.backgroundColor = [UIColor blueColor];
    //    [self addSubview:baseviewe];
    
    [self addSubview:self.store_logo];
    [self.store_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(55);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(50, 50));
    }];
    
    
    [self addSubview:self.store_name];
    [self.store_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_top).offset(5);
        make.left.equalTo(self.store_logo.mas_right).offset(14);
        make.right.mas_offset(-15);
    }];
    
    [self addSubview:self.store_address];
    [self.store_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_name.mas_bottom).offset(15);
        make.left.equalTo(self.store_logo.mas_right).offset(14);
        //        make.right.mas_offset(-15);
        make.width.mas_offset(ScreenW - 80 - self.store_logo.right);
        make.height.mas_offset(20);
    }];
    
    /* 图标 */
    UIImageView *icon1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    icon1.image=[UIImage imageNamed:@"icn_fanbei_date"];
    [self addSubview:icon1];
    [icon1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(20);
        make.left.mas_offset(25);
        make.size.mas_offset(CGSizeMake(25, 25));
    }];
    
    [self addSubview:self.open_period];
    [self.open_period mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(icon1.mas_centerY).offset(0);
        make.left.equalTo(icon1.mas_right).offset(10);
        make.right.mas_offset(-95);
    }];
    
    //    [self addSubview:self.SetupButton];
    //    [self.SetupButton mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_offset(-20);
    //        make.centerY.equalTo(icon1.mas_centerY).offset(0);
    //        make.size.mas_offset(CGSizeMake(70, 32));
    //    }];
    
#pragma mark -当前最新版本v2.0，请及时更新...
//    [self addSubview:self.noticeView];
//    [self.noticeView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(200);
//        make.left.mas_offset(15);
//        make.size.mas_offset(CGSizeMake(ScreenW-30, 50));
//    }];
//    [self.noticeView addSubview:self.icon2];
//    [self.icon2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(0);
//        make.left.mas_offset(10);
//        make.size.mas_offset(CGSizeMake(17, 16));
//    }];
    //    [self.noticeView addSubview:self.More];
    //    [self.More mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_offset(0);
    //        make.right.mas_offset(-10);
    //        make.size.mas_offset(CGSizeMake(40, self.noticeView.height));
    //    }];
    //
    //    UIView *moreLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 12)];
    //    moreLine.backgroundColor = UIColorFromRGB(0x999999);
    //    [self.noticeView addSubview:moreLine];
    //    [moreLine mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.centerY.mas_offset(0);
    //        make.right.equalTo(self.More.mas_left).offset(-1);
    //        make.size.mas_offset(CGSizeMake(1, 12));
    //    }];
    
//    UILabel *zuixin = [[UILabel alloc]initWithFrame:CGRectMake(self.icon2.right+10, 18, 30, 13)];
//    zuixin.text = @"最新";
//    zuixin.textAlignment = 1;
//    zuixin.font = [UIFont systemFontOfSize:10];
//    zuixin.textColor = UIColorFromRGB(0x3D8AFF);
//    zuixin.layer.cornerRadius = 1.5;
//    zuixin.layer.borderWidth = 1;
//    zuixin.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
//    [self.noticeView addSubview:zuixin];
    
#pragma mark - 商家中心
    
    CGFloat Bwidth = (ScreenW-50)/4;
    CGFloat Bheight = 88;
    //    NSArray *storeArray = @[@"商家信息",@"商家产品",@"促销设置",@"我的粉丝"];
    NSArray *storeArray = @[@"商家信息",@"商品分类",@"商家产品",@"营销设置"];
    //    NSArray *store_imageArray = @[@"icn_b_center_information",@"icn_b_center_product",@"icn_b_center_set",@"icn_b_center_fan"];
    NSArray *store_imageArray = @[@"icn_b_center_information",@"icn_b_center_classification",@"icn_b_center_product",@"icn_b_center_set"];
    
    /**
     商家中心
     */
    [self addSubview:self.StorecenterView];
    [self.StorecenterView mas_makeConstraints:^(MASConstraintMaker *make) {
        //        make.top.equalTo(self.storeView_info.mas_bottom).offset(15);
        make.top.mas_offset(130);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(129);
    }];
    
    UILabel *centerlabel2= [[UILabel alloc]init];
    centerlabel2.text =@"商家中心";
    centerlabel2.textColor = UIColorFromRGB(0x282828);
    centerlabel2.font = [UIFont systemFontOfSize:15];
    [self.StorecenterView addSubview:centerlabel2];
    [centerlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    for (int i = 0; i<storeArray.count; i++) {
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(i*Bwidth+10, 35, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:store_imageArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",storeArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.StorecenterView addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+10;
        
        if (i == 3) {
            self.haveBtn = thirdBtn;
            [thirdBtn addSubview:self.badgeLable];
            CGFloat badgeW   = 17;
            CGSize imageSize = self.thirdBtn.imageView.frame.size;
            CGFloat imageX   = self.thirdBtn.imageView.frame.origin.x;
            CGFloat imageY   = self.thirdBtn.imageView.frame.origin.y;
            
            CGFloat badgeX = imageX + imageSize.width - badgeW*0.25;
            CGFloat badgeY = imageY - badgeW*0.5;
            
            [self.badgeLable mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.mas_offset(-badgeY);
                make.right.mas_offset(badgeX*3);
                make.size.mas_offset(CGSizeMake(badgeW-7, badgeW-7));
            }];
        }
        
    }

#pragma mark -暂停营业
    [self addSubview:self.statusView];
    [self.statusView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.StorecenterView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 70));
    }];

    UIImageView *statusimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 50, 50)];
    statusimage.image = [UIImage imageNamed:@"icn_store_small"];
    [self.statusView addSubview:statusimage];
    
    UILabel *statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(statusimage.right +10, 12, 80, 20)];
    statusLabel.text = @"营业状态";
    statusLabel.textColor = UIColorFromRGB(0x222222);
    statusLabel.font = [UIFont systemFontOfSize:15];
    [self.statusView addSubview:statusLabel];
    
    
    [self.statusView addSubview:self.status];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(statusLabel.mas_centerY).offset(0);
        make.left.equalTo(statusLabel.mas_right).offset(0);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    
    UILabel *statusLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(statusimage.right +10, statusLabel.bottom, 180, 25)];
    statusLabel1.text = @"商家可根据需要修改营业状态";
    statusLabel1.textColor = UIColorFromRGB(0x999999);
    statusLabel1.font = [UIFont systemFontOfSize:12];
    [self.statusView addSubview:statusLabel1];

    
/*修改营业*/
    self.statusBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.statusBtn2.layer.cornerRadius = 15;
    self.statusBtn2.layer.borderWidth = 1;
    self.statusBtn2.layer.borderColor = UIColorFromRGB(0xD03B34).CGColor;
    [self.statusBtn2 setTitle:@"取消打烊" forState:UIControlStateNormal];
    self.statusBtn2.backgroundColor = UIColorFromRGB(0xFF6765);

    [self.statusBtn2.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.statusBtn2 addTarget:self action:@selector(statuAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.statusView addSubview:self.statusBtn2];
    [self.statusBtn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(70, 30));
    }];
    
    self.statusBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,70,30);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 15;
    [self.statusBtn1.layer addSublayer:gl];
    
    self.statusBtn1.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.statusBtn1.layer.shadowOffset = CGSizeMake(0,4);
    self.statusBtn1.layer.shadowOpacity = 1;
    self.statusBtn1.layer.shadowRadius = 9;
    
    [self.statusBtn1 setTitle:@"设置打样" forState:UIControlStateNormal];
    [self.statusBtn1.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.statusBtn1 addTarget:self action:@selector(statuAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.statusView addSubview:self.statusBtn1];
    [self.statusBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(70, 30));
    }];
    
    
#pragma mark -当日收银（元）
    
    [self addSubview:self.todayView];
    [self.todayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.statusView.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 267));
    }];
    /** 横线 */
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    line1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.todayView addSubview:line1];
    [line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(89);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    
    UIView *line2 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 1)];
    line2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.todayView addSubview:line2];
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(89);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    
    UIView *line3 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    line3.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.todayView addSubview:line3];
    [line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.mas_offset(self.todayView.width/3);
        make.bottom.mas_offset(0);
        make.width.mas_offset(1);
    }];
    
    UIView *line4 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, 1)];
    line4.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.todayView addSubview:line4];
    [line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.mas_offset(self.todayView.width/3*2);
        make.bottom.mas_offset(0);
        make.width.mas_offset(1);
    }];
    
    
    /** 标题 */
    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel1.text = @"当日收银（元）";
    textLabel1.textColor = UIColorFromRGB(0x222222);
    textLabel1.font = [UIFont systemFontOfSize:12];
    textLabel1.textAlignment = 1;
    [self.todayView addSubview:textLabel1];
    [textLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(52);
    }];
    
    UILabel *textLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel2.text = @"当日订单";
    textLabel2.textColor = UIColorFromRGB(0x222222);
    textLabel2.font = [UIFont systemFontOfSize:12];
    [self.todayView addSubview:textLabel2];
    [textLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(52);
    }];
#pragma mark - 跳转订单
    UIButton *orderButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [orderButton addTarget:self action:@selector(orderAction) forControlEvents:UIControlEventTouchUpInside];
    [self.todayView addSubview:orderButton];
    [orderButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.mas_offset(0);
        make.right.equalTo(line4.mas_left).offset(0);
        make.bottom.equalTo(line2.mas_bottom).offset(0);
    }];
    
    UILabel *textLabel2_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel2_2.text = @"当日预定";
    textLabel2_2.textColor = UIColorFromRGB(0x222222);
    textLabel2_2.font = [UIFont systemFontOfSize:12];
    [self.todayView addSubview:textLabel2_2];
    [textLabel2_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.equalTo(line3.mas_left).offset(10);
        make.height.mas_offset(52);
    }];
    UILabel *textLabel2_3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel2_3.text = @"代办事项";
    textLabel2_3.textColor = UIColorFromRGB(0x222222);
    textLabel2_3.font = [UIFont systemFontOfSize:12];
    [self.todayView addSubview:textLabel2_3];
    [textLabel2_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line1.mas_bottom).offset(0);
        make.left.equalTo(line4.mas_left).offset(10);
        make.height.mas_offset(52);
    }];
    
    UILabel *textLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel3.text = @"累计访客";
    textLabel3.textColor = UIColorFromRGB(0x222222);
    textLabel3.font = [UIFont systemFontOfSize:12];
    [self.todayView addSubview:textLabel3];
    [textLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(52);
    }];
    UILabel *textLabel3_2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel3_2.text = @"成功转化率";
    textLabel3_2.textColor = UIColorFromRGB(0x222222);
    textLabel3_2.font = [UIFont systemFontOfSize:12];
    [self.todayView addSubview:textLabel3_2];
    [textLabel3_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.left.equalTo(line3.mas_left).offset(10);
        make.height.mas_offset(52);
    }];
    
    
    [self.todayView addSubview:self.today_income];
    [self.todayView addSubview:self.today_order_num];
    [self.todayView addSubview:self.today_reserve_num];
    [self.todayView addSubview:self.to_do_list_num];
    [self.todayView addSubview:self.cumulative_visitor_num];
    [self.todayView addSubview:self.successful_conversion_rate];
    [self.today_income mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel1.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
    }];
    [self.today_order_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel2.mas_bottom).offset(0);
        make.left.equalTo(textLabel2.mas_left).offset(0);
    }];
    
    [self.today_reserve_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel2_2.mas_bottom).offset(0);
        make.left.equalTo(textLabel2_2.mas_left).offset(0);
    }];
    [self.to_do_list_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel2_3.mas_bottom).offset(0);
        make.left.equalTo(textLabel2_3.mas_left).offset(0);
    }];
    
    [self.cumulative_visitor_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel3.mas_bottom).offset(0);
        make.left.equalTo(textLabel3.mas_left).offset(0);
    }];
    [self.successful_conversion_rate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(textLabel3_2.mas_bottom).offset(0);
        make.left.equalTo(textLabel3_2.mas_left).offset(0);
    }];
    
    UILabel *textLabel3_3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 52)];
    textLabel3_3.text = @"%";
    textLabel3_3.textColor = UIColorFromRGB(0x999999);
    textLabel3_3.font = [UIFont systemFontOfSize:15];
    [self.todayView addSubview:textLabel3_3];
    [textLabel3_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.successful_conversion_rate.mas_bottom).offset(-2);
        make.left.equalTo(self.successful_conversion_rate.mas_right).offset(0);
    }];
    
#pragma mark -店铺订单统计
//    [self addSubview:self.currentView];
//    [self.currentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.todayView.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.size.mas_offset(CGSizeMake(ScreenW-30, 401));
//    }];
    UIImageView *currenticon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 15, 15)];
    currenticon.image = [UIImage imageNamed:@"icn_order_statistics"];
    [self.currentView addSubview:currenticon];
    [currenticon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(17);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(15, 15));
    }];
    
    
    UILabel *currentText = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 45)];
    currentText.text = @"店铺订单统计";
    [self.currentView addSubview:currentText];
    [currentText mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(currenticon.mas_centerY).offset(0);
        make.left.equalTo(currenticon.mas_right).offset(11);
    }];
    
    UIView *Buttonview = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW-50, 35)];
    Buttonview.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
    Buttonview.layer.cornerRadius = 5;
    [self.currentView addSubview:Buttonview];
    [Buttonview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(currentText.mas_bottom).offset(26);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(35);
    }];
    /** 日历选择 */
    //    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [Button setImage:[UIImage imageNamed:@"icn_workbench_calendar"] forState:UIControlStateNormal];
    //    [Button addTarget:self action:@selector(CalendarAction) forControlEvents:UIControlEventTouchUpInside];
    //    [self.currentView addSubview:Button];
    //    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
    //        make.right.mas_offset(0);
    //        make.size.mas_offset(CGSizeMake(35, 30));
    //        make.centerY.equalTo(currenticon.mas_centerY).offset(0);
    //    }];
    
    UIButton *curren_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    curren_Button.frame = CGRectMake(0, 0, (ScreenW-50)/2, 30);
    [curren_Button setTitle:@"订单数" forState:UIControlStateNormal];
    [curren_Button.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [curren_Button setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
    [curren_Button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [curren_Button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    curren_Button.tag = 1;
    curren_Button.selected = YES;
    [Buttonview addSubview:curren_Button];
    [curren_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(-5);
        make.left.mas_offset(0);
        make.width.mas_offset(Buttonview.width/2);
    }];
    
    UIButton *curren_Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    curren_Button1.frame = CGRectMake(0, 0, (ScreenW-50)/2, 30);
    [curren_Button1 setTitle:@"访客数" forState:UIControlStateNormal];
    [curren_Button1.titleLabel setFont:[UIFont systemFontOfSize:13]];
    [curren_Button1 setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateSelected];
    [curren_Button1 setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [curren_Button1 addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    curren_Button1.tag = 2;
    [Buttonview addSubview:curren_Button1];
    [curren_Button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.bottom.mas_offset(-5);
        make.left.mas_offset(Buttonview.width/2);
        make.width.mas_offset(Buttonview.width/2);
    }];
    
    self.currentLine = [[UIView alloc]initWithFrame:CGRectMake(0, curren_Button.bottom, 13, 2)];
    self.currentLine.backgroundColor = UIColorFromRGB(0x3D8AFF);
    self.currentLine.centerX = curren_Button.centerX;
    
    [Buttonview addSubview:self.currentLine];
    
    [self.currentView addSubview:self.current_month_num];
    [self.current_month_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(Buttonview.mas_bottom).offset(30);
        make.height.mas_offset(20);
    }];
    
    [self.currentView addSubview:self.current_month];
    [self.current_month mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.equalTo(self.current_month_num.mas_bottom).offset(14);
        make.height.mas_offset(20);
    }];
    
    
    
    
    
    
    
#pragma mark -订单模块
//    CGFloat Bwidth = (ScreenW-50)/4;
//    CGFloat Bheight = 88;
//    
//    [self addSubview:self.orderView];
//        [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.todayView.mas_bottom).offset(15);
//            make.left.mas_offset(15);
//            make.size.mas_offset(CGSizeMake(ScreenW-30, 130));
//        }];
//    NSArray *orderArray = @[@"全部",@"待支付",@"已支付",@"已评价"];
//    NSArray *order_imageAry = @[@"icn_b_order_all",@"icn_b_order_tobepaid",@"icn_b_order_paid",@"icn_b_order_evaluated"];
//
//    UILabel *centerlabel4= [[UILabel alloc]init];
//    centerlabel4.text =@"商家订单";
//    centerlabel4.textColor = UIColorFromRGB(0x282828);
//    centerlabel4.font = [UIFont systemFontOfSize:15];
//    [self.orderView addSubview:centerlabel4];
//    [centerlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.mas_offset(0);
//        make.size.mas_offset(CGSizeMake(200, 30));
//    }];
//
//    for (int i = 0; i<orderArray.count; i++) {
//        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
//        thirdBtn.frame = CGRectMake(i*Bwidth+10, 35, Bwidth, Bheight);
//        [thirdBtn setImage:[UIImage imageNamed:order_imageAry[i]] forState:UIControlStateNormal];
//        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",orderArray[i]] forState:UIControlStateNormal];
//        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
//        //样式
//        thirdBtn.status = FLAlignmentStatusTop;
//        thirdBtn.fl_padding = 10;
//        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//        [self.orderView addSubview:thirdBtn];
//        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
//        thirdBtn.tag = i+20;
//        if (i == 1) {
//            self.thirdBtn = thirdBtn;
//            [thirdBtn addSubview:self.badgeLable];
//            CGFloat badgeW   = 17;
//            CGSize imageSize = self.thirdBtn.imageView.frame.size;
//            CGFloat imageX   = self.thirdBtn.imageView.frame.origin.x;
//            CGFloat imageY   = self.thirdBtn.imageView.frame.origin.y;
//
//            CGFloat badgeX = imageX + imageSize.width - badgeW*0.25;
//            CGFloat badgeY = imageY - badgeW*0.5;
//
//            [self.badgeLable mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.mas_offset(badgeY);
//                make.left.mas_offset(badgeX);
//                make.size.mas_offset(CGSizeMake(badgeW, badgeW));
//            }];
//        }
//    }
    

    
    
}
#pragma mark - 订单or访客
-(void)buttonAction:(UIButton *)sender{
    self.currentLine.centerX = sender.centerX;
    for (int i = 1; i<3; i++) {
        
        if (sender.tag == i) {
            sender.selected = YES;
            [sender.titleLabel setFont:[UIFont systemFontOfSize:15]];
            continue;
        }
        UIButton *but = (UIButton *)[self viewWithTag:i];
        but.selected = NO;
        [but.titleLabel setFont:[UIFont systemFontOfSize:13]];
        
        if (i == 2) {
            _current_month.text = @"订单数（份）";
            _current_month_num.text = [NSString stringWithFormat:@"%ld",self.order_num];
        }else{
            _current_month.text = @"访客数（人）";
            _current_month_num.text = [NSString stringWithFormat:@"%ld",self.visitor_num];
            
        }
        
    }
    if (self.delagate && [self.delagate respondsToSelector:@selector(OrderOrFang:)]) {
        [self.delagate OrderOrFang:sender.tag];
    }
    
    
}

- (void)advertScrollView:(SGAdvertScrollView *)advertScrollView didSelectedItemAtIndex:(NSInteger)index {
    
    
}

#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    /*头像*/
    NSString *Url = [NSString stringWithFormat:@"%@",Data[@"store_logo"]];
    [self.store_logo setImageWithURL:[NSURL URLWithString:Url] placeholder:[UIImage imageNamed:@"register_empty_avatar"]];
    /*店铺名*/
//    self.store_name.text = [NSString stringWithFormat:@"%@",Data[@"store_name"]];
    NSString *storeName =  [NSString stringWithFormat:@"%@",Data[@"store_name"]];
    [self.store_name setTitle:storeName forState:UIControlStateNormal];
    
    /*地址*/
//    NSString *store_address =[NSString stringWithFormat:@"%@",Data[@"store_address"]];
//    if ([[MethodCommon judgeStringIsNull:store_address] isEqualToString:@""]) {
//
//    }else{
//        [self.store_address setTitle:store_address forState:UIControlStateNormal];
//        self.store_address.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.15);
//        [self.store_address setImage:[UIImage imageNamed:@"ico_arrow_right_white"] forState:UIControlStateNormal];
//
//    }
    
    
    /* 营业周期 */
//    self.open_period.text = [NSString stringWithFormat:@"%@ %@",Data[@"open_period"],Data[@"open_time"]];
    
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
//    [self.noticeView addSubview:NoticeScrollView];
//    [NoticeScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.mas_offset(0);
//        make.left.mas_offset(77);
//        make.right.mas_offset(-10);
//        make.height.mas_offset(50);
//    }];
    
    /* 营业设置 是否有小红点 1表是 2表否  */
    NSString *num = [NSString stringWithFormat:@"%@",Data[@"have_red_point"]];
    NSInteger order_num = [num integerValue];
    if (order_num ==1) {
        self.badgeLable.hidden = NO;
    }else if (order_num == 2){
        self.badgeLable.hidden = YES;
    }
    
    /*营业设置*/
//    store_status
    NSString *store_status = [NSString stringWithFormat:@"%@",Data[@"store_status"]];
    if ([store_status isEqualToString:@"1"]) {
        self.status.text = @"营业中";
        self.status.textColor = UIColorFromRGB(0x3D8AFF);
        self.status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        self.status.backgroundColor = UIColorFromRGB(0xE5F4FF);
        self.statusBtn2.hidden = YES;
        self.statusBtn1.hidden = NO;
        
        
        
    }else if ([store_status isEqualToString:@"2"]){
        self.status.text = @"打烊中";
        self.status.textColor = UIColorFromRGB(0xFF6969);
        self.status.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
        self.status.backgroundColor = UIColorFromRGB(0xFFE7E4);
        self.statusBtn1.hidden = YES;
        self.statusBtn2.hidden = NO;
        [self.statusBtn2 setUserInteractionEnabled:YES];
    }else {
        self.status.text = @"暂停合作";
        self.status.textColor = UIColorFromRGB(0x666666);
        self.status.layer.borderColor = UIColorFromRGB(0xDADADA).CGColor;
        self.status.backgroundColor = UIColorFromRGB(0xEDEDED);
        self.statusBtn1.hidden = YES;
        self.statusBtn2.hidden = NO;
        [self.statusBtn2 setUserInteractionEnabled:NO];
        self.statusBtn2.backgroundColor = UIColorFromRGB(0xB2B2B2);
        self.statusBtn2.layer.borderColor = UIColorFromRGB(0x929292).CGColor;

    }
    
    
    /**
     当天数据
     */
    self.today_income.text = [NSString stringWithFormat:@"%@",Data[@"today_income"]];
    self.today_order_num.text = [NSString stringWithFormat:@"%@",Data[@"today_order_num"]];
    self.today_reserve_num.text = [NSString stringWithFormat:@"%@",Data[@"today_reserve_num"]];
    self.to_do_list_num.text = [NSString stringWithFormat:@"%@",Data[@"to_do_list_num"]];
    self.cumulative_visitor_num.text = [NSString stringWithFormat:@"%@",Data[@"cumulative_visitor_num"]];
    self.successful_conversion_rate.text = [NSString stringWithFormat:@"%@",Data[@"successful_conversion_rate"]];
    
    
    
//    storeBaseModel *Model = [storeBaseModel getUseData];
//
//    NSString *num = [NSString stringWithFormat:@"%@",Model.order_num_to_be_paid];
//    NSInteger order_num = [num integerValue];
//
//    if (order_num >0) {
//        self.badgeLable.text = [NSString stringWithFormat:@"%ld",order_num];
//        [self.badgeLable sizeToFit];
//        self.badgeLable.hidden = NO;
//    }else if (order_num == 0){
//        self.badgeLable.hidden = YES;
//
//    }
    
}
- (void)setCurrent_Data:(NSDictionary *)Current_Data{
    
    //    self.Current_Data = Current_Data;
    /** 订单数 */
    NSString *order = [NSString stringWithFormat:@"%@",Current_Data[@"current_month_order_num"]];
    self.order_num = [order integerValue];
    
    NSString *visitor = [NSString stringWithFormat:@"%@",Current_Data[@"current_month_visitor_num"]];
    self.visitor_num = [visitor integerValue];
    
    self.current_month_num.text = [NSString stringWithFormat:@"%ld",self.order_num];
    
    
}
#pragma mark - 去设置
-(void)setAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(SetupAction)]) {
        [self.delagate SetupAction];
    }
}
#pragma mark - 营业
-(void)statuAction1:(UIButton *)sender{

    if (self.delagate && [self.delagate respondsToSelector:@selector(Setstatus:)]) {
        [self.delagate Setstatus:2];
    }
    
    
}
-(void)statuAction2:(UIButton *)sender{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Setstatus:)]) {
        [self.delagate Setstatus:1];
    }
    
    
}
#pragma mark - 更多
-(void)MorebuttonAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(MoreAction)]) {
        [self.delagate MoreAction];
    }
}
#pragma mark - 日历
-(void)CalendarAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(Calendar)]) {
        [self.delagate Calendar];
    }
}
#pragma mark - 订单
-(void)orderAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(OrderButtonAction:)]) {
        [self.delagate OrderButtonAction:0];
    }
}
-(void)MerchantButton:(UIButton*)Btn{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(OrderButtonAction:)]) {
        [self.delagate OrderButtonAction:Btn.tag];
    }
    
}
#pragma mark -GET
-(UIImageView *)store_logo{
    if (!_store_logo) {
        _store_logo = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
        _store_logo.image= [UIImage imageNamed:@"register_empty_avatar"];
        _store_logo.layer.cornerRadius = 50/2;
        _store_logo.layer.masksToBounds = YES;
        _store_logo.layer.borderColor = UIColorFromRGBA(0xFFFFFF, 1).CGColor;
        _store_logo.layer.borderWidth = 2;
        
    }
    return _store_logo;
}
-(FL_Button *)store_name{
    if (!_store_name) {
//        _store_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-60, 30)];
//        _store_name.numberOfLines = 0;
//        _store_name.textColor = UIColorFromRGB(0x222222);
//        _store_name.font = [UIFont systemFontOfSize:20];
        
        _store_name = [FL_Button buttonWithType:UIButtonTypeCustom];
        _store_name.frame = CGRectMake(12, STATUS_BAR_HEIGHT, 160, 44);
        [_store_name setImage:[UIImage imageNamed:@"icn_branch_exchange_black"] forState:UIControlStateNormal];
        [_store_name setTitle:[NSString stringWithFormat:@""] forState:UIControlStateNormal];
        [_store_name setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        //样式
        _store_name.status = FLAlignmentStatusLeft;
        _store_name.fl_padding = 10;
        _store_name.titleLabel.font = [UIFont systemFontOfSize:20];
        
    }
    return _store_name;
}

-(FL_Button *)store_address{
    if (!_store_address) {
        _store_address = [FL_Button buttonWithType:UIButtonTypeCustom];
        _store_address.frame = CGRectMake(0, 0, ScreenW-60, 30);
        [_store_address setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _store_address.titleLabel.font = [UIFont systemFontOfSize:13];
        _store_address.status = FLAlignmentStatusCenter;
        
        _store_address.layer.cornerRadius = 10;
        _store_address.layer.masksToBounds = YES;
        
    }
    return _store_address;
}
-(UILabel *)open_period{
    if (!_open_period) {
        _open_period = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-60, 30)];
        _open_period.numberOfLines = 0;
        _open_period.textColor = UIColorFromRGB(0xFFFFFF);
        _open_period.font = [UIFont systemFontOfSize:13];
        //        _open_period.text = @"周一致周日 09:00-12:00 周一致周日 09:00-12:00 周一致周日 09:00-12:00";
        
    }
    return _open_period;
}
-(UIButton *)SetupButton{
    if (!_SetupButton) {
        _SetupButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SetupButton.frame = CGRectMake(0, 0, 70, 32);
        [_SetupButton setTitle:@"去设置" forState:UIControlStateNormal];
        [_SetupButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        _SetupButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _SetupButton.layer.borderWidth = 1;
        _SetupButton.layer.cornerRadius = 16;
        _SetupButton.layer.masksToBounds = YES;
        _SetupButton.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
        [_SetupButton addTarget:self action:@selector(setAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SetupButton;
}
- (UIView *)noticeView{
    if (!_noticeView) {
        _noticeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 50)];
        _noticeView.backgroundColor = [UIColor whiteColor];
        _noticeView.layer.cornerRadius = 5;_noticeView.layer.masksToBounds = YES;
    }
    return _noticeView;
}
- (UIView *)statusView{
    if (!_statusView) {
        _statusView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 50)];
        _statusView.backgroundColor = [UIColor whiteColor];
        _statusView.layer.cornerRadius = 5;_statusView.layer.masksToBounds = YES;
    }
    return _statusView;
}
-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 45, 20)];
        _status.backgroundColor = UIColorFromRGB(0xE5F4FF);
        _status.font = [UIFont systemFontOfSize:10];
        _status.textColor = UIColorFromRGB(0x3D8AFF);
        _status.layer.borderWidth= 1;
        _status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        _status.textAlignment = 1;
        _status.layer.cornerRadius = 10;
        _status.layer.masksToBounds = YES;
        _status.text = @"营业中";
    }
    return _status;
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
- (UIView *)todayView{
    if (!_todayView) {
        _todayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 267)];
        _todayView.backgroundColor = [UIColor whiteColor];
        _todayView.layer.cornerRadius = 5;_todayView.layer.masksToBounds = YES;
        
    }
    return _todayView;
}

-(UILabel *)today_income{
    if (!_today_income) {
        _today_income = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _today_income.numberOfLines = 0;
        _today_income.textAlignment = 1;
        _today_income.textColor = UIColorFromRGB(0xF7AE2A);
        _today_income.font = [UIFont systemFontOfSize:24];
        _today_income.text = @"00.00";
        
    }
    return _today_income;
}
-(UILabel *)today_order_num{
    if (!_today_order_num) {
        _today_order_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _today_order_num.numberOfLines = 0;
        _today_order_num.textColor = UIColorFromRGB(0xF7AE2A);
        _today_order_num.font = [UIFont systemFontOfSize:24];
        _today_order_num.text = @"00";
        
    }
    return _today_order_num;
}
-(UILabel *)today_reserve_num{
    if (!_today_reserve_num) {
        _today_reserve_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _today_reserve_num.numberOfLines = 0;
        _today_reserve_num.textColor = UIColorFromRGB(0xF7AE2A);
        _today_reserve_num.font = [UIFont systemFontOfSize:24];
        _today_reserve_num.text = @"00";
        
    }
    return _today_reserve_num;
}
-(UILabel *)to_do_list_num{
    if (!_to_do_list_num) {
        _to_do_list_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _to_do_list_num.numberOfLines = 0;
        _to_do_list_num.textColor = UIColorFromRGB(0xF7AE2A);
        _to_do_list_num.font = [UIFont systemFontOfSize:24];
        _to_do_list_num.text = @"00";
        
    }
    return _to_do_list_num;
}
-(UILabel *)cumulative_visitor_num{
    if (!_cumulative_visitor_num) {
        _cumulative_visitor_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _cumulative_visitor_num.numberOfLines = 0;
        _cumulative_visitor_num.textColor = UIColorFromRGB(0xF7AE2A);
        _cumulative_visitor_num.font = [UIFont systemFontOfSize:24];
        _cumulative_visitor_num.text = @"00";
        
    }
    return _cumulative_visitor_num;
}
-(UILabel *)successful_conversion_rate{
    if (!_successful_conversion_rate) {
        _successful_conversion_rate = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _successful_conversion_rate.numberOfLines = 0;
        _successful_conversion_rate.textColor = UIColorFromRGB(0xF7AE2A);
        _successful_conversion_rate.font = [UIFont systemFontOfSize:24];
        _successful_conversion_rate.text = @"00";
        
    }
    return _successful_conversion_rate;
}
- (UIView *)currentView{
    if (!_currentView) {
        _currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 401)];
        _currentView.backgroundColor = [UIColor whiteColor];
        _currentView.layer.cornerRadius = 5;_currentView.layer.masksToBounds = YES;
        
    }
    return _currentView;
}


-(UILabel *)current_month_num{
    if (!_current_month_num) {
        _current_month_num = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _current_month_num.numberOfLines = 0;
        _current_month_num.textAlignment =1;
        _current_month_num.textColor = UIColorFromRGB(0xF7AE2A);
        _current_month_num.font = [UIFont systemFontOfSize:27];
        _current_month_num.text = @"00";
        
    }
    return _current_month_num;
}
-(UILabel *)current_month{
    if (!_current_month) {
        _current_month = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW/4, 30)];
        _current_month.numberOfLines = 0;
        _current_month.textAlignment = 1;
        _current_month.textColor = UIColorFromRGB(0x999999);
        _current_month.font = [UIFont systemFontOfSize:13];
        _current_month.text = @"订单数（份）";
        
    }
    return _current_month;
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
//        _badgeLable.text = @"0";
        _badgeLable.textAlignment = NSTextAlignmentCenter;
        _badgeLable.textColor = [UIColor redColor];
        _badgeLable.font = [UIFont systemFontOfSize:12];
        _badgeLable.layer.cornerRadius = 10*0.5;
        _badgeLable.clipsToBounds = YES;
        _badgeLable.backgroundColor = [UIColor redColor];
        _badgeLable.layer.borderWidth = 1;
        _badgeLable.layer.borderColor = [UIColor redColor].CGColor;
        [_badgeLable sizeToFit];
        _badgeLable.hidden = YES;
        
    }
    return _badgeLable;
}


- (UIView *)StorecenterView{
    if (!_StorecenterView) {
        _StorecenterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 250)];
        _StorecenterView.backgroundColor = [UIColor whiteColor];
        _StorecenterView.layer.cornerRadius = 5;
        _StorecenterView.layer.masksToBounds = YES;
        
    }
    return _StorecenterView;
}

@end
