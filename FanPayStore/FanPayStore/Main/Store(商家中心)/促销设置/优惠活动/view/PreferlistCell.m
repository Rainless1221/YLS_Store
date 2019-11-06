//
//  PreferlistCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PreferlistCell.h"

@implementation PreferlistCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.CellBase];
    [self.CellBase addSubview:self.PreferLabel_view];
    [self.CellBase addSubview:self.PreferLabel];
    [self.CellBase addSubview:self.PreferLabel_text];
    
    [self.CellBase addSubview:self.PreferLabel_day];
    [self.PreferLabel_day mas_makeConstraints:^(MASConstraintMaker *make) {
        //self.PreferLabel.right+45,20,194,24
        make.top.mas_offset(20);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(autoScaleW(194), 24));
    }];
    [self.CellBase addSubview:self.PreferLabel_time];
    [self.PreferLabel_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.PreferLabel_day.mas_bottom).offset(10);
        make.left.equalTo(self.PreferLabel_day.mas_left).offset(0);
        make.right.mas_offset(-10);
    }];
    
   
    
    
   
    
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    
    //状态描述 进行中或已结束
    NSString *desc = [NSString stringWithFormat:@"%@",Data[@"desc"]];
    
    //折扣
    _PreferLabel.text = [NSString stringWithFormat:@"%@",Data[@"discount"]];
    //时间
    _PreferLabel_time.text = [NSString stringWithFormat:@"%@ - %@",Data[@"begin_date"],Data[@"end_date"]];
    
    
    //剩下时间
    if ([desc isEqualToString:@"未开始"]) {
        
        NSString *expiry = [NSString stringWithFormat:@"%@",Data[@"begin_date"]];
        NSArray *array = [expiry componentsSeparatedByString:@"-"];
        NSString *protocol = [NSString stringWithFormat:@"%@ 月 %@ 日 00:00 开始",array[1],array[2]];
        NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
        //设置字体颜色
        [attri_str setFont:[UIFont systemFontOfSize:15]];
        attri_str.color= [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        NSRange ProRange = [protocol rangeOfString:@"开始"];
        NSRange ProRange1 = [protocol rangeOfString:@"月"];
        NSRange ProRange2 = [protocol rangeOfString:@"日"];
        [attri_str setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"96AFCC"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        [attri_str setTextHighlightRange:ProRange1 color:[UIColor colorWithHexString:@"96AFCC"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        [attri_str setTextHighlightRange:ProRange2 color:[UIColor colorWithHexString:@"96AFCC"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        self.PreferLabel_day.attributedText = attri_str;
        self.PreferLabel_day.textAlignment = 1;
        self.PreferLabel_day.layer.borderWidth = 1;
        _PreferLabel_day.backgroundColor = [UIColor colorWithRed:235/255.0 green:243/255.0 blue:255/255.0 alpha:1.0];

    }else{
        NSString *protocol = [NSString stringWithFormat:@"活动剩余：%@ 天 %@ 时 %@ 分",Data[@"remainder_days"],Data[@"remainder_hours"],Data[@"remainder_minutes"]];
        NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
        //设置字体颜色
        [attri_str setFont:[UIFont systemFontOfSize:15]];
        attri_str.color= [UIColor colorWithRed:247/255.0 green:174/255.0 blue:42/255.0 alpha:1.0];
        NSRange ProRange = [protocol rangeOfString:@"活动剩余："];
        NSRange ProRange1 = [protocol rangeOfString:@"天"];
        NSRange ProRange2 = [protocol rangeOfString:@"时"];
        NSRange ProRange3 = [protocol rangeOfString:@"分"];
        [attri_str setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 1)];
        [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"666666"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        [attri_str setTextHighlightRange:ProRange1 color:[UIColor colorWithHexString:@"666666"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        [attri_str setTextHighlightRange:ProRange2 color:[UIColor colorWithHexString:@"666666"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        [attri_str setTextHighlightRange:ProRange3 color:[UIColor colorWithHexString:@"666666"] backgroundColor:[UIColor whiteColor] userInfo:nil];
        self.PreferLabel_day.attributedText = attri_str;
        self.PreferLabel_day.textAlignment = 1;
        self.PreferLabel_day.layer.borderWidth = 0;
        _PreferLabel_day.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];

    }
    
    
    

//    _PreferLabel_day.text = [NSString stringWithFormat:@"活动剩余：%@ 天 %@ 时 %@ 分",Data[@"remainder_days"],Data[@"remainder_hours"],Data[@"remainder_minutes"]];
    
    
//    NSArray *iconArr = @[@"bank_ccb_card_bg",@"btn_dialogue_details_bottom_add_normal",@"icn_msg_cnenter_cashier",@"bank_abc_card_bg",@"bank_boc_card_bg"];

    NSMutableArray *iconArray = [NSMutableArray array];
    for (NSString *string in Data[@"goods_pics"]) {
        [iconArray addObject:string];
    }
    NSInteger picmun = iconArray.count;
    if (picmun>8) {
        picmun = 8;
    }
    for (int i =0; i<picmun; i++) {
        self.icons= [[UIImageView alloc]initWithFrame:CGRectMake(20+i*22, 97, 32, 32)];
        NSString *url = [NSString stringWithFormat:@"%@",iconArray[i]];
//        icon.image = [UIImage imageNamed:url];
        [self.icons setImageWithURL:[NSURL URLWithString:url] placeholder:nil];
        self.icons.layer .borderWidth =1;
        self.icons.layer.borderColor = [UIColor whiteColor].CGColor;
        self.icons.layer.cornerRadius = 32/2;
        self.icons.layer.masksToBounds = YES;
        [self.CellBase addSubview:self.icons];
    }
    
    

/*
 状态
 */
    if ([desc isEqualToString:@"已结束"]) {
        CAGradientLayer *gl = [CAGradientLayer layer];
        gl.frame = CGRectMake(0,0,52,52);
        gl.startPoint = CGPointMake(0, 0);
        gl.endPoint = CGPointMake(0, 0);
        gl.colors = @[(__bridge id)[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0].CGColor];
        gl.cornerRadius = 52/2;
        gl.locations = @[@(0.0),@(0.5),@(1.0)];
        [_PreferLabel_view.layer addSublayer:gl];
        _PreferLabel_view.layer.shadowOffset = CGSizeMake(0,0);
        _PreferLabel_view.layer.shadowOpacity = 1;
        _PreferLabel_view.layer.shadowRadius = 9;
        _PreferLabel_view.layer.shadowColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:0.5].CGColor;
        
        
         self.PreferLabel_view.backgroundColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
        _PreferLabel_text.textColor = [UIColor colorWithRed:196/255.0 green:196/255.0 blue:196/255.0 alpha:1.0];
    }else{
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = CGRectMake(0,0,52,52);
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
//        gl.cornerRadius = 52/2;
//        gl.locations = @[@(0.0),@(0.5),@(1.0)];
//        [_PreferLabel_view.layer addSublayer:gl];
        
//        self.PreferLabel_view.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];

        _PreferLabel_view.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        _PreferLabel_view.layer.shadowColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:0.5].CGColor;
        _PreferLabel_view.layer.shadowOffset = CGSizeMake(0,4);
        _PreferLabel_view.layer.shadowOpacity = 1;
        _PreferLabel_view.layer.shadowRadius = 9;
        
       
    }
    
}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 144)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
        
        
    }
    return _CellBase;
}
-(UIView *)PreferLabel_view{
    if (!_PreferLabel_view) {
        _PreferLabel_view = [[UIView alloc]initWithFrame:CGRectMake(20, 15, 52, 52)];
        _PreferLabel_text.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];

        _PreferLabel_view.layer.cornerRadius = 52/2;
        
    }
    return _PreferLabel_view;
}
-(UILabel *)PreferLabel{
    if (!_PreferLabel) {
        _PreferLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 15, 52, 52)];
        _PreferLabel.textColor = [UIColor whiteColor];
        _PreferLabel.font = [UIFont systemFontOfSize:28];
        _PreferLabel.textAlignment = 1;
        
        
    }
    return _PreferLabel;
}
-(UILabel *)PreferLabel_text{
    if (!_PreferLabel_text) {
        _PreferLabel_text = [[UILabel alloc]initWithFrame: CGRectMake(self.PreferLabel.right+5,50,14.5,14)];
        _PreferLabel_text.textColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        _PreferLabel_text.font = [UIFont systemFontOfSize:15];
        _PreferLabel_text.textAlignment = 1;
        
        _PreferLabel_text.text = @"折";
    }
    return _PreferLabel_text;
}

-(YYLabel *)PreferLabel_day{
    if (!_PreferLabel_day) {
        _PreferLabel_day = [[YYLabel alloc]initWithFrame: CGRectMake(self.PreferLabel.right+45,20,194,24)];
        _PreferLabel_day.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        _PreferLabel_day.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        _PreferLabel_day.layer.cornerRadius = 12;
        _PreferLabel_day.font = [UIFont systemFontOfSize:15];
        _PreferLabel_day.textAlignment = 1;
        _PreferLabel_day.layer.masksToBounds = YES;
        _PreferLabel_day.layer.borderWidth = 1;
        _PreferLabel_day.layer.borderColor = UIColorFromRGB(0xB4D7FF).CGColor;
//        _PreferLabel_day.text = @"活动剩余：4 天 10 时 28 分";
    }
    return _PreferLabel_day;
}
-(UILabel *)PreferLabel_time{
    if (!_PreferLabel_time) {
        _PreferLabel_time = [[UILabel alloc]initWithFrame: CGRectMake(self.PreferLabel.right+54,self.PreferLabel_day.bottom+9,250,14)];
        _PreferLabel_time.textColor = [UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1.0];
        _PreferLabel_time.layer.cornerRadius = 12;
        _PreferLabel_time.font = [UIFont systemFontOfSize:12];
        
        
    }
    return _PreferLabel_time;
}


@end
