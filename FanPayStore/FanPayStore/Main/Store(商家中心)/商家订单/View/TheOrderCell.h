//
//  TheOrderCell.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/2.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OrderCellDelegate2<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)delete_order2:(NSDictionary *)Dara;
-(void)printe2:(NSDictionary *)data;
-(void)Delete:(NSDictionary *)Dara;

@end

@interface TheOrderCell : UITableViewCell
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)UIImageView * statusImage;//状态图标
@property (strong,nonatomic)UILabel * statusLabel;//状态文本
@property (strong,nonatomic)UILabel * add_time;//下单时间
@property (strong,nonatomic)UIView * LineHengxian;//横线
@property (strong,nonatomic)UILabel * goodText;//“商品列表”
@property (strong,nonatomic)UIButton * DeleteButton;//删除按钮
@property (strong,nonatomic)UILabel * FWtext;//服务费用
@property (strong,nonatomic)UILabel * FWlbale;
@property (strong,nonatomic)UILabel * FBtext;//翻呗优惠
@property (strong,nonatomic)UILabel * FBlbale;
@property (strong,nonatomic)UILabel * Zongnum;//总数量商品
@property (strong,nonatomic)UILabel * Zongprice;//总价
@property (strong,nonatomic)UIButton * detailsButton;//查询其余*件的按钮
@property (strong,nonatomic)UILabel * detailslabel;

@property (strong,nonatomic)NSDictionary * Data;
/*代理*/
@property(nonatomic,weak)id<OrderCellDelegate2>delagate;
- (CGFloat)getCellHeight;
@end
