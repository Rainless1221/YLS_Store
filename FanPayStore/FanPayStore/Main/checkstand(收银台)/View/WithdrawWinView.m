//
//  WithdrawWinView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "WithdrawWinView.h"

@implementation WithdrawWinView
- (void)awakeFromNib {
    
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    self.wintext.text = @"1.由于银行审批限制，提现申请将在24小时内到账；如遇高峰期，可能延迟到账，请耐心等待 \n2.查询提现历史，可在本页右上角“提现记录”查看记录状态";
}
//我知道了
- (IBAction)WinAction:(id)sender {
    [self removeFromSuperview];
    
}



@end
