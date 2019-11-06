//
//  Bank_infoModel.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bank_infoModel : NSObject
@property (nonatomic, copy) NSString *bank_id;//银行ID
@property (nonatomic, copy) NSString *bank_name;//银行名称
@property (nonatomic, copy) NSString *bank_code;//如建设银行代号为CCB
@property (nonatomic, copy) NSString *bank_logo;//银行logo 银行标志
@property (nonatomic, copy) NSString *bank_color;//银行标志颜色

@end
