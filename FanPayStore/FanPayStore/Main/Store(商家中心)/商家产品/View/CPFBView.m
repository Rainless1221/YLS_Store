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
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self.TheLabelView addGestureRecognizer:tapGesturRecognizer];
    
    
    /*发布按钮*/
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = self.FBButton.frame;
    Button.width = ScreenW-30;
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,ScreenW-30,44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [Button.layer addSublayer:gl];
//
//    Button.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    Button.layer.shadowOffset = CGSizeMake(0,4);
//    Button.layer.shadowOpacity = 1;
//    Button.layer.shadowRadius = 9;
    
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
            double price = ([self.goods_price.text doubleValue]-[text doubleValue])*plat+[text doubleValue];
            self.Pingtai.text = [NSString stringWithFormat:@"%.2f",price];
            self.Pingtai.textColor = UIColorFromRGB(0x222222);
        }
    
    }else {
        self.Pingtai.text = @"平台价为优惠价+服务费之和";
        self.Pingtai.textColor = UIColorFromRGB(0xCCCCCC);
        
    }
    
    return returnValue;

    //    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    //    if (text.length >= 16) {
    //        [self cardToBankName:text];
    //    }
    //    NSLog(@"完整的文本 ：%@",text);
    //    NSLog(@"每次输入的单个文字 ：%@",string);
    //    NSLog(@"textField.text 显示的会少一个文字 ：%@",textField.text);
    //
    //    return YES;
}
-(NSString *)reviseString:(NSString *)str{
    
     double value = [str doubleValue];
    NSString *temp = [NSString stringWithFormat:@"%lf", value];
    NSDecimalNumber *resultNumber = [NSDecimalNumber decimalNumberWithString:temp];
     return [resultNumber stringValue];
    
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
    NSString * plat_price_rate = [PublicMethods readFromUserD:@"plat_price_rate"];
    if ([[MethodCommon judgeStringIsNull:plat_price_rate] isEqualToString:@""]) {
        plat_price_rate = @"0.2";
    }
    NSString *price = [self reviseString:plat_price_rate];
    double plat = [price doubleValue];
    double priceS = ([self.goods_price.text doubleValue]-[self.discount_price.text  doubleValue])*plat+[self.discount_price.text doubleValue];
    self.Pingtai.text = [NSString stringWithFormat:@"%.2f",priceS];
    self.Pingtai.textColor = UIColorFromRGB(0x222222);

    
  

    self.placeholderLabel.hidden=YES;
    
}
@end
