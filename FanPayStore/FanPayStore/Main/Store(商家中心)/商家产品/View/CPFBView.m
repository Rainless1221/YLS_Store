//
//  CPFBView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CPFBView.h"

@implementation CPFBView
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.goods_price.keyboardType = UIKeyboardTypeDecimalPad;
    self.discount_price.keyboardType = UIKeyboardTypeDecimalPad;
    self.goods_num.keyboardType = UIKeyboardTypeDecimalPad;
    self.goods_description1.delegate = self;
    self.LabelBtn.frame = CGRectMake(94, 9, 110, 30);
    self.discount_price.delegate = self;
    self.goods_price.delegate = self;
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.TheLabelView addGestureRecognizer:tapGesturRecognizer];
    
    
    /*发布按钮*/
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = self.FBButton.frame;
    Button.width = ScreenW-30;

    
    [Button setTitle:@"立即发布" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [Button addTarget:self action:@selector(insertAction:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:Button];
}
/** 添加商品图片 **/
- (IBAction)iamgeAciton:(UIButton *)sender {
    if (self.imageBlock) {
        self.imageBlock(nil,sender);
    }
    
}

/** 发布商品*/
- (IBAction)insertAction:(UIButton *)sender {
    if (self.insertBlock) {
        self.insertBlock();
    }
}
#pragma mark - 选择便签
-(void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.selectBlock) {
        self.selectBlock();
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (![text isEqualToString:@""]){
        _placeholderLabel.hidden = YES;
    }
    
    if ([text isEqualToString:@""] && range.location == 0 && range.length == 1){
        _placeholderLabel.hidden = NO;
    }
    
    return YES;
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL returnValue = YES;
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSString * plat_price_rate = [PublicMethods readFromUserD:@"plat_price_rate"];

    if ([[MethodCommon judgeStringIsNull:plat_price_rate] isEqualToString:@""]) {
        plat_price_rate = @"0.2";
    }
   NSString *price = [self reviseString:plat_price_rate];
    double plat = [price doubleValue];
    
    if (text.length>0) {
        if (self.goods_price.text.length>0) {
            
            [self get_plat_price_rate:self.discount_price.text];
//            double price = 0;
//            double goodPrice = ([self.goods_price.text doubleValue]-[text doubleValue])*plat;
//            if (goodPrice> [text doubleValue]) {
//                 price = [text doubleValue]+[text doubleValue];
//            }else{
//                 price = ([self.goods_price.text doubleValue]-[text doubleValue])*plat+[text doubleValue];
//            }
//            self.Pingtai.text = [NSString stringWithFormat:@"%.2f",price];
//            self.Pingtai.textColor = UIColorFromRGB(0x222222);
            
            
        }
    
    }else {
        self.Pingtai.text = @"平台价为优惠价+服务费之和";
        self.Pingtai.textColor = UIColorFromRGB(0xCCCCCC);
    }
    
    return returnValue;

}
-(NSString *)reviseString:(NSString *)str{
    
     double value = [str doubleValue];
    NSString *temp = [NSString stringWithFormat:@"%lf", value];
    NSDecimalNumber *resultNumber = [NSDecimalNumber decimalNumberWithString:temp];
     return [resultNumber stringValue];
    
}

-(void)get_plat_price_rate:(NSString *)discount_price{
    
    //get_plat_price_according_goods_price_and_discount_price
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_plat_price_according_goods_price_and_discount_price:model.merchant_id andstore_id:model.store_id  andgoods_price:[NSString stringWithFormat:@"%@",self.goods_price.text] anddiscount_price:discount_price  Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            self.Pingtai.text = [NSString stringWithFormat:@"%@",DIC[@"plat_price"]];
            self.Pingtai.textColor = UIColorFromRGB(0x222222);
            
        }else{
            
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    //商品名
    NSString *goods_name = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    if ([[MethodCommon judgeStringIsNull:goods_name] isEqualToString:@""]) {
        
    }else{
        self.goods_name.text = goods_name;

    }
    
    
    NSString *goods_price = [NSString stringWithFormat:@"%@",Data[@"goods_price"]];
    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
        
    }else{
        self.goods_price.text = goods_price;
    }
    
    
    
    NSString *discount_price = [NSString stringWithFormat:@"%@",Data[@"discount_price"]];
    if ([[MethodCommon judgeStringIsNull:discount_price] isEqualToString:@""]) {
        
    }else{
        self.discount_price.text = discount_price;
    }
    
    

    NSString *goods_num = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    if ([[MethodCommon judgeStringIsNull:goods_num] isEqualToString:@""]) {
        
    }else{
        self.goods_num.text = goods_num;
    }
    
    
    NSString *goods_description1 = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
    if ([[MethodCommon judgeStringIsNull:goods_description1] isEqualToString:@""]) {
        
    }else{
        self.goods_description1.text = goods_description1;
    }
    
    
    
    
    /*计算平台价*/
//    NSString * plat_price_rate = [PublicMethods readFromUserD:@"plat_price_rate"];
//    if ([[MethodCommon judgeStringIsNull:plat_price_rate] isEqualToString:@""]) {
//        plat_price_rate = @"0.2";
//    }
//    NSString *price = [self reviseString:plat_price_rate];
//    double plat = [price doubleValue];
//    double priceS = ([self.goods_price.text doubleValue]-[self.discount_price.text  doubleValue])*plat+[self.discount_price.text doubleValue];
//    self.Pingtai.text = [NSString stringWithFormat:@"%.2f",priceS];
//    self.Pingtai.textColor = UIColorFromRGB(0x222222);

    [self get_plat_price_rate:self.discount_price.text];
  

    self.placeholderLabel.hidden=YES;
    
}
@end
