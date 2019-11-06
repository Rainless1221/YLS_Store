//
//  SampleView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SampleView.h"
#import "BannerView.h"

@implementation SampleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    [self addSubview:self.BaseView];
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.width.mas_offset(ScreenW-30);
        make.height.mas_offset(368);
    }];
    
    /**
     横线
     */
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.BaseView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.right.mas_offset(0);
        make.height.mas_offset(1);
    }];
    /**
     叉号
     */
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [Button addTarget:self action:@selector(Buttonaction) forControlEvents:UIControlEventTouchUpInside];
    [self.BaseView addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(5);
        make.size.mas_offset(CGSizeMake(40, 40));
    }];
    
    /**
     标题
     */
    self.Sampletext = [[UILabel alloc]init];
    self.Sampletext.text = @"店内环境-示例图";
    self.Sampletext.textAlignment = 1;
    self.Sampletext.textColor = UIColorFromRGB(0x222222);
    self.Sampletext.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.Sampletext];
    [self.Sampletext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.centerX.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    /**
     确定按钮
     */
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, self.BaseView.width-60, 44);
//    queButton.backgroundColor = UIColorFromRGB(0x3D8AFF);
//    queButton.layer.cornerRadius = 10;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = queButton.bounds;
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [queButton.layer addSublayer:gl];
    
    queButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    queButton.layer.shadowOffset = CGSizeMake(0,4);
    queButton.layer.shadowOpacity = 1;
    queButton.layer.shadowRadius = 9;
    
    [queButton setTitle:@"确定" forState:UIControlStateNormal];
    [queButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    
    [queButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(queButtonaction) forControlEvents:UIControlEventTouchUpInside];

    [self.BaseView addSubview:queButton];
    [queButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(30);
        make.right.mas_offset(-30);
        make.height.mas_offset(44);
    }];
    
    
    
    
}
-(void)setImagesArr:(NSArray *)imagesArr{
    /*轮播图*/
    [BannerView showBannerWithFrame:CGRectMake(50, 70, ScreenW-130, 190) images:imagesArr superView:self.BaseView tapBlock:^(NSInteger index) {
        
    }];
}
#pragma mark - 确定
-(void)queButtonaction{
     [self removeFromSuperview];
}
#pragma mark - 叉号
-(void)Buttonaction{
    
    [self removeFromSuperview];
    
}
#pragma mark -GET
- (UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 368)];
        _BaseView.backgroundColor = [UIColor whiteColor];
        _BaseView.layer.cornerRadius = 6;
    }
    return _BaseView;
}
@end
