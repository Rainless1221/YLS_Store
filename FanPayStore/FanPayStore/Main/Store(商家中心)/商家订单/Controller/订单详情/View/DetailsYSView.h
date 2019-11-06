//
//  DetailsYSView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/29.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    DetailsVieWStatus_1,//非退款
    DetailsVieWStatus_2,//退款
}DetailsVieWStatus;

@interface DetailsYSView : UIView
@property (strong,nonatomic)UILabel * hotelFW;// 服务费用
@property (strong,nonatomic)UILabel * hotelY;// 翻呗优惠
@property (strong,nonatomic)UILabel * hotelSF;// 实付
@property (strong,nonatomic)UILabel * label_TK;// 退款
@property (strong,nonatomic)UILabel * label_TKBeiZhu;// 退款备注
@property (strong,nonatomic)UILabel * TK;//
@property (strong,nonatomic)UIView *view_line_3;

@property (nonatomic,assign)DetailsVieWStatus status;

@property (strong,nonatomic)NSDictionary * Data;

@end

NS_ASSUME_NONNULL_END
