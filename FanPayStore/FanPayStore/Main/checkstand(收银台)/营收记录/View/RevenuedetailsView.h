//
//  RevenuedetailsView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RevenuedetailsView : UIView
/*icon*/
@property (strong,nonatomic)UIImageView * icon;
/* 金额 */
@property (strong,nonatomic)UILabel * amount;
/* 描述*/
@property (strong,nonatomic)UILabel * desc;
/* 商品信息*/
@property (strong,nonatomic)UILabel * TextLabel1;
@property (strong,nonatomic)UILabel * status1;
/* 商家名称*/
@property (strong,nonatomic)UILabel * TextLabel2;
@property (strong,nonatomic)UILabel * status2;
/* 订单标号or记录ID*/
@property (strong,nonatomic)UILabel * TextLabel3;
@property (strong,nonatomic)UILabel * status3;
/* 订单时间*/
@property (strong,nonatomic)UILabel * TextLabel4;
@property (strong,nonatomic)UILabel * status4;


@property (strong,nonatomic)NSDictionary * Data;
@end
