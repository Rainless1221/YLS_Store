//
//  CashTDViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CashTDViewCell.h"

@implementation CashTDViewCell

-(void)setData:(NSDictionary *)Data{
    
    _Data = Data;
    /**  */
    NSString *url = [NSString stringWithFormat:@"%@",Data[@"affiliated_bank_logo"]];
    [self.iconImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
    /**  */
    NSString *affiliated_bank =  [NSString stringWithFormat:@"%@",Data[@"affiliated_bank"]];
    if ([[MethodCommon judgeStringIsNull:affiliated_bank] isEqualToString:@""]) {
        affiliated_bank = [NSString stringWithFormat:@"%@",Data[@"affiliated_bank_name"]];
    }
    self.TextLabl.text = affiliated_bank;
    
}
- (IBAction)SeleAction:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
}




- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
