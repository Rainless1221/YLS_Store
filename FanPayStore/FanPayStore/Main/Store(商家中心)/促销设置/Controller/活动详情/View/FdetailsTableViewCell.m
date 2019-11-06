//
//  FdetailsTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FdetailsTableViewCell.h"

@implementation FdetailsTableViewCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.discount_price.layer.borderColor = [UIColorFromRGB(0xF0BAB6) CGColor];
    
    self.discount_price.backgroundColor = UIColorFromRGB(0xFCE9E8);
    
}

- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    
    [self.goods_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Data[@"goods_pic"]]] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
    self.goods_name.text = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    
    //价格
    NSString *str = [NSString stringWithFormat:@"￥%@ ",Data[@"discount_price"]];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
    self.discount_price.attributedText = mutStr;
    
    
    NSString *oldStr = [NSString stringWithFormat:@"¥%@",Data[@"goods_price"]];
    
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:oldStr attributes:attribtDic];
    self.goods_price.attributedText= attribtStr;

    
    self.goods_desc.text = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
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
