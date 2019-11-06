//
//  JoinInViewT.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^joinBlock)(void);
@interface JoinInViewT : UIView
/**
 联系人姓名
 */
@property (weak, nonatomic) IBOutlet UITextField *merchant_name;
/**
 联系人手机号
 */
@property (weak, nonatomic) IBOutlet UITextField *merchant_mobile;
/**
 联系人邮箱
 */
@property (weak, nonatomic) IBOutlet UITextField *merchant_email;
/**
 店铺地址 store_address
 */





@property (nonatomic, copy) joinBlock joinblock;
@end
