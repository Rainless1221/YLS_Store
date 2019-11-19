//
//  YLSGoodsCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol GoodsDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现


@end

NS_ASSUME_NONNULL_BEGIN
typedef enum{
    GoodsStatus_1,
    GoodsStatus_2,
    GoodsStatus_3,
} GoodsStatus;

@interface YLSGoodsCell : UITableViewCell
@property (strong,nonatomic)UIView * GoodsView;//底部视图
@property (nonatomic,assign)GoodsStatus status;//单元类型
@property (strong,nonatomic)UIImageView * Goodsimage;//图片
@property (strong,nonatomic)UILabel * GoodsNmage;//名称
@property (strong,nonatomic)UILabel * GoodsPrice;//价格
@property (strong,nonatomic)UILabel * GoodsPrice1;//原价格
@property (strong,nonatomic)UILabel * GoodsCount;//数量
@property (strong,nonatomic)UILabel * GoodsDesc;//备注
@property (strong,nonatomic)UILabel * GoodsLabel;//标签

@property (nonatomic, copy) void(^BianjiBlock)(void);//编辑事件
@property (nonatomic, copy) void(^PutawayBlock)(void);//上架事件
@property (nonatomic, copy) void(^SoldBlock)(void);//下架事件
@property (nonatomic, copy) void(^DeleteBlock)(void);//删除事件

/*代理*/
@property(nonatomic,weak)id<OrderDelegate>delagate;
/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;
/*高度*/
- (CGFloat)getCellHeight;

@end

NS_ASSUME_NONNULL_END
