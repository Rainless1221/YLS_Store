//
//  goodDetailsView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/6.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface goodDetailsView : UIView
@property (strong,nonatomic)UIView * goodView;
////
@property (strong,nonatomic)UILabel * discount_price;
@property (strong,nonatomic)UILabel * goods_price;
@property (strong,nonatomic)UILabel * goods_count;
@property (strong,nonatomic)UILabel * goods_desc;
@property (strong,nonatomic)UILabel * goodname;
@property (strong,nonatomic)UIButton * labelButton;
////
@property (strong,nonatomic)UIView * ImageView;
@end

NS_ASSUME_NONNULL_END
