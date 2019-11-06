//
//  storeCenterView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol storeMerchantDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)pushViewcontroler:(NSInteger )Btntag;
-(void)LatViewcontroler;
@end

@interface storeCenterView : UIView <HQBannerViewDelegate>
/**
 模块视图
 */
@property (strong,nonatomic)UIView * storeView_banner;
@property (strong,nonatomic)UIView * storeView1;
@property (strong,nonatomic)UIView * storeView2;
@property (strong,nonatomic)UIView * storeView3;
@property (strong,nonatomic)UIView * storeView4;
@property (strong,nonatomic)UIView * storeView5;
@property (strong,nonatomic)UIView * storeView_info;
@property (strong,nonatomic)UILabel * badgeLable;
/* Banner轮播 */
@property (strong,nonatomic)UIView * BannerView;
@property (strong,nonatomic)HQBannerView *bannerView;
/*
 地址
 */
@property (strong,nonatomic)UILabel * store_address;
@property (strong,nonatomic)UILabel * store_name;
@property (strong,nonatomic)UILabel * store_phone;
@property (strong,nonatomic)UILabel * store_time;
/*
 经营类型
 */
@property (strong,nonatomic)UIImageView * category_pic;
@property (strong,nonatomic)UILabel * store_category;
/*
 粉丝
 */
@property (strong,nonatomic)UILabel * fans_number;
/*
 商品
 */
@property (strong,nonatomic)UILabel * goods_number;
/*
 id
 */
@property (strong,nonatomic)UILabel * goods_id;
/*
 头像
 */
@property (strong,nonatomic)UIImageView * goods_pic;
//代理
@property(nonatomic,weak)id<storeMerchantDelegate>delagate;
@property (strong,nonatomic)storeBaseModel * Data;
@property (strong,nonatomic)FL_Button *thirdBtn;
@end
