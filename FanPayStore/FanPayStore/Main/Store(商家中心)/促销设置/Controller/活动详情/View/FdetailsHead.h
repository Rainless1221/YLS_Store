//
//  FdetailsHead.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FdetailsHead : UIView
@property (weak, nonatomic) IBOutlet UIButton *XButton;
@property (weak, nonatomic) IBOutlet UILabel *discount_amount;
@property (weak, nonatomic) IBOutlet UILabel *datetime;

@property (nonatomic, strong) NSDictionary  *Data;

@property (nonatomic, copy) void(^ModifyBlock)(UIButton * btn);

@end
