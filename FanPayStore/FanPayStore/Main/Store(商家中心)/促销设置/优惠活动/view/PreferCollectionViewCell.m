//
//  PreferCollectionViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PreferCollectionViewCell.h"

@implementation PreferCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.clipsToBounds = YES;
        
        [self addSubview:self.pic_Image];
        [self.pic_Image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_offset(0);
            make.height.mas_offset(autoScaleW(165));
        }];
        [self addSubview:self.Goodname];
        [self.Goodname mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_offset(25);
            make.top.equalTo(self.pic_Image.mas_bottom).offset(5);
        }];
        [self addSubview:self.Goodprice];
        [self.Goodprice mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.height.mas_offset(autoScaleW(20));
            make.top.equalTo(self.Goodname.mas_bottom).offset(0);
        }];
//        [self addSubview:self.icon];
//        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.Goodprice.mas_right).offset(5);
//            make.height.mas_offset(15);
//            make.top.equalTo(self.Goodname.mas_bottom).offset(0);
//        }];
        
        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.Goodprice.mas_right).offset(5);
            make.height.mas_offset(15);
            make.width.mas_offset(30);
            make.top.equalTo(self.Goodname.mas_bottom).offset(0);
        }];
        [self.icon addSubview:self.icon_text];
        [self.icon_text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_offset(0);
        }];
            
            
        [self addSubview:self.Goodprice_1];
        [self.Goodprice_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(5);
            make.right.mas_offset(-5);
            make.height.mas_offset(autoScaleW(20));
            make.top.equalTo(self.Goodprice.mas_bottom).offset(0);
        }];
        
        [self addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.left.right.bottom.mas_offset(0);
            make.center.mas_offset(0);
            make.size.mas_offset(CGSizeMake(60, 60));
        }];
        
        self.Goodprice.text = @"¥17.00";
        self.Goodprice_1.text = @"¥ 29.00";

        
        self.sedeimage = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.sedeimage setImage:[UIImage imageNamed:@"icn_commodity_selected"] forState:UIControlStateSelected];
//        [self.sedeimage addTarget:self action:@selector(SelectedAction:) forControlEvents:UIControlEventTouchUpInside];
        self.sedeimage.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.3];
        
        [self.pic_Image addSubview:self.sedeimage];
        [self.sedeimage mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(0);
            make.size.mas_equalTo(CGSizeMake(self.width, autoScaleW(165)));
        }];
    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    
    NSString *url = [NSString stringWithFormat:@"%@",Data[@"goods_pic"]];
    
    [self.pic_Image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
    self.Goodname.text = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    
    NSString *str1 = [NSString stringWithFormat:@"￥%@ ",Data[@"discount_price"]];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange range1 = NSMakeRange(0, 1);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    self.Goodprice.attributedText = mutStr1;
    [self.Goodprice sizeToFit];

//    self.Goodprice.text = @"¥17.00";
    
    NSString *str = [NSString stringWithFormat:@"￥%@ ",Data[@"goods_price"]];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};

    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    
    self.Goodprice_1.attributedText = mutStr;
    
//    self.Goodprice_1.text = @"¥ 29.00";
    
    
    
}

- (void)setCellWithModel:(PhotoModel *)model {
    
    NSString *url = [NSString stringWithFormat:@"%@",model.goods_pic];
    
    [self.pic_Image sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
    self.Goodname.text = [NSString stringWithFormat:@"%@",model.goods_name];
    
    NSString *str1 = [NSString stringWithFormat:@"￥%@ ",model.discount_price];
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:str1];
    NSRange range1 = NSMakeRange(0, 1);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    self.Goodprice.attributedText = mutStr1;
    [self.Goodprice sizeToFit];
    
    //    self.Goodprice.text = @"¥17.00";
    
    NSString *str = [NSString stringWithFormat:@"￥%@ ",model.goods_price];
    NSDictionary *attribtDic = @{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:str attributes:attribtDic];
    NSRange range = NSMakeRange(0, 1);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range];
    
    self.Goodprice_1.attributedText = mutStr;
    
    
    if ([model.isSelected isEqualToString:@"select"]) {
        self.sedeimage.selected = YES;
    }else{
        self.sedeimage.selected = NO;
    }
    
}
#pragma mark -
-(void)btnAction{
    
//    if (self.conversionBlock) {
//        self.conversionBlock();
//    }
}

-(void)setSelected:(BOOL)selected{
    
    if (self.isguan == YES) {
        [super setSelected:selected];
        self.sedeimage.selected = selected;
    }else{
        
    }
    
}
#pragma mark - 懒加载
-(UIImageView *)addButton{
    if (!_addButton) {
        _addButton = [[UIImageView alloc]init];
        _addButton.image = [UIImage imageNamed:@"icn_add_acti_product"] ;
        _addButton.backgroundColor = [UIColor colorWithRed:212/255.0 green:229/255.0 blue:255/255.0 alpha:1.0];
        _addButton.hidden = YES;
        
    }
    return _addButton;
}
-(UIImageView *)pic_Image{
    if (!_pic_Image) {
        _pic_Image = [[UIImageView alloc]init];
        
    }
    return _pic_Image;
}
-(UILabel *)Goodname{
    if (!_Goodname) {
        _Goodname = [[UILabel alloc]init];
        _Goodname.numberOfLines = 0;
        _Goodname.textColor =  [UIColor blackColor];
        _Goodname.font =[UIFont fontWithName:@"Arial-BoldMT" size: 14] ;
    }
    return _Goodname;
}
-(UILabel *)Goodprice{
    if (!_Goodprice) {
        _Goodprice = [[UILabel alloc]init];
        _Goodprice.numberOfLines = 0;
        _Goodprice.textColor =  [UIColor colorWithRed:255/255.0 green:47/255.0 blue:43/255.0 alpha:1.0];
        _Goodprice.font =[UIFont fontWithName:@"Arial-BoldMT" size: 16] ;
    }
    return _Goodprice;
}
-(UILabel *)Goodprice_1{
    if (!_Goodprice_1) {
        _Goodprice_1 = [[UILabel alloc]init];
        _Goodprice_1.numberOfLines = 0;
        _Goodprice_1.textColor =  [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _Goodprice_1.font =[UIFont fontWithName:@"Arial-BoldMT" size: 12];
    }
    return _Goodprice_1;
}
-(YCShadowView *)icon{
    if (!_icon) {
        /// 上边阴影 + 上边圆角
        _icon = [[YCShadowView alloc] initWithFrame:CGRectMake(50, 200, 30, 15)];
        _icon.backgroundColor = [UIColor colorWithRed:255/255.0 green:47/255.0 blue:43/255.0 alpha:1.0];
        [_icon yc_shaodwRadius:2 shadowColor:[UIColor colorWithRed:255/255.0 green:47/255.0 blue:43/255.0 alpha:0.4] shadowOffset:CGSizeMake(0, 0) byShadowSide:(YCShadowSideAllSides)];
        [_icon yc_cornerRadius:10 byRoundingCorners:(UIRectCornerTopRight|UIRectCornerBottomRight)];
        
    
    }
    return _icon;
}
-(UILabel *)icon_text{
    if (!_icon_text) {
        _icon_text = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 30, 15)];
        _icon_text.text = @"折扣价";
        _icon_text.numberOfLines = 2;
        _icon_text.textColor = [UIColor whiteColor];
        _icon_text.font = [UIFont systemFontOfSize:7];
        _icon_text.textAlignment = NSTextAlignmentCenter;
    }
    return _icon_text;
}

@end
