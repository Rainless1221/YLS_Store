//
//  SeekCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/1.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import "SeekCell.h"

@implementation SeekCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /*UI*/
        [self createUI];
    }
    
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.BaseView];
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(5);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
        make.bottom.mas_offset(-5);
    }];
    /*图片*/
    [self.BaseView addSubview:self.GoodsImage];
    [self.GoodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(60, 60));
    }];
    /*名称*/
    [self.BaseView addSubview:self.GoodsName];
    [self.GoodsName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.GoodsImage.mas_right).offset(10);
        make.size.mas_offset(CGSizeMake(147, 38));
    }];
    /*价格*/
    [self.BaseView addSubview:self.GoodsPrice];
    [self.GoodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsName.mas_bottom).offset(0);
        make.left.equalTo(self.GoodsImage.mas_right).offset(10);
        make.height.mas_offset(22);
    }];
    /*下架*/
    [self.BaseView addSubview:self.GoodsXia];
    [self.GoodsXia mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10.5);
        make.size.mas_offset(CGSizeMake(56, 27));
    }];
    
    /*编辑*/
    [self.BaseView addSubview:self.GoodsBian];
    [self.GoodsBian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.equalTo(self.GoodsXia.mas_left).offset(-5);
         make.size.mas_offset(CGSizeMake(56, 27));
    }];
    
    self.GoodsName.text = @"家乐福开始的";
    
    NSString *goods_price = [NSString stringWithFormat:@"3221"];
    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
        goods_price = @"     ¥ 0.00  ";
    }else{
        goods_price = [NSString stringWithFormat:@"  ¥ %@  ",goods_price];
    }
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:goods_price];
    NSRange range1 = NSMakeRange(0, 3);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:range1];
    self.GoodsPrice.attributedText = mutStr1;

}
#pragma mark - 编辑事件
-(void)BianAction{
    NSLog(@"编辑");
    if (self.BianjiBlock) {
        self.BianjiBlock();
    }
}
#pragma mark - 下架事件
-(void)SoldAction{
    NSLog(@"下架");
    if (self.SoldBlock) {
        self.SoldBlock();
    }
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
//    NSString *goods_price = [NSString stringWithFormat:@"%@",Data[@"goods_price"]];
//    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
//        goods_price = @"     ¥ 0.00  ";
//    }else{
//        goods_price = [NSString stringWithFormat:@"  ¥ %@  ",goods_price];
//    }
//    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:goods_price];
//    NSRange range1 = NSMakeRange(0, 3);
//    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
//    self.GoodsPrice.attributedText = mutStr1;
}
#pragma mark - 懒加载
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 45, self.width-30, self.height-45)];
        _BaseView.backgroundColor = [UIColor whiteColor];
        _BaseView.layer.cornerRadius = 5;
    }
    return _BaseView;
}
-(UIImageView *)GoodsImage{
    if (!_GoodsImage) {
        _GoodsImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
        _GoodsImage.layer.cornerRadius = 5;
        _GoodsImage.backgroundColor = [UIColor yellowColor];
    }
    return _GoodsImage;
}
-(UILabel *)GoodsName{
    if (!_GoodsName) {
        _GoodsName = [[UILabel alloc]initWithFrame:CGRectMake(self.GoodsImage.right+10, 0, 147, 38)];
        _GoodsName.font = [UIFont systemFontOfSize:14];
        _GoodsName.numberOfLines = 2;
    }
    return _GoodsName;
}
-(UILabel *)GoodsPrice{
    if (!_GoodsPrice) {
        _GoodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(self.GoodsImage.right+10, 0, 147, 38)];
        _GoodsPrice.font = [UIFont systemFontOfSize:15];
        _GoodsPrice.numberOfLines = 1;
        _GoodsPrice.layer.cornerRadius = 5;
        _GoodsPrice.layer.borderWidth = 0.7;
        _GoodsPrice.textColor = UIColorFromRGB(0xEE4E3E);
        _GoodsPrice.layer.borderColor = UIColorFromRGB(0xF0BAB6).CGColor;
        _GoodsPrice.backgroundColor = UIColorFromRGB(0xFCE9E8);
    }
    return _GoodsPrice;
}
-(UIButton *)GoodsBian{
    if (!_GoodsBian) {
        _GoodsBian = [UIButton buttonWithType:UIButtonTypeCustom];
        [_GoodsBian setTitle:@"编辑" forState:UIControlStateNormal];
        [_GoodsBian setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _GoodsBian.titleLabel.font = [UIFont systemFontOfSize:12];
        _GoodsBian.layer.cornerRadius = 13.5;
        _GoodsBian.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [_GoodsBian addTarget:self action:@selector(BianAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _GoodsBian;
}
-(UIButton *)GoodsXia{
    if (!_GoodsXia) {
        _GoodsXia = [UIButton buttonWithType:UIButtonTypeCustom];
        [_GoodsXia setTitle:@"下架" forState:UIControlStateNormal];
        [_GoodsXia setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _GoodsXia.titleLabel.font = [UIFont systemFontOfSize:12];
        _GoodsXia.layer.cornerRadius = 13.5;
        _GoodsXia.backgroundColor = UIColorFromRGB(0xFFFFFF);
        _GoodsXia.layer.borderWidth = 1;
        _GoodsXia.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
        [_GoodsXia addTarget:self action:@selector(SoldAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _GoodsXia;
}
@end
