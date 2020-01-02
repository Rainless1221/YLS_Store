//
//  storeCenterView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "storeCenterView.h"

@implementation storeCenterView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
//    [self addSubview:self.storeView1];
//    [self addSubview:self.storeView2];
    [self addSubview:self.storeView3];
//    [self addSubview:self.storeView4];
    [self addSubview:self.storeView5];
    [self addSubview:self.storeView_info];
    [self addSubview:self.storeView_banner];
#pragma mark - 商家信息 (改版前)
    /**
     商家信息
     */
//    [self.storeView1 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(294);
//    }];
    
    /**
     banner轮播
     */
    
    [self.storeView1 addSubview:self.BannerView];
    [self.BannerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.height.mas_offset(200);
    }];
    
    UIImageView *bannimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 200)];
    bannimage.image= [UIImage imageNamed:@"shop_index_default_image"];
    [self.BannerView addSubview:bannimage];
    
    
    
    
    /*定位按钮*/
    UIButton *latButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [latButton setTitle:@"定位" forState:UIControlStateNormal];
    latButton.titleLabel.font = [UIFont systemFontOfSize:15];
    [latButton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    latButton.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
    latButton.layer.borderWidth = 1;
    latButton.layer.cornerRadius = 16;
    [latButton addTarget:self action:@selector(latAction) forControlEvents:UIControlEventTouchUpInside];
    latButton.frame = CGRectMake(self.storeView1.width - 70, self.storeView1.height - 48, 60, 32);
    [self.storeView1 addSubview:latButton];
    [latButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-16);
        make.size.mas_offset(CGSizeMake(60, 32));
    }];
    /*定位图标*/
    UIImageView *latImage = [[UIImageView alloc]init];
    latImage.image = [UIImage imageNamed:@"icn_blue_location"];
    latImage.frame = CGRectMake(10, latButton.bottom + 4, 17, 19);
    [self.storeView1 addSubview:latImage];
    [latImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(latButton.mas_top).offset(4);
        make.size.mas_offset(CGSizeMake(17, 19));
    }];
    /* 地址*/
//    self.store_address.frame = CGRectMake(latImage.right +4, latButton.top+4, 150, 30);
//    [self.storeView1 addSubview:self.store_address];
//    //    self.store_address.text = @"中华城南区黄氏老宅普佑街44号之5 （中华城哈根达斯对面）";
//    [self.store_address mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(latButton.mas_top).offset(4);
//        make.left.equalTo(latImage.mas_right).offset(4);
//        make.right.equalTo(latButton.mas_left).offset(-5);
//        make.bottom.mas_offset(-2);
//    }];
    
    /*经营类型*/
//    [self.storeView1 addSubview:self.category_pic];
//    [self.storeView1 addSubview:self.store_category];
//    [self.category_pic mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_offset(10);
//        make.top.equalTo(self.BannerView.mas_bottom).offset(15);
//        make.size.mas_offset(CGSizeMake(16, 16));
//    }];
//    [self.store_category mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.category_pic.mas_top).offset(0);
//        make.left.equalTo(self.category_pic.mas_right).offset(10);
//        make.height.mas_offset(15);
//    }];
    
//    /* 粉丝*/
//    [self.storeView1 addSubview:self.fans_number];
//    [self.fans_number mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.store_category.mas_top).offset(0);
//        make.left.equalTo(self.store_category.mas_right).offset(24);
//        make.height.mas_offset(15);
//    }];
//    UIView *shu = [[UIView alloc]init];
//    shu.backgroundColor= UIColorFromRGB(0x999999);
//    [self.storeView1 addSubview:shu];
//    [shu mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.category_pic.mas_top).offset(0);
//        make.left.equalTo(self.fans_number.mas_right).offset(12);
//        make.size.mas_offset(CGSizeMake(1, 15));
//    }];
//    /* 商品*/
//    [self.storeView1 addSubview:self.goods_number];
//    [self.goods_number mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.category_pic.mas_top).offset(0);
//        make.left.equalTo(self.fans_number.mas_right).offset(24);
//        make.height.mas_offset(15);
//    }];
    
#pragma mark - 商家信息 (改版后)
    [self.storeView_banner mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(170);
    }];
    UIImageView *backgrounImg = [[UIImageView alloc]init];
    backgrounImg.image = [UIImage imageNamed:@"bg_usercenter_eluson_top"];
    backgrounImg.layer.cornerRadius = 5;
    backgrounImg.layer.masksToBounds = YES;
    [self.storeView_banner addSubview:backgrounImg];
    [backgrounImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(15);
    }];
    
    FL_Button *storeButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    [storeButton setTitle:@"商家主页" forState:UIControlStateNormal];
    storeButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [storeButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
//    storeButton.backgroundColor = [UIColor orangeColor];
    storeButton.layer.cornerRadius = 5;
    [storeButton setImage:[UIImage imageNamed:@"ico_arrow_right_white"] forState:UIControlStateNormal];
    [storeButton setBackgroundImage:[UIImage imageNamed:@"icn_usercenter_common_edit"] forState:UIControlStateNormal];
    [storeButton addTarget:self action:@selector(detaAction) forControlEvents:UIControlEventTouchUpInside];
    //样式
    storeButton.status = FLAlignmentStatusCenter;
    storeButton.fl_padding = 10;
    [self.storeView_banner addSubview:storeButton];
    [storeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(7);
        make.top.mas_offset(16);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(90), 30));
    }];
     /*id+头像*/
    [self.storeView_banner addSubview:self.goods_pic];
    [self.storeView_banner addSubview:self.goods_id];
    [self.goods_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(-11);
        make.size.mas_offset(CGSizeMake(90, 90));
    }];
    [self.goods_id mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.goods_pic.mas_right).offset(IPHONEWIDTH(10));
        make.top.mas_offset(18);
//        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(156), 20));
        make.right.equalTo(storeButton.mas_left).offset(-5);
    }];
    
    /*经营类型*/
    [self.storeView_banner addSubview:self.category_pic];
    [self.storeView_banner addSubview:self.store_category];
    [self.category_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.bottom.mas_offset(-50);
        make.size.mas_offset(CGSizeMake(16, 16));
    }];
    [self.store_category mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.category_pic.mas_top).offset(0);
        make.left.equalTo(self.category_pic.mas_right).offset(10);
        make.right.mas_offset(-5);
        make.height.mas_offset(15);
    }];
    /* 粉丝*/
    [self.storeView_banner addSubview:self.fans_number];
    [self.fans_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.left.mas_offset(15);
        make.height.mas_offset(15);
    }];
    UIView *shu = [[UIView alloc]init];
    shu.backgroundColor= UIColorFromRGB(0x22222);
    [self.storeView_banner addSubview:shu];
    [shu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.left.equalTo(self.fans_number.mas_right).offset(12);
        make.size.mas_offset(CGSizeMake(1, 15));
    }];
    /* 商品*/
    [self.storeView_banner addSubview:self.goods_number];
    [self.goods_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.left.equalTo(self.fans_number.mas_right).offset(24);
        make.height.mas_offset(15);
    }];
    
    
    
    
        [self.storeView_info mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.storeView_banner.mas_bottom).offset(15);
            make.left.mas_offset(15);
            make.right.mas_offset(-15);
            make.height.mas_offset(165);
        }];

    //地址
    UIImageView *icon_add= [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 20, 20)];
    icon_add.image = [UIImage imageNamed:[NSString stringWithFormat:@"icn_yellow_location"]];
    [self.storeView_info addSubview:icon_add];
    
    self.store_address.frame = CGRectMake(latImage.right +4, latButton.top+4, 150, 30);
    [self.storeView_info addSubview:self.store_address];
    //    self.store_address.text = @"中华城南区黄氏老宅普佑街44号之5 （中华城哈根达斯对面）";
    [self.store_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.equalTo(icon_add.mas_right).offset(4);
        make.right.mas_offset(-5);
        make.height.mas_offset(40);
    }];
    //名称
    UIImageView *icon_mane = [[UIImageView alloc]initWithFrame:CGRectMake(15, 70, 25, 30)];
    icon_mane.image = [UIImage imageNamed:[NSString stringWithFormat:@"icn_yellow_person"]];
    [self.storeView_info addSubview:icon_mane];
    [icon_mane mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(64);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.storeView_info addSubview:self.store_name];
    [self.store_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon_mane.mas_top).offset(0);
        make.left.equalTo(icon_add.mas_right).offset(4);
        make.right.mas_offset(-5);
        make.height.mas_offset(20);
    }];
    //联系方式
    UIImageView *icon_phone = [[UIImageView alloc]initWithFrame:CGRectMake(15, 120, 25, 30)];
    icon_phone.image = [UIImage imageNamed:[NSString stringWithFormat:@"icn_yellow_phone"]];
    [self.storeView_info addSubview:icon_phone];
    [icon_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.top.mas_offset(98);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.storeView_info addSubview:self.store_phone];
    [self.store_phone mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon_phone.mas_top).offset(0);
        make.left.equalTo(icon_add.mas_right).offset(4);
        make.right.mas_offset(-5);
        make.height.mas_offset(20);
    }];
    
    //周一至周日
    UIImageView *icon_time = [[UIImageView alloc]initWithFrame:CGRectMake(15, 120, 25, 30)];
    icon_time.image = [UIImage imageNamed:[NSString stringWithFormat:@"icn_yellow_time"]];
    [self.storeView_info addSubview:icon_time];
    [icon_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.bottom.mas_offset(-17);
        make.size.mas_offset(CGSizeMake(20, 20));
    }];
    [self.storeView_info addSubview:self.store_time];
    [self.store_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(icon_time.mas_top).offset(0);
        make.left.equalTo(icon_add.mas_right).offset(4);
        make.right.mas_offset(-80);
        make.bottom.mas_offset(-1);
    }];
    
    
    FL_Button *DeatButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    [DeatButton setTitle:@"查看详情" forState:UIControlStateNormal];
    DeatButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [DeatButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [DeatButton setImage:[UIImage imageNamed:@"icn_guide_point_arrow_yellow"] forState:UIControlStateNormal];

    [DeatButton addTarget:self action:@selector(detaAction) forControlEvents:UIControlEventTouchUpInside];
    //样式
    DeatButton.status = FLAlignmentStatusCenter;
    DeatButton.fl_padding = 10;
    [self.storeView_info addSubview:DeatButton];
    [DeatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-5);
        make.size.mas_offset(CGSizeMake(70, 30));
    }];
    
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
//    [self.storeView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.storeView_info.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(129);
//    }];
    
    UILabel *centerlabel2= [[UILabel alloc]init];
    centerlabel2.text =@"商家中心";
    centerlabel2.textColor = UIColorFromRGB(0x282828);
    centerlabel2.font = [UIFont systemFontOfSize:15];
    [self.storeView2 addSubview:centerlabel2];
    [centerlabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
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
        [self.storeView2 addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+10;
    }
    
    
#pragma mark - 产品展示
    
    /**
     产品展示
     */
    [self.storeView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeView_info.mas_bottom).offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(0);
    }];
    
    
    
    
    
    
    
    
#pragma mark - 商家订单
    NSArray *orderArray = @[@"全部",@"待支付",@"已支付",@"已评价"];
    NSArray *order_imageAry = @[@"icn_b_order_all",@"icn_b_order_tobepaid",@"icn_b_order_paid",@"icn_b_order_evaluated"];
    
    /**
     商家订单
     */
//    [self.storeView4 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.storeView3.mas_bottom).offset(15);
//        make.left.mas_offset(15);
//        make.right.mas_offset(-15);
//        make.height.mas_offset(129);
//    }];
    UILabel *centerlabel4= [[UILabel alloc]init];
    centerlabel4.text =@"商家订单";
    centerlabel4.textColor = UIColorFromRGB(0x282828);
    centerlabel4.font = [UIFont systemFontOfSize:15];
    [self.storeView4 addSubview:centerlabel4];
    [centerlabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    for (int i = 0; i<orderArray.count; i++) {
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(i*Bwidth+10, 35, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:order_imageAry[i]] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",orderArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.storeView4 addSubview:thirdBtn];
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
        }
    }
    
    
#pragma mark - 服务中心
    //,@"最新资讯"  ,@"icn_service_c_information"
    //     NSArray *serviceArray = @[@"账户与安全",@"银行卡",@"加盟代理",@"关于一鹿省",@"帮助与客服",@"版本更新"];
    NSArray *serviceArray = @[@"账户与安全",@"分店管理",@"提现认证",@"我的粉丝",@"加盟代理",@"关于一鹿省",@"帮助与客服",@"版本更新",@"绑定支付宝",@"店铺设置"];
    //    NSArray *service_imageAry = @[@"icn_service_c_security",@"icn_service_c_bankcard",@"icn_service_c_join",@"icn_service_c_about",@"icn_service_c_cut_service",@"icn_service_c_update"];
    NSArray *service_imageAry = @[@"icn_service_c_security",@"icn_service_c_branch",@"icn_service_c_authentication",@"icn_service_c_fans",@"icn_service_c_join",@"icn_service_c_about",@"icn_service_c_cut_service",@"icn_service_c_update",@"icn_service_c_zhifubao",@"icn_service_c_store_setup"];
    /**
     服务中心
     */
    [self.storeView5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeView3.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(298);
    }];
    
    UILabel *centerlabel5= [[UILabel alloc]init];
    centerlabel5.text =@"服务中心";
    centerlabel5.textColor = UIColorFromRGB(0x282828);
    centerlabel5.font = [UIFont systemFontOfSize:15];
    [self.storeView5 addSubview:centerlabel5];
    [centerlabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(5);
        make.size.mas_offset(CGSizeMake(200, 30));
    }];
    
    
    for (int i = 0; i<serviceArray.count; i++) {
        NSInteger index = i % 4;
        NSInteger page = i / 4;
        
        FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(index*Bwidth+10, page*Bheight+35, Bwidth, Bheight);
        [thirdBtn setImage:[UIImage imageNamed:service_imageAry[i]] forState:UIControlStateNormal];
        [thirdBtn setTitle:[NSString stringWithFormat:@"%@",serviceArray[i]] forState:UIControlStateNormal];
        [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
        //样式
        thirdBtn.status = FLAlignmentStatusTop;
        thirdBtn.fl_padding = 10;
        thirdBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.storeView5 addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+30;
        
        
    }
    
    
    UIImageView *MoreImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 12)];
    MoreImage.image = [UIImage imageNamed:@"icn_function_tobedeveloped_title"];
    [self addSubview:MoreImage];
    [MoreImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.storeView5.mas_bottom).offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(15);
    }];
    
    
}


#pragma mark - 模块事件
-(void)MerchantButton:(UIButton*)Btn{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(pushViewcontroler:)]) {
        [self.delagate pushViewcontroler:Btn.tag];
    }
    
}
-(void)latAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(LatViewcontroler)]) {
        [self.delagate LatViewcontroler];
    }
}
-(void)detaAction{
    if (self.delagate && [self.delagate respondsToSelector:@selector(pushViewcontroler:)]) {
        [self.delagate pushViewcontroler:10];
    }
}
#pragma mark  - banner代理方法
- (void)banner:(HQBannerView *)bannerView scrollToLastIndex:(NSInteger)lastIndex {
    NSLog(@"last%ld", lastIndex);
}

- (void)banner:(HQBannerView *)bannerView currentItemAtIndex:(NSInteger)index {
    NSLog(@"current%ld", index);
}

- (void)banner:(HQBannerView *)bannerView didSelectItemAtIndex:(NSInteger)index {
    NSLog(@"selectedt%ld", index);
}

#pragma mark - 赋值
-(void)setData:(storeBaseModel *)Data{
    
    /** 商家地址 */
    self.store_address.text = [NSString stringWithFormat:@"%@",Data.store_address];
    /** 商家经营类型 */
    NSString *url = [NSString stringWithFormat:@"%@",Data.category_pic];
    NSString *imageUrl = [url stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [self.category_pic sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:[UIImage imageNamed:@"icn_shop_type_cycle_green"]];
    self.store_category.text = [NSString stringWithFormat:@"%@",Data.store_category];
    
    /** ID */
    NSString *store_code  = [NSString stringWithFormat:@"ID:%@",Data.store_code];
    if ([[MethodCommon judgeStringIsNull:store_code] isEqualToString:@""]) {
       
    }else{
        self.goods_id.text = store_code;
    }
    /** 商家姓名 */
    NSString *merchant_name = [NSString stringWithFormat:@"%@",Data.merchant_name];
    if ([[MethodCommon judgeStringIsNull:merchant_name] isEqualToString:@""]) {
        
    }else{
        self.store_name.text = merchant_name;
    }
    
    /** 店铺联系方式  */
    NSString *merchant_mobile = [NSString stringWithFormat:@"%@",Data.merchant_mobile];
    if ([[MethodCommon judgeStringIsNull:merchant_mobile] isEqualToString:@""]) {
        
    }else{
        self.store_phone.text = merchant_mobile;

    }
    /** 经营周期  经营时段 */
    NSString *TimeString  = [NSString new];
     NSString *business_times = [NSString stringWithFormat:@"%@",Data.business_times];
    NSString *business_hours = [NSString stringWithFormat:@"%@",Data.business_hours];
    if ([[MethodCommon judgeStringIsNull:business_times] isEqualToString:@""]) {
        
    }else{
        TimeString = [NSString stringWithFormat:@"%@",business_times];
    }
    if ([[MethodCommon judgeStringIsNull:business_hours] isEqualToString:@""]) {
        
    }else{
        TimeString = [TimeString stringByAppendingString:business_hours];
    }
        self.store_time.text = TimeString;
    /** 商家粉丝 */
    self.fans_number.text = [NSString stringWithFormat:@"%@ 粉丝",Data.fans_number];
    /** 商家商品 */
    self.goods_number.text = [NSString stringWithFormat:@"%@ 商品",Data.goods_number];
    /** 商家图片 */
    NSString *store_pic = [NSString stringWithFormat:@"%@",Data.store_logo];
    // 用指定字符串分割字符串，返回一个数组
//    NSArray *picsarray = [store_pic componentsSeparatedByString:@","];
//    
//    NSString *url_pic= [NSString stringWithFormat:@"%@",picsarray[0]];
//    NSString *imageUrl_pic = [url_pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
     [self.goods_pic sd_setImageWithURL:[NSURL URLWithString:store_pic] placeholderImage:[UIImage imageNamed:@"register_empty_avatar"]];
    
//    self.bannerView.imageURLArray = picsarray;
//    self.bannerView.pageTextAliment = HQBannerViewPageTextAlimentRightTop;
//    [self.BannerView addSubview:self.bannerView];
//    [self.bannerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.bottom.mas_offset(0);
//    }];
//    if (picsarray.count==0) {
//        self.bannerView.hidden = YES;
//    }
    

    
    
    NSString *num = [NSString stringWithFormat:@"%@",Data.order_num_to_be_paid];
    NSInteger order_num = [num integerValue];
    
    if (order_num >0) {
//        [self.thirdBtn setBadgeValue:order_num Hidden:NO];
        self.badgeLable.text = [NSString stringWithFormat:@"%ld",order_num];
//        [self.badgeLable sizeToFit];
        self.badgeLable.hidden = NO;
    }else if (order_num == 0){
//        [self.thirdBtn setBadgeValue:order_num Hidden:YES];
        self.badgeLable.hidden = YES;
        
    }
    
    
}

#pragma mark - GET

-(UIView *)storeView1{
    if (!_storeView1) {
        _storeView1 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 294)];
        _storeView1.backgroundColor = [UIColor whiteColor];
        _storeView1.layer.cornerRadius = 5;
        _storeView1.layer.masksToBounds = YES;
        _storeView1.layer.shadowOpacity = 0.2;
        _storeView1.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView1.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView1;
}
-(UIView *)storeView2{
    if (!_storeView2) {
        _storeView2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.storeView1.bottom+15, ScreenW-30, 129)];
        _storeView2.backgroundColor = [UIColor whiteColor];
        _storeView2.layer.cornerRadius = 5;
        _storeView2.layer.masksToBounds = YES;
        _storeView2.layer.shadowOpacity = 0.2;
        _storeView2.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView2.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView2;
}
-(UIView *)storeView3{
    if (!_storeView3) {
        _storeView3 = [[UIView alloc]init];
        _storeView3.backgroundColor = [UIColor clearColor];
        _storeView3.layer.cornerRadius = 5;
        _storeView3.layer.masksToBounds = YES;
        _storeView3.layer.shadowOpacity = 0.2;
        _storeView3.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView3.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView3;
}
-(UIView *)storeView4{
    if (!_storeView4) {
        _storeView4 = [[UIView alloc]init];
        _storeView4.backgroundColor = [UIColor whiteColor];
        _storeView4.layer.cornerRadius = 5;
        _storeView4.layer.masksToBounds = YES;
        _storeView4.layer.shadowOpacity = 0.2;
        _storeView4.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView4.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView4;
}
-(UIView *)storeView5{
    if (!_storeView5) {
        _storeView5 = [[UIView alloc]init];
        _storeView5.backgroundColor = [UIColor whiteColor];
        _storeView5.layer.cornerRadius = 5;
        _storeView5.layer.masksToBounds = YES;
        _storeView5.layer.shadowOpacity = 0.2;
        _storeView5.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView5.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView5;
}
-(UIView *)storeView_info{
    if (!_storeView_info) {
        _storeView_info = [[UIView alloc]init];
        _storeView_info.backgroundColor = [UIColor whiteColor];
        _storeView_info.layer.cornerRadius = 5;
        _storeView_info.layer.masksToBounds = YES;
        _storeView_info.layer.shadowOpacity = 0.2;
        _storeView_info.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView_info.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView_info;
}
-(UIView *)storeView_banner{
    if (!_storeView_banner) {
        _storeView_banner = [[UIView alloc]init];
        _storeView_banner.backgroundColor = [UIColor whiteColor];
        _storeView_banner.layer.cornerRadius = 5;
        _storeView_banner.layer.masksToBounds = YES;
        _storeView_banner.clipsToBounds = NO;
        _storeView_banner.layer.shadowOpacity = 0.2;
        _storeView_banner.layer.shadowOffset = CGSizeMake(0, 1);
        _storeView_banner.layer.shadowColor = UIColorFromRGB(0xFFFFFF).CGColor;
    }
    return _storeView_banner;
}
- (UIView *)BannerView{
    if (!_BannerView) {
        _BannerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 200)];
        _BannerView.backgroundColor=[UIColor whiteColor];
    }
    return _BannerView;
}
-(HQBannerView *)bannerView{
    if (!_bannerView) {
        _bannerView = [HQBannerView bannerViewWithFrame:self.BannerView.frame delegate:self placeholderImage:[UIImage imageNamed:@"shop_index_default_image"]];
        //        _bannerView.imageURLArray = @[@"http://api.taohaohuo365.com/uploads/images/1UVKwCWlmd1521022901.png", @"http://api.taohaohuo365.com/uploads/images/vS2t4nzGO11520853221.png", @"http://api.taohaohuo365.com/uploads/images/1UVKwCWlmd1521022901.png"];
        _bannerView.pageTextBackgroundColor = [UIColor blackColor];
        _bannerView.pageTextFont = [UIFont systemFontOfSize:13];
        _bannerView.pageTextColor = [UIColor whiteColor];
        _bannerView.pageTextAliment = HQBannerViewPageTextAlimentRightTop;
        
    }
    return _bannerView;
}
-(UILabel *)store_address{
    if (!_store_address) {
        _store_address = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-50, 35)];
        _store_address.textColor= UIColorFromRGB(0x222222);
        _store_address.font = [UIFont systemFontOfSize:14];
        _store_address.numberOfLines = 0;
        _store_address.text = @"暂未定位";
        //        _store_address.isTop = YES;
    }
    return _store_address;
}
-(UILabel *)store_name{
    if (!_store_name) {
        _store_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-50, 35)];
        _store_name.textColor= UIColorFromRGB(0x222222);
        _store_name.font = [UIFont systemFontOfSize:14];
        _store_name.numberOfLines = 0;
        _store_name.text = @"暂无联系人";
        //        _store_address.isTop = YES;
    }
    return _store_name;
}
-(UILabel *)store_time{
    if (!_store_time) {
        _store_time = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-50, 35)];
        _store_time.textColor= UIColorFromRGB(0x222222);
        _store_time.font = [UIFont systemFontOfSize:14];
        _store_time.numberOfLines = 0;
        _store_time.text = @"暂无营业时间";
        //        _store_address.isTop = YES;
    }
    return _store_time;
}
-(UILabel *)store_phone{
    if (!_store_phone) {
        _store_phone = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW-50, 35)];
        _store_phone.textColor= UIColorFromRGB(0x222222);
        _store_phone.font = [UIFont systemFontOfSize:14];
        _store_phone.numberOfLines = 0;
        _store_phone.text = @"暂无联系电话";
        //        _store_address.isTop = YES;
    }
    return _store_phone;
}
-(UIImageView *)category_pic{
    if (!_category_pic) {
        _category_pic = [[UIImageView alloc]init];
        _category_pic.image=[UIImage imageNamed:@"btn_check_box_disable"];
    }
    return _category_pic;
}
-(UILabel *)store_category{
    if (!_store_category) {
        _store_category = [[UILabel alloc]init];
        _store_category.textColor= UIColorFromRGB(0x22222);
        _store_category.font = [UIFont systemFontOfSize:15];
        _store_category.text = @"暂无类型";
    }
    return _store_category;
}
-(UILabel *)fans_number{
    if (!_fans_number) {
        _fans_number = [[UILabel alloc]init];
        _fans_number.textColor= UIColorFromRGB(0x22222);
        _fans_number.font = [UIFont systemFontOfSize:15];
        _fans_number.text = @" 0 粉丝";
    }
    return _fans_number;
}

-(UILabel *)goods_number{
    if (!_goods_number) {
        _goods_number = [[UILabel alloc]init];
        _goods_number.textColor= UIColorFromRGB(0x22222);
        _goods_number.font = [UIFont systemFontOfSize:15];
        _goods_number.text = @" 0 商品";
    }
    return _goods_number;
}
-(UILabel *)goods_id{
    if (!_goods_id) {
        _goods_id = [[UILabel alloc]init];
        _goods_id.textColor= UIColorFromRGB(0x22222);
        _goods_id.font = [UIFont systemFontOfSize:IPHONEWIDTH(15)];
        _goods_id.numberOfLines = 2;
        _goods_id.text = @" ID:";
    }
    return _goods_id;
}
-(UIImageView *)goods_pic{
    if (!_goods_pic) {
        _goods_pic = [[UIImageView alloc]init];
        _goods_pic.layer.cornerRadius = 45;
        _goods_pic.layer.masksToBounds = YES;
        _goods_pic.layer.shadowOpacity = 0.2;
        _goods_pic.layer.shadowOffset = CGSizeMake(0, 1);
        _goods_pic.layer.borderWidth =1;
        _goods_pic.layer.borderColor = UIColorFromRGB(0xFFFFFF).CGColor;
        _goods_pic.image = [UIImage imageNamed:@"register_empty_avatar"];
    }
    return _goods_pic;
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

@end
