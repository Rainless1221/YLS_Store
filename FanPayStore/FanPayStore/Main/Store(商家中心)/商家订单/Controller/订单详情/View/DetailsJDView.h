//
//  DetailsJDView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsJDView : UIView
@property (strong,nonatomic)UIImageView * Detailsimage;//详情图
@property (strong,nonatomic)UILabel * hotelName;//栖云民宿 - 云坞
@property (strong,nonatomic)UILabel * hotelM;//m
@property (strong,nonatomic)UILabel * hotelPrice;// 价格  元/晚
@property (strong,nonatomic)UILabel * hotelR;// 入驻时间
@property (strong,nonatomic)UILabel * hotelT;// 退房时间
@property (strong,nonatomic)UILabel * hotelF;// 房费
@property (strong,nonatomic)UILabel * hotelZ;// 早餐
@property (strong,nonatomic)UILabel * hotelFW;// 服务费用
@property (strong,nonatomic)UILabel * hotelY;// 酒店优惠
@property (strong,nonatomic)UILabel * hotelSF;// 实付
@end

NS_ASSUME_NONNULL_END
