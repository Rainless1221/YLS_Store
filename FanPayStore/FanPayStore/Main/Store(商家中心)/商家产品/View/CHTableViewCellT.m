//
//  CHTableViewCellT.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CHTableViewCellT.h"

@implementation CHTableViewCellT
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    self.goods_price.layer.borderColor = [UIColorFromRGB(0xF0BAB6) CGColor];
    [self.bianjiButton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    self.goods_price.backgroundColor = UIColorFromRGB(0xFCE9E8);
    self.discount_price.backgroundColor = UIColorFromRGB(0xE3EEFF);
    self.discount_price.layer.cornerRadius = 12;
    self.discount_price.layer.borderWidth = 1;
    self.discount_price.layer.borderColor = UIColorFromRGB(0xB4D7FF).CGColor;
}

- (void)setData:(NSDictionary *)Data{
    _Data = Data;

    //图片
    NSString *goods_pic = [NSString stringWithFormat:@"%@",Data[@"goods_pic"]];
    NSArray *picarr = [goods_pic componentsSeparatedByString:@","];
    [self.goods_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picarr[0]]] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    //名称
    NSString *goods_name = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    if ([[MethodCommon judgeStringIsNull:goods_name] isEqualToString:@""]) {
        goods_name = @"";
    }else{
        self.goodname.text = goods_name;
    }
   
    //价格
    NSString *discount_price = [NSString stringWithFormat:@"%@",Data[@"discount_price"]];
    if ([[MethodCommon judgeStringIsNull:discount_price] isEqualToString:@""]) {
        discount_price = @"0.00";
    }
    NSString *str = [NSString stringWithFormat:@"  ￥%@  ",discount_price];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
    self.goods_price.attributedText = mutStr;

    /**
     数量
     */
    NSString *goods_count = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    if ([[MethodCommon judgeStringIsNull:goods_count] isEqualToString:@""]) {
        goods_count = @"0";
    }
    self.goods_count.text = [NSString stringWithFormat:@"%@",goods_count];
    /**
     
     */
    NSString *goods_desc = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
    if ([[MethodCommon judgeStringIsNull:goods_desc] isEqualToString:@""]) {
        goods_desc = @"0";
    }
    self.goods_desc.text = [NSString stringWithFormat:@"%@",goods_desc];
    
    /**
     优惠价格
     */
    NSString *goods_price = [NSString stringWithFormat:@"%@ ",Data[@"goods_price"]];
    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
        goods_price = @"0.00";
    }
    NSString *str1 = [NSString stringWithFormat:@"  ￥%@ ",goods_price];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange range1 = NSMakeRange(0, 1);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range1];
    self.discount_price.attributedText = mutStr1;
    
}


#pragma mark - 下架
- (IBAction)xiajiaAction:(UIButton *)sender {
    if (self.saleBlock) {
        self.saleBlock();
    }
    
}

#pragma mark - 编辑
- (IBAction)bianjiAction:(UIButton *)sender {
    if (self.editorBlock) {
        self.editorBlock();
    }
    
}

@end
