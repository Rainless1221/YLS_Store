//
//  StoreStatus_View.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StoreStatus_View.h"

@implementation StoreStatus_View

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark -  UI
-(void)createUI{
    //头像
    [self addSubview:self.store_logo];
    [self.store_logo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(72, 72));
    }];
    //ID
    [self addSubview:self.store_ID];
    [self.store_ID mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_logo.mas_bottom).offset(15);
        make.left.mas_offset(10);
    }];
    //店名
    [self addSubview:self.store_name];
    [self.store_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_ID.mas_bottom).offset(10);
        make.left.mas_offset(10);
        make.width.mas_offset(150);
    }];
    //类型图标
    self.type_imageView = [[UIImageView alloc] init];
    self.type_imageView.frame = CGRectMake(25,94,72,72);
    self.type_imageView.image =  [UIImage imageNamed:@"pic_default_avatar"];
    [self addSubview:self.type_imageView];
    [self.type_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(25);
        make.left.equalTo(self.store_logo.mas_right).offset(IPHONEWIDTH(72));
        make.size.mas_offset(CGSizeMake(16, 16));
    }];
    //类型
    self.category_name = [[UILabel alloc] init];
    self.category_name.frame = CGRectMake(25.5,200,95,15);
    self.category_name.numberOfLines = 0;
    self.category_name.textColor = UIColorFromRGB(0x222222);
    self.category_name.font = [UIFont systemFontOfSize:15];
    self.category_name.text = @"餐饮 — 中餐";
    [self addSubview:self.category_name];
    [self.category_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(25);
        make.left.equalTo(self.type_imageView.mas_right).offset(10);
        make.height.mas_offset(15);
    }];
    //粉丝
    self.fans_num = [[UILabel alloc] init];
    self.fans_num.frame = CGRectMake(168.5,136,24.5,11);
    self.fans_num.numberOfLines = 0;
    self.fans_num.textColor = UIColorFromRGB(0x222222);
    self.fans_num.font = [UIFont systemFontOfSize:15];
    self.fans_num.text = @" 粉丝";
    [self addSubview:self.fans_num];
    [self.fans_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.type_imageView.mas_bottom).offset(16);
        make.left.equalTo(self.store_logo.mas_right).offset(IPHONEWIDTH(72));
        make.height.mas_offset(15);
    }];
    //商品
    UILabel *good_label = [[UILabel alloc] init];
    good_label.frame = CGRectMake(168.5,136,24.5,11);
    good_label.numberOfLines = 0;
    good_label.textColor = UIColorFromRGB(0x222222);
    good_label.font = [UIFont systemFontOfSize:15];
    good_label.text = @" 商品";
    [self addSubview:good_label];
    [good_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.type_imageView.mas_bottom).offset(16);
        make.left.equalTo(self.fans_num.mas_right).offset(22);
        make.height.mas_offset(15);
    }];
    
    //横线
    UIView *line_view = [[UIView alloc] init];
    line_view.frame = CGRectMake(0,0,self.width,0.5);
    line_view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line_view];
    [line_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-50);
        make.height.mas_offset(0.5);
    }];
    //编辑按钮
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setTitle:@"点击编辑" forState:UIControlStateNormal];
    [Button setImage:[UIImage imageNamed:@"ico_edit_b_info"] forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:14];
    Button.layer.borderWidth = 1;
    Button.layer.borderColor = UIColorFromRGB(0x8D8D8D).CGColor;
    Button.layer.cornerRadius = 14;
    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.bottom.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(96, 28));
    }];
    
}
#pragma mark - 编辑
-(void)ButtonAction{
    if (self.StoreNameBlock) {
        self.StoreNameBlock();
    }
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    /** logo */
    NSString *logo_Url = [NSString stringWithFormat:@"%@",Data[@"store_logo"]];
    if ([PublicMethods isUrl:logo_Url]) {
    }else{
        logo_Url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,logo_Url];
    }
    [self.store_logo setImageWithURL:[NSURL URLWithString:logo_Url] placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
    
    /** 商铺名称 */
    NSString *store_name=[NSString stringWithFormat:@"%@",Data[@"store_name"]];
    if ([[MethodCommon judgeStringIsNull:store_name] isEqualToString:@""]) {
        
    }else{
        self.store_name.text =store_name;

    }
    NSString *category_pic = [NSString stringWithFormat:@"%@",Data[@"category_pic"]];
    if ([PublicMethods isUrl:category_pic]) {
    }else{
        category_pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,category_pic];
    }
    NSString *imageUrl = [category_pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.type_imageView setImageWithURL:[NSURL URLWithString:imageUrl] placeholder:[UIImage imageNamed:@"icn_shop_type_cycle_green"]];
    /** 商铺分类 */
    NSString *category_name=[NSString stringWithFormat:@"  %@ ",Data[@"category_name"]];
    if ([[MethodCommon judgeStringIsNull:category_name] isEqualToString:@""]) {
        
    }else{
        self.category_name.text = category_name;
    }
    
    /** 粉丝数量  */
    NSString *fans_num= [NSString stringWithFormat:@"%@",Data[@"fans_num"]];
    if ([[MethodCommon judgeStringIsNull:fans_num] isEqualToString:@""]) {
        
    }else{
        self.fans_num.text = [NSString stringWithFormat:@"%@ 粉丝",fans_num];;
    }
    /** 商品数量  */
   NSString *goods_num =  [NSString stringWithFormat:@"%@",Data[@"goods_num"]];
    if ([[MethodCommon judgeStringIsNull:goods_num] isEqualToString:@""]) {
        
    }else{
        self.goods_num.text =  [NSString stringWithFormat:@"%@ 商品",goods_num];
    }
}
#pragma mark - 懒加载
-(UIImageView *)store_logo{
    if (!_store_logo) {
        _store_logo = [[UIImageView alloc] init];
        _store_logo.frame = CGRectMake(25,94,72,72);
        _store_logo.image =  [UIImage imageNamed:@"WechatIMG20"];
        _store_logo.layer.cornerRadius = 72/2;
        _store_logo.layer.masksToBounds = YES;
    }
    return _store_logo;
}
-(UILabel *)store_name{
    if (!_store_name) {
        _store_name = [[UILabel alloc] init];
        _store_name.frame = CGRectMake(25.5,200,95,15);
        _store_name.numberOfLines = 1;
        _store_name.textColor = UIColorFromRGB(0x222222);
        _store_name.font = [UIFont systemFontOfSize:16];
        _store_name.text = @"大房子创意菜";
    }
    return _store_name;
}
-(UILabel *)store_ID{
    if (!_store_ID) {
        _store_ID = [[UILabel alloc] init];
        _store_ID.frame = CGRectMake(25,181,113.5,9);
        _store_ID.numberOfLines = 0;
        _store_ID.textColor = UIColorFromRGB(0x666666);
        _store_ID.font = [UIFont systemFontOfSize:12];
        _store_ID.text = @"ID:eluson123456789";
    }
    return _store_ID;
}
@end
