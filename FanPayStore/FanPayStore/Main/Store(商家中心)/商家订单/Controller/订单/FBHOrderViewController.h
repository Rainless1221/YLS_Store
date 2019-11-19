//
//  FBHOrderViewController.h
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHOrderViewController : BaseViewController
@property (assign,nonatomic)NSInteger isDzhuang;
@property (strong,nonatomic)NSString * status;
@property (strong,nonatomic)NSString * begin_date;
@property (strong,nonatomic)NSString * end_date;


/*
 # 订单状态梳理
 ###  原来的状态控制保留  order_status = 0
 
 ### 1.支付状态
 pay_status
 0 未支付，1 已支付
 
 ### 2.交易状态 trade_status
 pay_status=1 and trade_status= 1 and refund_status=2
 0 进行中 1.已完成，2.已结算（已核销），3.已分佣,4 已取消
 
 ### 3.评价状态
 eval_status
 0 未评价，1.已评价
 
 ### 4. 退款/退单 状态
 refund_status
 0 未退款 1发起退款中 2.退款已确认，3退款已完成，4.退款已取消
 
 ### 5.金额字段
 pay_money  支付金额
 refund_money 退款金额
 trade_amount 交易金额 （最终交易金额）
 
 ### 条件查询
 
 1 待付款  (order_status = 0 or (pay_status=0 and trade_status=0))
 
 2 订单已取消 pay_status=0 and trade_status=4
 
 3 已付款/待核销/待使用/待结算/待退款  pay_status=1 and trade_status= 1 and refund_status in (0,3,4)
 
 4 已核销/已使用/已结算 pay_status=1 and trade_status= 2 and refund_status in (0,3,4)
 
 5 已分佣 pay_status=1 and trade_status= 3 and refund_status in (0,3,4)
 
 6 退款申请中/发起退款中  pay_status=1 and trade_status= 1 and refund_status=1
 
 7 退款已确认 pay_status=1 and trade_status= 1 and refund_status=2
 
 8 退款已完成 pay_status=1 and trade_status= 1 and refund_status=3
 
 9 退款已取消 pay_status=1 and trade_status= 1 and refund_status=4
 
 10 未评价/待评价  pay_status=1 and trade_status  in(2,3) and and refund_status in (0,3,4) and eval_status = 0
 
 11 已评价 pay_status=1 and trade_status  in(2,3) and and refund_status in (0,3,4) and eval_status = 1
 */
@end
