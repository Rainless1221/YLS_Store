//
//  SZCollectionViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SZCollectionViewCell.h"

@implementation SZCollectionViewCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.goods_price.layer.borderWidth = 1;
    self.goods_price.layer.borderColor = [UIColorFromRGB(0xF0BAB6) CGColor];
    self.goods_price.backgroundColor = UIColorFromRGB(0xFCE9E8);
    self.goods_price.textColor = UIColorFromRGB(0xEE4E3E);
    
    self.discount_price.layer.borderWidth = 1;
    self.discount_price.layer.borderColor = [UIColorFromRGB(0xB4D7FF) CGColor];
    
    self.sedeimage = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.sedeimage setImage:[UIImage imageNamed:@"icn_fanbei_good_checked"] forState:UIControlStateSelected];
    [self.sedeimage addTarget:self action:@selector(SelectedAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.goods_pic addSubview:self.sedeimage];
    [self.sedeimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(0);
        make.size.mas_equalTo(CGSizeMake(50, 50));
    }];

//    self.sedeimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50, 165)];
//    self.sedeimage.image = [UIImage imageNamed:@"icn_fanbei_good_checked"];
//    [self addSubview:self.sedeimage];
//    [self.sedeimage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.left.right.mas_equalTo(0);
//        make.height.mas_equalTo(165);
//    }];
    
}
- (void)setData:(NSDictionary *)Data{
//    _Data = Data;
    
    [self.goods_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Data[@"goods_pic"]]] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
        self.goods_name.text = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    

        self.goods_count.text = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];

    //价格
    NSString *str = [NSString stringWithFormat:@"￥%@ ",Data[@"goods_price"]];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
    self.goods_price.attributedText = mutStr;
    
    
    
    NSString *str1 = [NSString stringWithFormat:@"￥%@ ",Data[@"discount_price"]];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange range1 = NSMakeRange(0, 1);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10] range:range1];
    self.discount_price.attributedText = mutStr1;

}

-(void)SelectedAction:(UIButton *)sender{
//    if (self.SelectedBlock) {
//        self.SelectedBlock(sender);
//    }
}
-(void)setSelected:(BOOL)selected{
    [super setSelected:selected];
    self.sedeimage.selected = selected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
