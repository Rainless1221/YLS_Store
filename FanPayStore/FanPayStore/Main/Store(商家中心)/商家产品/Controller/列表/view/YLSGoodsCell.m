//
//  YLSGoodsCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/18.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSGoodsCell.h"

@implementation YLSGoodsCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    
    return self;
}
#pragma mark - UI
-(void)createUI{
    /**白色底部*/
    [self addSubview:self.GoodsView];
    [self.GoodsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(7);
        make.bottom.mas_offset(-7);
    }];
    /*图片*/
    [self.GoodsView addSubview:self.Goodsimage];
    [self.Goodsimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(120), IPHONEWIDTH(120)));
    }];
    /*名称*/
    [self.GoodsView addSubview:self.GoodsNmage];
    [self.GoodsNmage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.equalTo(self.Goodsimage.mas_right).offset(15.5);
        make.right.mas_offset(-10);
        make.height.mas_offset(IPHONEWIDTH(46.5));
    }];
    /*价格*/
    [self.GoodsView addSubview:self.GoodsPrice];
    [self.GoodsPrice mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsNmage.mas_bottom).offset(0);
        make.left.equalTo(self.Goodsimage.mas_right).offset(15.5);
        make.height.mas_offset(IPHONEWIDTH(32));
    }];
    /*原价格*/
    [self.GoodsView addSubview:self.GoodsPrice1];
    [self.GoodsPrice1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsPrice.mas_bottom).offset(10);
        make.left.equalTo(self.Goodsimage.mas_right).offset(15.5);
        make.height.mas_offset(IPHONEWIDTH(24));
    }];
    /*数量*/
    [self.GoodsView addSubview:self.GoodsCount];
    [self.GoodsCount mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsPrice.mas_bottom).offset(10);
        make.left.equalTo(self.GoodsPrice1.mas_right).offset(15.5);
        make.height.mas_offset(IPHONEWIDTH(24));
    }];
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"份";
    label.font = [UIFont systemFontOfSize:13];
    label.textColor = UIColorFromRGB(0x999999);
    [self.GoodsView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsPrice.mas_bottom).offset(10);
        make.left.equalTo(self.GoodsCount.mas_right).offset(1.5);
        make.height.mas_offset(IPHONEWIDTH(24));
    }];
    
    /*备注*/
    [self.GoodsView addSubview:self.GoodsDesc];
    [self.GoodsDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsPrice1.mas_bottom).offset(10);
        make.left.equalTo(self.Goodsimage.mas_right).offset(15.5);
         make.right.mas_offset(-15.5);
    }];
    
    /**标签*/
    [self.GoodsView addSubview:self.GoodsLabel];
    [self.GoodsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsDesc.mas_bottom).offset(10);
        make.left.equalTo(self.Goodsimage.mas_right).offset(15.5);
        make.height.mas_offset(20);
    }];
    
}
#pragma mark - 单元类型
-(void)setStatus:(GoodsStatus)status{
    _status = status;
    if (_status == GoodsStatus_1) {
        /*上架*/
        [self Putaway];
        
    }else if (_status == GoodsStatus_2){
        /*下架*/
        [self Soldout];
        
    }else if (_status == GoodsStatus_3){
        /*删除*/
        [self GoodsDelete];
        
    }else{
        /*上架*/
        [self Putaway];
    }
    
}
#pragma mark - 上架
-(void)Putaway{
    /*下架*/
    UIButton *buttonSold = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSold.layer.cornerRadius = 16;
    buttonSold.layer.borderWidth = 1;
    buttonSold.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    [buttonSold setTitle:@"下架" forState:UIControlStateNormal];
    [buttonSold setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    [buttonSold addTarget:self action:@selector(SoldAction) forControlEvents:UIControlEventTouchUpInside];
    buttonSold.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.GoodsView addSubview:buttonSold];
    [buttonSold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsLabel.mas_bottom).offset(14.5);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    
    /*编辑*/
    UIButton *buttonBian = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBian.layer.cornerRadius = 16;
    buttonBian.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [buttonBian setTitle:@"编辑" forState:UIControlStateNormal];
    [buttonBian setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    buttonBian.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonBian addTarget:self action:@selector(BianAction) forControlEvents:UIControlEventTouchUpInside];
    [self.GoodsView addSubview:buttonBian];
    [buttonBian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsLabel.mas_bottom).offset(14.5);
        make.right.equalTo(buttonSold.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    
}
#pragma mark - 下架
-(void)Soldout{
    /*删除*/
    UIButton *buttonSold = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonSold.layer.cornerRadius = 16;
    buttonSold.layer.borderWidth = 1;
    buttonSold.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    [buttonSold setTitle:@"删除" forState:UIControlStateNormal];
    [buttonSold setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    buttonSold.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonSold addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.GoodsView addSubview:buttonSold];
    [buttonSold mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsLabel.mas_bottom).offset(14.5);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    
    /*上架*/
    UIButton *buttonPutaway = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonPutaway.layer.cornerRadius = 16;
    buttonPutaway.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [buttonPutaway setTitle:@"上架" forState:UIControlStateNormal];
    [buttonPutaway setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    buttonPutaway.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonPutaway addTarget:self action:@selector(PutawayAction) forControlEvents:UIControlEventTouchUpInside];
    [self.GoodsView addSubview:buttonPutaway];
    [buttonPutaway mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsLabel.mas_bottom).offset(14.5);
        make.right.equalTo(buttonSold.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*编辑*/
    UIButton *buttonBian = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonBian.layer.cornerRadius = 16;
    buttonBian.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [buttonBian setTitle:@"编辑" forState:UIControlStateNormal];
    [buttonBian setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    buttonBian.titleLabel.font = [UIFont systemFontOfSize:14];
    [buttonBian addTarget:self action:@selector(BianAction) forControlEvents:UIControlEventTouchUpInside];
    [self.GoodsView addSubview:buttonBian];
    [buttonBian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.GoodsLabel.mas_bottom).offset(14.5);
        make.right.equalTo(buttonPutaway.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
}
#pragma mark - 删除
-(void)GoodsDelete{
    [self.GoodsView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(50);
        make.right.mas_offset(50);
    }];
}
#pragma mark - 高度
- (CGFloat)getCellHeight {
    return  self.GoodsView.bottom;
}

#pragma mark - 下架事件
-(void)SoldAction{
    NSLog(@"下架");
    if (self.SoldBlock) {
        self.SoldBlock();
    }
}
#pragma mark - 上架事件
-(void)PutawayAction{
    NSLog(@"上架");
    if (self.PutawayBlock) {
        self.PutawayBlock();
    }
}
#pragma mark - 编辑事件
-(void)BianAction{
    NSLog(@"编辑");
    if (self.BianjiBlock) {
        self.BianjiBlock();
    }
}
#pragma mark - 删除事件
-(void)DeleteAction{
    NSLog(@"删除");
    if (self.DeleteBlock) {
        self.DeleteBlock();
    }
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
                        img.image=[UIImage imageNamed:@"btn_product_label_select_yellow"];
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

#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    //图片
    NSString *goods_pic = [NSString stringWithFormat:@"%@",Data[@"goods_pic"]];
    NSArray *picarr = [goods_pic componentsSeparatedByString:@","];
    [self.Goodsimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",picarr[0]]] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    //名称
    NSString *goods_name = [NSString stringWithFormat:@"%@",Data[@"goods_name"]];
    if ([[MethodCommon judgeStringIsNull:goods_name] isEqualToString:@""]) {
        goods_name = @"";
    }
    self.GoodsNmage.text = goods_name;
    
    //价格
    NSString *discount_price = [NSString stringWithFormat:@"%@",Data[@"discount_price"]];
    if ([[MethodCommon judgeStringIsNull:discount_price] isEqualToString:@""]) {
        discount_price = @" ¥ 0.00 ";
    }else{
        discount_price = [NSString stringWithFormat:@" ¥ %@ ",discount_price];
    }
    NSMutableAttributedString *mutStr = [[NSMutableAttributedString alloc]initWithString:discount_price];
    NSRange range = NSMakeRange(0, 2);
    [mutStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:15] range:range];
    self.GoodsPrice.attributedText = mutStr;
    
    NSString *goods_price = [NSString stringWithFormat:@"%@",Data[@"goods_price"]];
    if ([[MethodCommon judgeStringIsNull:goods_price] isEqualToString:@""]) {
        goods_price = @"     ¥ 0.00  ";
    }else{
        goods_price = [NSString stringWithFormat:@"  ¥ %@  ",goods_price];
    }
    NSMutableAttributedString *mutStr1 = [[NSMutableAttributedString alloc]initWithString:goods_price];
    NSRange range1 = NSMakeRange(0, 3);
    [mutStr1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:range1];
    self.GoodsPrice1.attributedText = mutStr1;
    
    
    /**
     数量
     */
    NSString *goods_count = [NSString stringWithFormat:@"%@",Data[@"goods_count"]];
    if ([[MethodCommon judgeStringIsNull:goods_count] isEqualToString:@""]) {
        goods_count = @"0";
    }
    self.GoodsCount.text = [NSString stringWithFormat:@"%@",goods_count];
    
    /*备注*/
    NSString *goods_desc = [NSString stringWithFormat:@"%@",Data[@"goods_desc"]];
    if ([[MethodCommon judgeStringIsNull:goods_desc] isEqualToString:@""]) {
        goods_desc = @"";
    }
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:goods_desc];
    self.GoodsDesc.attributedText = attri_str;
    CGSize size = [self.GoodsDesc sizeThatFits:CGSizeMake(self.GoodsView.width-IPHONEWIDTH(120)-41, MAXFLOAT)];
//    NSLog(@"字符串高度是：%f",size.height);

    /*标签*/
    NSString *category_name = [NSString stringWithFormat:@"%@",Data[@"category_name"]];
    if ([[MethodCommon judgeStringIsNull:category_name] isEqualToString:@""]) {
        category_name = @"";
        [self.GoodsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(0);
        }];
    }else{
        self.GoodsLabel.text = [NSString stringWithFormat:@"#%@",category_name];
    }
    
    
    CGSize size1 = [self.GoodsLabel sizeThatFits:CGSizeZero];
    [self.GoodsLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(size1.width + 15);
    }];
    
    if (self.status == GoodsStatus_3) {
        self.GoodsView.height = self.GoodsPrice1.bottom+25+size.height+(size1.height >0 ? size1.height+15:5);
    }else{
        self.GoodsView.height = self.GoodsPrice1.bottom+80+size.height+(size1.height >0 ? size1.height+15:5);
    }
    
}
#pragma mark - 懒加载
-(UIView *)GoodsView{
    if (!_GoodsView) {
        _GoodsView = [[UIView alloc]initWithFrame:CGRectMake(15, 7, ScreenW-30, 232)];
        _GoodsView.backgroundColor = [UIColor whiteColor];
        _GoodsView.layer.cornerRadius = 5;
        _GoodsView.clipsToBounds=YES;
    }
    return _GoodsView;
}
-(UIImageView *)Goodsimage{
    if (!_Goodsimage) {
        _Goodsimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 120, 120)];
        _Goodsimage.layer.masksToBounds = YES;
        _Goodsimage.image = [UIImage imageNamed:@"pic_default_avatar"];
        _Goodsimage.layer.cornerRadius = 5;
    }
    return _Goodsimage;
}
-(UILabel *)GoodsNmage{
    if (!_GoodsNmage) {
        _GoodsNmage = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 46)];
        _GoodsNmage.font = [UIFont systemFontOfSize:IPHONEWIDTH(18)];
        _GoodsNmage.textColor = UIColorFromRGB(0x222222);
        _GoodsNmage.numberOfLines = 2;
    }
    return _GoodsNmage;
}
-(UILabel *)GoodsPrice{
    if (!_GoodsPrice) {
        _GoodsPrice = [[UILabel alloc]initWithFrame:CGRectMake(0, self.GoodsNmage.bottom, 80, 32)];
        _GoodsPrice.font = [UIFont systemFontOfSize:22];
        _GoodsPrice.textColor = UIColorFromRGB(0xEE4E3E);
        _GoodsPrice.backgroundColor = UIColorFromRGB(0xFCE9E8);
        _GoodsPrice.layer.borderWidth = 0.5;
        _GoodsPrice.layer.borderColor = UIColorFromRGB(0xF0BAB6).CGColor;
        _GoodsPrice.layer.cornerRadius = 5;
         _GoodsPrice.layer.masksToBounds = YES;
    }
    return _GoodsPrice;
}
-(UILabel *)GoodsPrice1{
    if (!_GoodsPrice1) {
        _GoodsPrice1 = [[UILabel alloc]initWithFrame:CGRectMake(0, self.GoodsPrice.bottom+10, 80, 24)];
        _GoodsPrice1.font = [UIFont systemFontOfSize:17];
        _GoodsPrice1.textColor = UIColorFromRGB(0x3D8AFF);
        _GoodsPrice1.backgroundColor = UIColorFromRGB(0xE8F2FF);
        _GoodsPrice1.layer.borderWidth = 0.5;
        _GoodsPrice1.layer.borderColor = UIColorFromRGB(0xB4D7FF).CGColor;
        _GoodsPrice1.layer.cornerRadius = 12;
         _GoodsPrice1.layer.masksToBounds = YES;
    }
    return _GoodsPrice1;
}
-(UILabel *)GoodsCount{
    if (!_GoodsCount) {
        _GoodsCount = [[UILabel alloc]initWithFrame:CGRectMake(0, self.GoodsPrice.bottom+10, 80, 24)];
        _GoodsCount.font = [UIFont systemFontOfSize:15];
        _GoodsCount.textColor = UIColorFromRGB(0x3D8AFF);
    }
    return _GoodsCount;
}
-(UILabel *)GoodsDesc{
    if (!_GoodsDesc) {
        _GoodsDesc = [[UILabel alloc]initWithFrame:CGRectMake(0, self.GoodsPrice1.bottom+15, 120, 20)];
        _GoodsDesc.font = [UIFont systemFontOfSize:IPHONEWIDTH(13)];
        _GoodsDesc.textColor = UIColorFromRGB(0x999999);
        _GoodsDesc.numberOfLines = 0;
    }
    return _GoodsDesc;
}
-(UILabel *)GoodsLabel{
    if (!_GoodsLabel) {
        _GoodsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, self.GoodsDesc.bottom+10, 50, 20)];
        _GoodsLabel.font = [UIFont systemFontOfSize:IPHONEWIDTH(12)];
        _GoodsLabel.textColor = UIColorFromRGB(0x3D8AFF);
        _GoodsLabel.textAlignment = 1;
        _GoodsLabel.numberOfLines = 1;
        _GoodsLabel.layer.borderWidth = 1;
        _GoodsLabel.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        _GoodsLabel.layer.cornerRadius = 10;
    }
    return _GoodsLabel;
}
@end
