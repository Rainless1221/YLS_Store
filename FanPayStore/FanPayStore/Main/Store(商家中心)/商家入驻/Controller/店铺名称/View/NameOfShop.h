//
//  NameOfShop.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/8.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol NameOfShopDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
/*选择logo*/
-(void)logoAction:(UIButton *)sender;
/*选择类型*/
-(void)store_category:(UIButton *)sender;
@end

@interface NameOfShop : UIView
@property (strong,nonatomic)UIButton * logoButton;
@property (strong,nonatomic)UILabel  * logoLabel;
@property (strong,nonatomic)UITextField * store_name;
@property (strong,nonatomic)UIButton * store_category;
@property (strong,nonatomic)UIButton * category_icon;
@property (strong,nonatomic)UIView * line1;
@property (strong,nonatomic)UIView * line2;

@property(nonatomic,weak)id<NameOfShopDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
