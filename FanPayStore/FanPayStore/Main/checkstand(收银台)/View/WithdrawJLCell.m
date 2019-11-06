//
//  WithdrawJLCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "WithdrawJLCell.h"

@implementation WithdrawJLCell

-(void)setData:(NSDictionary *)Data{
//    _Data = Data;
    /** 提现的时间 */
    self.add_time.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    
    /** 提现状态 */
    NSString * status = [NSString stringWithFormat:@"%@",Data[@"status"]];
    if ([status isEqualToString:@"申请处理中"]) {
        self.status.textColor = UIColorFromRGB(0xFF6969);
    }else{
        self.status.textColor = UIColorFromRGB(0x999999);
    }
    self.status.text = status;
    
    
    /** 提现描述 */
    self.withdraw_desc.text = [NSString stringWithFormat:@"%@",Data[@"withdraw_desc"]];
    
    
    /** 提现金额 */
    self.amount.text = [NSString stringWithFormat:@"+%@",Data[@"amount"]];
    
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{

    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
