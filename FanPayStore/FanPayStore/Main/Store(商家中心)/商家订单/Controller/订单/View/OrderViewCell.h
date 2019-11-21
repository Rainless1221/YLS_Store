//
//  OrderViewCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/23.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol OrderDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)delete_order:(NSDictionary *)Dara;
-(void)printe:(NSDictionary *)data;
-(void)detail:(NSDictionary *)Dara;
-(void)Refund:(NSDictionary *)Dara;
-(void)Refused:(NSDictionary *)Dara;

@end

typedef enum{
    OrderVieWStatus_1,//
    OrderVieWStatus_2,//
    OrderVieWStatus_3,//
    OrderVieWStatus_4,//
    OrderVieWStatus_5,//
    OrderVieWStatus_6,//
    OrderVieWStatus_7,//
    OrderVieWStatus_8,//
}OrderVieWStatus;


@interface OrderViewCell : UITableViewCell <StarEvaluatorDelegate>
@property (strong,nonatomic)UIView * orderView;
@property (nonatomic,assign)OrderVieWStatus status;
//UI
@property (strong,nonatomic)UIButton * iconBtn;//状态
@property (strong,nonatomic)UILabel * TimeLabel;//时间
@property (strong,nonatomic)UILabel * numlabel;//总数量商品
@property (strong,nonatomic)UILabel * save_money;
@property (strong,nonatomic)UILabel * service_money;//服务费用
@property (strong,nonatomic)UILabel * goods_price;
@property (strong,nonatomic)UILabel * refundTime;//退款时间
@property (strong,nonatomic)UILabel * PaymentTime;//支付时间
@property (nonatomic, weak) StarEvaluator *starEvaluator;//星星
@property (strong,nonatomic)UILabel * star;//评分
@property (strong,nonatomic)UILabel * label_TKBeiZhu;// 退款备注
@property (strong,nonatomic)UILabel * label_TKmoney;// 退款
@property (strong,nonatomic)UILabel * label_TKtype;// 退款状态
@property (strong,nonatomic)UIButton * HexiaoBtn;//未核销
@property (strong,nonatomic)NSString * user_mobile;//消费者手机号
//数据
@property (strong,nonatomic)NSDictionary * Data;
/*代理*/
@property(nonatomic,weak)id<OrderDelegate>delagate;
- (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
