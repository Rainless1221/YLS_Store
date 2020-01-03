//
//  SeekCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/1.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SeekCell : UITableViewCell
@property (strong,nonatomic)UIView * BaseView;
/*图片*/
@property (strong,nonatomic)UIImageView * GoodsImage;
/*名称*/
@property (strong,nonatomic)UILabel * GoodsName;
/*价格*/
@property (strong,nonatomic)UILabel * GoodsPrice;
/*编辑*/
@property (strong,nonatomic)UIButton * GoodsBian;
/*下架*/
@property (strong,nonatomic)UIButton * GoodsXia;
/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;
/*查询关键字*/
@property (strong,nonatomic)NSString * keyString;

@property (nonatomic, copy) void(^BianjiBlock)(void);//编辑事件
@property (nonatomic, copy) void(^SoldBlock)(void);//下架事件

@end

NS_ASSUME_NONNULL_END
