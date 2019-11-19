//
//  DetailsQTView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DetailsQTView : UIView
{
    NSString *_Phone;
}
@property (strong,nonatomic)UILabel * store_address;//店铺地址
@property (strong,nonatomic)UILabel * user_info;//消费者信息
@property (strong,nonatomic)UILabel * remark;//备注
@property (strong,nonatomic)UILabel * people_count;//人数
@property (strong,nonatomic)UILabel * table_number;//桌号
@property (strong,nonatomic)UILabel * order_sn;//订单编号
@property (strong,nonatomic)UILabel * add_time;//下单时间
@property (strong,nonatomic)UILabel * paid_time;//支付时间
@property (strong,nonatomic)UILabel * paid_type;//支付方式：1支付宝支付、2微信支付、3银行卡快捷支付、4余额支付
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
