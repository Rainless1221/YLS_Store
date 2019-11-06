//
//  CHTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CHTableViewCell.h"

@implementation CHTableViewCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.DeleteButtom.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    self.goods_price.layer.borderColor = [UIColorFromRGB(0xF0BAB6) CGColor];
    self.goods_price.backgroundColor = UIColorFromRGB(0xFCE9E8);
    [self.shangjiaButton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    [self.bianjiButton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    [self.bianjiButton addTarget:self action:@selector(bianjiAction) forControlEvents:UIControlEventTouchUpInside];
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
    self.goodname.text = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    
    //价格
    NSString *str = [NSString stringWithFormat:@"￥%@ ",Data[@"discount_price"]];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    self.goods_price.attributedText = mutStr;


    self.goods_count.text = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    self.goods_desc.text = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
    
    self.discount_price.text = [NSString stringWithFormat:@"￥%@",Data[@"goods_price"]];

}
#pragma mark - 编辑
-(void)bianjiAction{
    if (self.BianjiBlock) {
        self.BianjiBlock();
    }
}
#pragma mark - 上架

- (IBAction)shangjiaAction:(UIButton *)sender {
    if (self.onlineBlock) {
        self.onlineBlock();
    }
}

#pragma mark - 删除

- (IBAction)DeleteAction:(UIButton *)sender {
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
}

@end
