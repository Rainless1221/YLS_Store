//
//  YLSAddProductView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol AddProductDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)andTheLabel;
-(void)andAttribute;
@end

@interface YLSAddProductView : UIView<UITextFieldDelegate>
/*代理*/
@property(nonatomic,weak)id<AddProductDelegate>delagate;
/*goodsView*/
@property (strong,nonatomic)   UIView * GoodsView;
@property (strong,nonatomic)   UIView * PINGView;
@property (strong, nonatomic)  UITextField *goods_name;//商品名称
@property (strong, nonatomic)  UITextField *goods_price;//商品原价
@property (strong, nonatomic)  UITextField *discount_price;//折扣价格
@property (strong, nonatomic)  UILabel *goods_Ping;//平台价
@property (strong, nonatomic)  UITextField *goods_num;//商品库存
@property (strong, nonatomic)  UITextView *goods_Miao;//描述

/**标签视图**/
@property (strong,nonatomic)UIView * TheLabelView;
@property (strong,nonatomic)UIButton * TheLabelButton;
/**属性**/
@property (strong,nonatomic)UIView * AttributeView;
@property (strong,nonatomic)UIButton * AttributelButton;

/**商品类型 选填 必填**/
@property (strong,nonatomic)UIView * GoodTypeView;

/**商品图片 添加商品图片**/
@property (strong,nonatomic)UIView * GoodPicImageView;

/**赋值**/
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
