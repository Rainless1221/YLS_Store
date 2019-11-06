//
//  CHDeleTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CHDeleTableViewCell.h"

@implementation CHDeleTableViewCell

#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.goods_price.layer.borderColor = [UIColorFromRGB(0xF0BAB6) CGColor];
    self.goods_price.backgroundColor = UIColorFromRGB(0xFCE9E8);
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
    NSString *str = [NSString stringWithFormat:@"￥%@ ",Data[@"goods_price"]];
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:range];
    self.goods_price.attributedText = mutStr;
    
    self.goods_count.text = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    self.goods_desc.text = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
}


-(void)layoutSubviews
{
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (self.selected) {
                        img.image=[UIImage imageNamed:@"btn_check_box_pressed"];
                    }else
                    {
                        img.image=[UIImage imageNamed:@"btn_check_box_disable"];
                    }
                }
            }
        }
    }
    [super layoutSubviews];
}
//适配第一次图片为空的情况
- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    for (UIControl *control in self.subviews){
        if ([control isMemberOfClass:NSClassFromString(@"UITableViewCellEditControl")]){
            for (UIView *v in control.subviews)
            {
                if ([v isKindOfClass: [UIImageView class]]) {
                    UIImageView *img=(UIImageView *)v;
                    if (!self.selected) {
                        img.image=[UIImage imageNamed:@"btn_check_box_disable"];
                    }
                }
            }
        }
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
