//
//  BrandNewOrderCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BrandNewDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)delete_order:(NSDictionary *)Dara;
-(void)printe:(NSDictionary *)data;
-(void)detail:(NSDictionary *)Dara;
-(void)Refund:(NSDictionary *)Dara;
-(void)Refused:(NSDictionary *)Dara;

@end

NS_ASSUME_NONNULL_BEGIN

@interface BrandNewOrderCell : UITableViewCell <StarEvaluatorDelegate>
@property (strong,nonatomic)UIView * orderView;
@property (strong,nonatomic)UIView * YuyueView;//预约视图
@property (strong,nonatomic)UIImageView * YYicon;
@property (strong,nonatomic)UILabel * yylabel;
@property (strong,nonatomic)UILabel * YYTimeLabel;//预约时间
@property (strong,nonatomic)UIButton * iconBtn;//状态
@property (strong,nonatomic)UILabel * TimeLabel;//时间
@property (strong,nonatomic)UIButton * HexiaoBtn;//核销
@property (strong,nonatomic)UILabel * OrderLabel;//商品列表标题
@property (strong,nonatomic)UILabel * numlabel;//总数量商品
@property (strong,nonatomic)UILabel * service_money_Label;//服务费用标题
@property (strong,nonatomic)UILabel * service_money;//服务费用
@property (strong,nonatomic)UILabel * save_money_Label;//优惠标题
@property (strong,nonatomic)UILabel * save_money;//优惠
@property (strong,nonatomic)UILabel * save_money_Label1;//
@property (strong,nonatomic)UILabel * account_money;//
@property (strong,nonatomic)UILabel * goods_price;

@property (strong,nonatomic)UILabel * PaymentTime;//支付时间
@property (strong,nonatomic)UIButton * PrintBtn;//打印订单
@property (strong,nonatomic)UIButton * DeleteButton;//删除按钮
@property (strong,nonatomic)UIButton * ConfirmButton;//确认退款按钮
@property (strong,nonatomic)UIButton * contactButton;//联系按钮
@property (strong,nonatomic)UIView * PLLine;//评论分割线
@property (strong,nonatomic)UIButton * TkiconButton;//
@property (strong,nonatomic)UILabel * label_TKtype;// 退款状态
@property (strong,nonatomic)UILabel * label_TKmoney_Label;// 退款标题
@property (strong,nonatomic)UILabel * label_TKmoney;// 退款
@property (strong,nonatomic)UILabel * label_TKBeiZhu;// 退款备注
@property (strong,nonatomic)UILabel * label_Eval;// 评论标题
@property (nonatomic, weak) StarEvaluator *starEvaluator;//星星
@property (strong,nonatomic)UILabel * star;//评分
@property (strong,nonatomic)NSString * user_mobile;//消费者手机号
@property (strong,nonatomic)UIButton * detailsButton;//其他
@property (strong,nonatomic)UILabel * detailslabel;

@property (assign,nonatomic)NSInteger order_id;
@property (strong,nonatomic)UIView * ZuiLine;//最后的一条线

//数据
@property (strong,nonatomic)NSDictionary * Data;
/*代理*/
@property(nonatomic,weak)id<OrderDelegate>delagate;
@property (nonatomic, copy) void(^TheRestBlock)(void);

/**获取高度*/
- (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
