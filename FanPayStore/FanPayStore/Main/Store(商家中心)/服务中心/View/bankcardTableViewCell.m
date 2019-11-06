//
//  bankcardTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "bankcardTableViewCell.h"

@implementation bankcardTableViewCell
-(void)setData:(NSDictionary *)Data{
    
    
    //银行名称
    NSString *bankName = [NSString stringWithFormat:@"%@",Data[@"affiliated_bank_name"]];
    if ([[MethodCommon judgeStringIsNull:bankName] isEqualToString:@""]) {
        bankName = @"";
    }else{
        self.BankName.text = bankName;

    }
    
    //银行卡类型
    NSString *card_property = [NSString stringWithFormat:@"%@",Data[@"card_property"]];
    if ([[MethodCommon judgeStringIsNull:card_property] isEqualToString:@""]) {
        card_property = @"";
    }else{
        self.BankType.text = card_property;
    }

    
    //卡号
    self.BankInt.text = [NSString stringWithFormat:@"****    ****    ****  %@",Data[@"card_number"]];

    
    //银行logo
    NSString *logoURL = [NSString stringWithFormat:@"https://apimg.alipay.com%@",Data[@"bank_logo"]];
    [self.BankIcon sd_setImageWithURL:[NSURL URLWithString:logoURL] placeholderImage:[UIImage imageNamed:@"icn_bank_abc_white"]];
    
    
    NSString * URLpublic = [PublicMethods readFromUserD:@"URL_addin"];
    NSString *KAPURL = [NSString new];
    if ([URLpublic  isEqualToString:@"1"]) {
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL];
    }else{
        KAPURL = [NSString stringWithFormat:@"%@",kAPI_URL1];
        
    }
    //背景色
    NSString *bank_color = [NSString stringWithFormat:@"%@%@",KAPURL,Data[@"bank_bg"]];
    
//    if ([bank_color isEqualToString:@"green"]) {
//        self.Bankcard.image = [UIImage imageNamed:@"bank_abc_card_bg"];
//    }else if ([bank_color isEqualToString:@"blue"]){
//        self.Bankcard.image = [UIImage imageNamed:@"bank_ccb_card_bg"];
//
//    }else if ([bank_color isEqualToString:@"red"]){
//        self.Bankcard.image = [UIImage imageNamed:@"bank_icbc_card_bg"];
//    }else{
//        self.Bankcard.image = [UIImage imageNamed:@"bank_boc_card_bg"];
//
//    }
    [self.Bankcard sd_setImageWithURL:[NSURL URLWithString:bank_color] placeholderImage:[UIImage imageNamed:@"bank_ccb_card_bg"]];
    
    
}
-(void)setRData:(NSDictionary *)RData{
    
    //银行名称
    NSString *bankName = [NSString stringWithFormat:@"%@",RData[@"bank_name"]];
    if ([[MethodCommon judgeStringIsNull:bankName] isEqualToString:@""]) {
        bankName = @"";
    }else{
        self.BankName.text = bankName;
        
    }
    
    //银行卡类型
    NSString *card_property = [NSString stringWithFormat:@"%@",RData[@"bank_code"]];
    if ([[MethodCommon judgeStringIsNull:card_property] isEqualToString:@""]) {
        card_property = @"";
    }else{
        self.BankType.text = card_property;
    }
    //卡号
   NSString *card_number = [NSString stringWithFormat:@"%@",RData[@"card_number"]];
    if ([[MethodCommon judgeStringIsNull:card_number] isEqualToString:@""]) {
        card_number = @"";
    }else{//****    ****    ****
        NSInteger i = 12;
        i = card_number.length - 4;
       card_number =  [card_number substringFromIndex:i];
        self.BankInt.text = [NSString stringWithFormat:@"****    ****    **** %@",card_number];
    }
    
    
   

}
-(void)setBData:(NSDictionary *)BData{
    
    //银行名称
    NSString *bankName = [NSString stringWithFormat:@"%@",BData[@"bank_name"]];
    if ([[MethodCommon judgeStringIsNull:bankName] isEqualToString:@""]) {
        bankName = @"";
    }else{
        self.BankName.text = bankName;
        
    }
    //卡号B
    NSString *card_number = [NSString stringWithFormat:@"%@",BData[@"card_no"]];
    if ([[MethodCommon judgeStringIsNull:card_number] isEqualToString:@""]) {
        card_number = @"";
    }else{//****    ****    ****
        NSInteger i = 12;
        i = card_number.length - 4;
        card_number =  [card_number substringFromIndex:i];
        self.BankInt.text = [NSString stringWithFormat:@"****    ****    **** %@",card_number];
    }
    
    
    //银行logo
    NSString *logoURL = [NSString stringWithFormat:@"%@",BData[@"bank_logo"]];
//    [self.BankIcon sd_setImageWithURL:[NSURL URLWithString:logoURL] placeholderImage:[UIImage imageNamed:@""]];
    
    //背景色
    NSString *bank_color = [NSString stringWithFormat:@"%@",BData[@"bank_bg"]];
    [self.Bankcard sd_setImageWithURL:[NSURL URLWithString:bank_color] placeholderImage:[UIImage imageNamed:@""]];
    
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
