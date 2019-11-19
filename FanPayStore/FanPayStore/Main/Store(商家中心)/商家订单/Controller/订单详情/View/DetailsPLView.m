//
//  DetailsPLView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  订单信息——评论信息

#import "DetailsPLView.h"

@implementation DetailsPLView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(11,0,350,60);
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size: 18];
    label.text = @"本次订单已评价";
    [self addSubview:label];
    
    /*评价内容*/
    [self addSubview:self.evaluate_content];
    [self.evaluate_content mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(98);
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
    }];
    
    
    
    
    /** 回复按钮 */
    UIButton *huifu = [UIButton buttonWithType:UIButtonTypeCustom];
    [huifu setTitle:@" 回复用户" forState:UIControlStateNormal];
    [huifu setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [huifu.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [huifu setImage:[UIImage imageNamed:@"icn_reply_customer_blue"] forState:UIControlStateNormal];
    huifu.layer.cornerRadius = 6;
    huifu.layer.borderWidth = 1;
    huifu.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    [huifu addTarget:self action:@selector(huifuAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:huifu];
    [huifu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-30);
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.height.mas_offset(40);
    }];
    
    
    //星星
    self.starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 76, 160, 30)];
    self.starEvaluator.delegate = self;
    [self addSubview:self.starEvaluator];
    [self.starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_equalTo(54);
        make.size.mas_offset(CGSizeMake(160, 30));
    }];
    self.starEvaluator.userInteractionEnabled = NO;
    
    UILabel *star = [[UILabel alloc]init];
    star.textColor = UIColorFromRGB(0xF7AE2B);
    star.font = [UIFont systemFontOfSize:15];
    star.text = @"0分";
    [self addSubview:star];
    self.star = star;
    [star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.centerY.equalTo(self.starEvaluator.mas_centerY).offset(0);
//        make.height.mas_equalTo(50);
    }];
    

    
    
}

/** 回复评论 **/
-(void)huifuAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Huifu_order)]) {
        [self.delagate Huifu_order];
    }
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    NSDictionary *evaluate_info = Data[@"evaluate_info"];
    
#pragma mark - 评论语
    NSString *evaluate_content = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_content"]];
    if ([[MethodCommon judgeStringIsNull:evaluate_content] isEqualToString:@""]) {
        evaluate_content = @"  ";
    }
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:evaluate_content];
    attri_str.lineSpacing = 5;
    self.evaluate_content.attributedText = attri_str;
    self.evaluate_content.height = self.evaluate_content.height +100;
    
#pragma mark - 评分
    NSString *score = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_score"]];
    if ([[MethodCommon judgeStringIsNull:score] isEqualToString:@""]) {
        score = @"0";
    }
    self.starEvaluator.currentValue = [score integerValue];
    self.star.text =  [NSString stringWithFormat:@"%@分",score];
    
    
    //图片的数组
    NSString *evaluate_pics = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_pics"]];
    NSArray *array = [NSArray array];
    if ([[MethodCommon judgeStringIsNull:evaluate_pics] isEqualToString:@""]) {
        
    }else{
        // 用指定字符串分割字符串，返回一个数组
        array = [evaluate_pics componentsSeparatedByString:@","];
    }
    NSInteger imageMun = array.count;
    int d = ceil(imageMun / 3.0);
    
    
    //标签的数组
    NSString *evaluate_tags = [NSString stringWithFormat:@"%@",evaluate_info[@"evaluate_tags"]];
    NSArray *tagsarray = [NSArray array];
    if ([[MethodCommon judgeStringIsNull:evaluate_tags] isEqualToString:@""]) {
        
    }else{
        // 用指定字符串分割字符串，返回一个数组
        tagsarray = [evaluate_tags componentsSeparatedByString:@","];
    }
    
    NSInteger tagMun = tagsarray.count;
    int f = ceil(tagMun / 3.0);
    
#pragma mark -    /** 标签 */
    UIView *evaluateView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, tagMun*28)];
    [self addSubview:evaluateView];
    [evaluateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.evaluate_content.mas_bottom).offset(0);
        make.right.left.mas_offset(0);
        make.height.mas_offset(tagMun*28);
    }];
    
    for (int i =0; i<tagMun; i++) {
        NSInteger  y = i/3 ;
        NSInteger  x = i%3;
        UILabel *evaluate_tags = [[UILabel alloc]init];
        
        NSString *tabstring = [NSString stringWithFormat:@"%@",tagsarray[i]];
        
        if ([[MethodCommon judgeStringIsNull:tabstring] isEqualToString:@""]) {
            
        }else{
            tabstring = [NSString stringWithFormat:@"#%@",tagsarray[i]];
            evaluate_tags.text = [NSString stringWithFormat:@"%@",tabstring];
        }
        evaluate_tags.textColor = UIColorFromRGB(0xF7AE2B);
        evaluate_tags.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        evaluate_tags.font = [UIFont systemFontOfSize:autoScaleW(14)];
        evaluate_tags.layer.borderWidth = 1;
        evaluate_tags.layer.cornerRadius = 14;
        evaluate_tags.textAlignment = 1;

        
        static UIButton *recordBtn =nil;
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect rect = [tabstring boundingRectWithSize:CGSizeMake(evaluateView.width -20, 28) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:btn.titleLabel.font} context:nil];
        [btn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        CGFloat BtnW = rect.size.width + 10;
        CGFloat BtnH = rect.size.height + 2;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = BtnH/2;
        btn.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        btn.layer.borderWidth = 1;
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        if (i == 0){
            btn.frame = CGRectMake(10, 10, BtnW, BtnH);
        }else{
            
            CGFloat yuWidth = self.width - 20 -recordBtn.frame.origin.x -recordBtn.frame.size.width;
            
            if (yuWidth >= rect.size.width) {
                
                btn.frame =CGRectMake(recordBtn.frame.origin.x +recordBtn.frame.size.width + 10, recordBtn.frame.origin.y, BtnW, BtnH);
            }else{
                
                btn.frame =CGRectMake(10, recordBtn.frame.origin.y+recordBtn.frame.size.height+10, BtnW, BtnH);
            }
            
        }
        [btn setTitle:tabstring forState:UIControlStateNormal];
        [evaluateView addSubview:btn];
        recordBtn = btn;
        
        [evaluateView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(CGRectGetMaxY(btn.frame)+10);
        }];
    }
    
    
    
    
#pragma mark - 图片
    UIView *picView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, autoScaleW(110)*d)];
    picView.backgroundColor = [UIColor whiteColor];
    [self addSubview:picView];
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(evaluateView.mas_bottom).offset(0);
        make.right.left.mas_offset(0);
        make.height.mas_offset(autoScaleW(110)*d);
    }];
    
    /** 评论图片 **/
    for (int i=0 ; i<imageMun; i++) {
        NSInteger  y = i/3 ;
        NSInteger  x = i%3;
        UIImageView *iamge = [[UIImageView alloc]init];
        NSString *url = [NSString stringWithFormat:@"%@",array[i]];
        [iamge sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
        iamge.backgroundColor = [UIColor redColor];
        iamge.layer.cornerRadius = 5;
        [picView addSubview:iamge];
        [iamge mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(10);
            make.left.mas_offset(x*autoScaleW(110)+10);
            make.size.mas_offset(CGSizeMake(autoScaleW(103), autoScaleW(103)));
        }];
        //        [picView mas_updateConstraints:^(MASConstraintMaker *make) {
        //            make.height.mas_offset(iamge.height+10);
        //        }];
    }
    
    
    
    
#pragma mark - 评价的商品
    NSArray *goodsArr = Data[@"goods_info"];

    /** 评价的商品 */
    for (int i = 0; i<goodsArr.count; i++) {
        
        UILabel *goodsName = [[UILabel alloc]init];
        goodsName.text = [NSString stringWithFormat:@"%@",goodsArr[i][@"goods_name"]];
        goodsName.textColor = UIColorFromRGB(0x222222);
        [self addSubview:goodsName];
        [goodsName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
            make.left.mas_offset(10);
            make.size.mas_offset(CGSizeMake(self.width/2, 25));
        }];
        
        
        UIButton *zan = [UIButton buttonWithType:UIButtonTypeCustom];
        [zan setImage:[UIImage imageNamed:@"icn_product_like_normal"] forState:UIControlStateNormal];
        [zan setImage:[UIImage imageNamed:@"icn_product_like_active"] forState:UIControlStateSelected];
        [self addSubview:zan];
        [zan mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
            make.right.mas_offset(-52);
            make.size.mas_offset(CGSizeMake(32, 32));
        }];
        
        
        UIButton *cai = [UIButton buttonWithType:UIButtonTypeCustom];
        [cai setImage:[UIImage imageNamed:@"icn_product_dislike_normal"] forState:UIControlStateNormal];
        [cai setImage:[UIImage imageNamed:@"icn_product_dislike_active"] forState:UIControlStateSelected];
        [self addSubview:cai];
        [cai mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(picView.mas_bottom).offset(40*i+10);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(32, 32));
        }];
        NSString *evaluate = [NSString stringWithFormat:@"%@",goodsArr[i][@"evaluate"]];
        // 1为赞 0为踩（现都为赞）
        if ( [evaluate isEqualToString: @"1"]) {
            zan.selected = YES;
            cai.selected = NO;
        }else{
            zan.selected = NO;
            cai.selected = YES;
        }
        
        
    }
    
    
}
#pragma mark - 懒加载
-(YYLabel *)evaluate_content{
    if (!_evaluate_content) {
        _evaluate_content = [[YYLabel alloc]initWithFrame:CGRectMake(10, 100, self.width-20, 100)];
        _evaluate_content.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _evaluate_content.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
        _evaluate_content.font = [UIFont systemFontOfSize:14];
        _evaluate_content.numberOfLines = 0;
        _evaluate_content.preferredMaxLayoutWidth = self.width-20;//设置最大宽度
        _evaluate_content.layer.cornerRadius = 6;
    }
    return _evaluate_content ;
}
@end
