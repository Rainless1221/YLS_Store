//
//  RefundView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/29.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RefundView.h"

@implementation RefundView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    
    [self addSubview:self.RScrollView];
    
    

    [self addSubview:self.pageControl];
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(ScreenW-100, 20, 80, 40);
    [Button setTitle:@"查看全部" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:16];
    Button.layer.cornerRadius = 10;
    [Button addTarget:self action:@selector(OrderAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:Button];
   
    
    NSArray *Array = @[
                                        @{@"order":@"345678908",@"Pra":@"900",@"Time":@"2019-10-22 11:02",@"Goods":@"鲍鱼捞饭等 共8件商品",},
                                        @{@"order":@"345678900",@"Pra":@"130",@"Time":@"2018-12-12 11:02",@"Goods":@"鲍鱼捞饭等 共3件商品",},
                                        @{@"order":@"345678955",@"Pra":@"100",@"Time":@"2018-12-2 11:02",@"Goods":@"鲍鱼捞饭等 共2件商品",},
                                        ];
    for (int i =0; i<Array.count; i++) {
        _Refun_View = [[UIView alloc]initWithFrame:CGRectMake(15+i*ScreenW, 64, ScreenW-30,  500)];
        _Refun_View.backgroundColor = [UIColor whiteColor];
        _Refun_View.layer.cornerRadius = 6;
        _Refun_View.clipsToBounds = YES;
        [self.RScrollView addSubview:self.Refun_View];
        [self OrderUI:Array[i]];
    }
    
    
}
#pragma mark - 每单UI
-(void)OrderUI:(NSDictionary *)Data{
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0, 0, ScreenW-30, 60);
    view.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-30,60);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors =@[(__bridge id)[UIColor colorWithRed:251/255.0 green:205/255.0 blue:8/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(1.0)];
    
    [view.layer addSublayer:gl];
    view.layer.cornerRadius = 6;
    
    [self.Refun_View addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(0);
        make.height.mas_equalTo(60);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,0,view.width,view.height);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:18];
    label.textColor = [UIColor blackColor];
    label.text = @"申请退款中";
    [view addSubview:label];
    
    
    
    /*标题*/
    
    NSArray *Arr = @[@"订单编号：",@"订单金额：",@"订单时间："];
    for (int i = 0; i<Arr.count; i++) {
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0,90+i*30,90,30);
        label.numberOfLines = 0;
        label.textAlignment = 2;
        label.font = [UIFont systemFontOfSize:15];
        label.text= [NSString stringWithFormat:@"%@",Arr[i]];
        [self.Refun_View addSubview:label];
        
    }
    
    _lable_text1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
    _lable_text1.numberOfLines = 0;
    _lable_text1.font = [UIFont systemFontOfSize:16];
    [self.Refun_View addSubview:self.lable_text1];
    [self.lable_text1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(90);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    _lable_text2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
    _lable_text2.numberOfLines = 0;
    _lable_text2.font = [UIFont systemFontOfSize:16];
    [self.Refun_View addSubview:self.lable_text2];
    [self.lable_text2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable_text1.mas_bottom).offset(0);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    _lable_text3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
    _lable_text3.numberOfLines = 0;
    _lable_text3.font = [UIFont systemFontOfSize:16];
    [self.Refun_View addSubview:self.lable_text3];
    [self.lable_text3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable_text2.mas_bottom).offset(0);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(30);
    }];
    
    
    
    
    _lable_text4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-44, 30)];
    _lable_text4.numberOfLines = 0;
    _lable_text4.font = [UIFont systemFontOfSize:15];
    _lable_text4.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
    [self.Refun_View addSubview:self.lable_text4];
    [self.lable_text4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable_text3.mas_bottom).offset(15);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
        make.height.mas_equalTo(30);
        
        
    }];
    
#pragma mark - 赋值
    self.lable_text1.text = [NSString stringWithFormat:@"%@",Data[@"order"]];
    self.lable_text2.text = [NSString stringWithFormat:@"%@",Data[@"Pra"]];
    self.lable_text3.text = [NSString stringWithFormat:@"%@",Data[@"Time"]];
    self.lable_text4.text = [NSString stringWithFormat:@"%@",Data[@"Goods"]];
    
    
    /*剩余：*/
    UILabel *label_shenyu = [[UILabel alloc] init];
    label_shenyu.frame = CGRectMake(22,240,114.5,24);
    label_shenyu.numberOfLines = 0;
    label_shenyu.textAlignment = 1;
    label_shenyu.font = [UIFont systemFontOfSize:14];
    label_shenyu.textColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
    label_shenyu.text = @"剩余：22:40:36";
    label_shenyu.layer.cornerRadius = 12;
    label_shenyu.layer.borderWidth = 1;
    label_shenyu.layer.borderColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0].CGColor;
    [self.Refun_View addSubview:label_shenyu];
    [label_shenyu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lable_text4.mas_bottom).offset(41);
        make.left.mas_equalTo(22);
        make.size.mas_equalTo(CGSizeMake(115, 24));
    }];
    
    
    /*查看详情*/
    FL_Button *DetaButton = [FL_Button buttonWithType:UIButtonTypeCustom];
    [DetaButton setTitle:@"查看详情" forState:UIControlStateNormal];
    [DetaButton setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [DetaButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    DetaButton.titleLabel.font = [UIFont systemFontOfSize:15];
    DetaButton.layer.cornerRadius = 10;
    DetaButton.status = FLAlignmentStatusRight;
    DetaButton.fl_padding = 10;
    [self.Refun_View addSubview:DetaButton];
    [DetaButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(200);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(44);
    }];
    
    
    /*正在申请退款，是否确认退款。*/
    UILabel *label_tisi = [[UILabel alloc] init];
    label_tisi.frame = CGRectMake(23,label_shenyu.bottom+30,self.Refun_View.width-46,15);
    label_tisi.numberOfLines = 0;
    label_tisi.text = @"正在申请退款，是否确认退款。";
    label_tisi.font = [UIFont systemFontOfSize:15];
    [self.Refun_View addSubview:label_tisi];
    [label_tisi mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_shenyu.mas_bottom).offset(30);
        make.left.mas_equalTo(22);
        make.right.mas_equalTo(-22);
    }];
    
    /*确定退款*/
    UIButton *refunButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [refunButton setTitle:@"确定退款" forState:UIControlStateNormal];
    [refunButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    refunButton.titleLabel.font = [UIFont systemFontOfSize:18];
    refunButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:105/255.0 blue:105/255.0 alpha:1.0];
    refunButton.layer.cornerRadius = 10;
    [self.Refun_View addSubview:refunButton];
    [refunButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
        make.left.mas_equalTo(30);
        make.right.mas_equalTo(-30);
        make.height.mas_equalTo(44);
    }];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.top.equalTo(self.Refun_View.mas_bottom).offset(5);
        make.width.height.mas_offset(50);
    }];
}
-(void)BtnAction{
    [self removeFromSuperview];
}
-(void)valueChanged:(UIPageControl * )control{
    int page = control.currentPage;
    CGFloat offSetX = page*_RScrollView.frame.size.width;
    [UIView beginAnimations:nil context:nil];
    _RScrollView.contentOffset=CGPointMake(offSetX, 0);
    [UIView commitAnimations];
    
}
#pragma mark -ScrollView 减速完毕调用
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    int pageNo= scrollView.contentOffset.x/scrollView.frame.size.width;
    _pageControl.currentPage = pageNo;
}
#pragma mark - 查看全部退款订单
-(void)OrderAction{
    [self removeFromSuperview];
    if (self.delagate && [self.delagate respondsToSelector:@selector(LookOrder)]) {
        [self.delagate LookOrder];
    }
}
#pragma mark - 懒加载
-(UIScrollView *)RScrollView{
    if (!_RScrollView) {
        _RScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _RScrollView.backgroundColor = [UIColor clearColor];
        _RScrollView.contentSize = CGSizeMake(ScreenW*3, ScreenH);
        _RScrollView.pagingEnabled = YES;
        _RScrollView.delegate = self;
    }
    return _RScrollView;
}
-(UIPageControl *)pageControl{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, 22, [UIScreen mainScreen].bounds.size.width, 40)];
        //设置小白点的个数
        _pageControl.numberOfPages = 3;
        //设置当前选中的点
        _pageControl.currentPage = 0;
        // 设置当前选中的小白点的颜色
        _pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
        //设置未选中小白点的颜色
        _pageControl.pageIndicatorTintColor = UIColorFromRGB(0x999999);
        [_pageControl addTarget:self action:@selector(valueChanged:) forControlEvents:(UIControlEventValueChanged)];
    }
    return _pageControl;
}
//-(UIView *)Refun_View{
//    if (!_Refun_View) {
//        _Refun_View = [[UIView alloc]initWithFrame:CGRectMake(15, 64, ScreenW-30,  500)];
//        _Refun_View.backgroundColor = [UIColor whiteColor];
//        _Refun_View.layer.cornerRadius = 6;
//        _Refun_View.clipsToBounds = YES;
//    }
//    return _Refun_View;
//}
//-(UILabel *)lable_text1{
//    if (!_lable_text1) {
//        _lable_text1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
//        _lable_text1.numberOfLines = 0;
//        _lable_text1.font = [UIFont systemFontOfSize:16];
//    }
//    return _lable_text1;
//}
//-(UILabel *)lable_text2{
//    if (!_lable_text2) {
//        _lable_text2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
//        _lable_text2.numberOfLines = 0;
//        _lable_text2.font = [UIFont systemFontOfSize:16];
//    }
//    return _lable_text2;
//}
//-(UILabel *)lable_text3{
//    if (!_lable_text3) {
//        _lable_text3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-90, 30)];
//        _lable_text3.numberOfLines = 0;
//        _lable_text3.font = [UIFont systemFontOfSize:16];
//    }
//    return _lable_text3;
//}
//-(UILabel *)lable_text4{
//    if (!_lable_text4) {
//        _lable_text4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.Refun_View.width-44, 30)];
//        _lable_text4.numberOfLines = 0;
//        _lable_text4.font = [UIFont systemFontOfSize:15];
//        _lable_text4.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
//    }
//    return _lable_text4;
//}
@end
