//
//  HotelOrderCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/15.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol HotelOrderDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)delete_order:(NSDictionary *)Dara;
-(void)printe:(NSDictionary *)data;
-(void)Delete:(NSDictionary *)Dara;

@end

typedef enum{
    HotelOrderVieWStatus_1,//
    HotelOrderVieWStatus_2,//
    HotelOrderVieWStatus_3,//
    HotelOrderVieWStatus_4,//
    HotelOrderVieWStatus_5,//
    HotelOrderVieWStatus_6,//
    HotelOrderVieWStatus_7,//
}HotelOrderVieWStatus;

@interface HotelOrderCell : UITableViewCell <StarEvaluatorDelegate>
@property (strong,nonatomic)UIView * orderView;
@property (nonatomic,assign)HotelOrderVieWStatus status;
//UI
@property (strong,nonatomic)UIButton * iconBtn;//状态
@property (strong,nonatomic)UILabel * TimeLabel;//时间

@property (strong,nonatomic)UILabel * refundTime;//退款时间
@property (nonatomic, weak) StarEvaluator *starEvaluator;//星星
@property (strong,nonatomic)UILabel * star;//评分

@property (strong,nonatomic)UILabel * DiseTime;
@property (strong,nonatomic)UILabel * celllabel_1;
@property (strong,nonatomic)UILabel * celllabel_2;
@property (strong,nonatomic)UILabel * celllabel_3;
@property (strong,nonatomic)YYLabel * celllabel_4;

//数据
@property (strong,nonatomic)NSDictionary * Data;
/*代理*/
@property(nonatomic,weak)id<HotelOrderDelegate>delagate;
- (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
