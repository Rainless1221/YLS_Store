//
//  HotelOrderCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/15.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "HotelOrderCell.h"

@implementation HotelOrderCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    [self addSubview:self.orderView];
    [self.orderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.top.mas_offset(0);
        make.bottom.mas_offset(-15);
    }];
    
    
    
    NSInteger coun = (ScreenW - 30)/13;
    for (int i = 0; i<coun; i++) {
        UIView *view_1 = [[UIView alloc] init];
        view_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        view_1.layer.cornerRadius = 5;
        [self.orderView addSubview:view_1];
        [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.mas_offset(5);
            make.left.mas_offset(i*13+5);
            make.size.mas_offset(CGSizeMake(11, 11));
        }];
        
    }
    //状态
    [self.orderView addSubview:self.iconBtn];
    [self.iconBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.mas_offset(0);
        make.height.mas_offset(50);
    }];
    
    /*时间*/
    [self.orderView addSubview:self.TimeLabel];
    [self.TimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
        
    }];
    
    /*line*/
    UIView *line_1 = [[UIView alloc] init];
    line_1.frame = CGRectMake(10,50,self.orderView.width-20,0.5);
    line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.orderView  addSubview:line_1];
    
    
    
    
    /*名称*/

    
    /*住房信息*/

    
    
  
   
    

    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(10,line_1.bottom+91,80,13);
    label_1.numberOfLines = 0;
    label_1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_1.font = [UIFont systemFontOfSize:14];
    label_1.text = @"房费合计";
    [self.orderView addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(10,label_1.bottom+12,80,13);
    label_2.numberOfLines = 0;
    label_2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_2.font = [UIFont systemFontOfSize:14];
    label_2.text = @"早餐";
    [self.orderView addSubview:label_2];
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(10,label_2.bottom+12,80,13);
    label_3.numberOfLines = 0;
    label_3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_3.font = [UIFont systemFontOfSize:14];
    label_3.text = @"服务费用";
    [self.orderView addSubview:label_3];
    
    UILabel *label_4 = [[UILabel alloc] init];
    label_4.frame = CGRectMake(10,label_3.bottom+43,80,13);
    label_4.numberOfLines = 0;
    label_4.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_4.font = [UIFont systemFontOfSize:14];
    label_4.text = @"总计金额";
    [self.orderView addSubview:label_4];
    
    [self.orderView addSubview:self.celllabel_1];
    [self.orderView addSubview:self.celllabel_2];
    [self.orderView addSubview:self.celllabel_3];
    [self.orderView addSubview:self.celllabel_4];
    [self.celllabel_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(line_1.mas_bottom).offset(91);
        make.right.mas_offset(-10);
        make.height.mas_offset(13);
        
    }];
    [self.celllabel_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.celllabel_1.mas_bottom).offset(12);
        make.right.mas_offset(-10);
        make.height.mas_offset(13);
        
    }];
    [self.celllabel_3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.celllabel_2.mas_bottom).offset(12);
        make.right.mas_offset(-10);
        make.height.mas_offset(13);
        
    }];
    [self.celllabel_4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.celllabel_3.mas_bottom).offset(43);
        make.right.mas_offset(-10);
        make.height.mas_offset(18);
        
    }];
    
    
    
    self.TimeLabel.text = @"2019-07-06 14:30";
    self.celllabel_1.text = @"¥660";
    self.celllabel_2.text = @"¥30";
    self.celllabel_3.text = @"¥40";
    
    NSString *protocol = [NSString stringWithFormat:@"¥%@",@"730"];
    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:24]];
    [attri_str setColor:[UIColor colorWithHexString:@"222222"]];
    NSRange ProRange = [protocol rangeOfString:@"¥"];
    [attri_str setFont:[UIFont systemFontOfSize:14] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"222222"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.celllabel_4.attributedText = attri_str;
    
    
}
- (void)setStatus:(HotelOrderVieWStatus)status{
    _status = status;
    // 判断
    if (_status == HotelOrderVieWStatus_1) {
        [self bePaid];
    }
    else if (_status == HotelOrderVieWStatus_2){
        [self HavePaid];
    }
    else if (_status == HotelOrderVieWStatus_3){
        [self evaluation_1];
    }
    else if (_status == HotelOrderVieWStatus_4){
        [self evaluation];
    }
    else if (_status == HotelOrderVieWStatus_5){
        [self refund];
    }
    else if (_status == HotelOrderVieWStatus_6){
        [self cancel];
    }
    else if (_status == HotelOrderVieWStatus_7){
    }
}
#pragma mark - 待支付
-(void)bePaid{
    self.orderView.height = 332;

    [self.iconBtn setTitle:@"订单待支付" forState:UIControlStateNormal];
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*联系买家*/
    UIButton *DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DetailButton setTitle:@"联系买家" forState:UIControlStateNormal];
    [DetailButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [DetailButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
    DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DetailButton.layer.cornerRadius = 16;
    DetailButton.layer.borderWidth = 1;
    DetailButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
    [DetailButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DetailButton];
    [DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.equalTo(DeleteButton.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    /*剩余支付时间*/
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.text = @"剩余支付时间";
    label.font = [UIFont systemFontOfSize:14];
    label.textColor = UIColorFromRGB(0x3D8AFF);
    [self.orderView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.centerY.equalTo(DetailButton.mas_centerY).offset(0);
    }];
    
   
    
   
    
}
#pragma mark - 已支付
-(void)HavePaid{
    self.orderView.height = 332;

    [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
   
    
}
#pragma mark - 待评价
-(void)evaluation_1{
    self.orderView.height = 332;

    [self.iconBtn setTitle:@"订单待评价" forState:UIControlStateNormal];
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
   
    
}
#pragma mark - 评价
-(void)evaluation{

    [self.iconBtn setTitle:@"订单已评价" forState:UIControlStateNormal];
    
    
    
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    //line
    UIView *line = [[UIView alloc] init];
    line.frame = CGRectMake(10,50,self.orderView.width-20,0.5);
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.orderView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-150);
        make.height.mas_offset(0.5);
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
    UILabel *label = [[UILabel alloc]init];
    label.text = @"本次订单已评价";
    label.textColor = UIColorFromRGB(0x222222);
    label.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(line.mas_bottom).offset(20);
    }];
    //星星
    StarEvaluator *starEvaluator = [[StarEvaluator alloc] initWithFrame:CGRectMake(25, 395, 120, 30)];
    starEvaluator.delegate = self;
    [self.orderView addSubview:starEvaluator];
    self.starEvaluator = starEvaluator;
    [starEvaluator mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.top.equalTo(label.mas_bottom).offset(15);
        make.size.mas_offset(CGSizeMake(120, 30));
    }];
    self.starEvaluator.userInteractionEnabled = NO;
    self.starEvaluator.currentValue = 4;
    
    self.star = [[UILabel alloc]init];
    self.star.text = @"分";
    self.star.textColor = UIColorFromRGB(0x3D8AFF);
    self.star.font = [UIFont systemFontOfSize:15];
    [self.orderView addSubview:self.star];
    [self.star mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.top.equalTo(label.mas_bottom).offset(15);
    }];
    
}
#pragma mark - 退款
-(void)refund{
    self.orderView.height =  350+3*30;
    
    [self.iconBtn setTitle:@"订单退款" forState:UIControlStateNormal];
    
    /*确认退款*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"确认退款" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [DeleteButton setBackgroundColor:UIColorFromRGB(0xFF6969)];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0xFF6969) CGColor];
    [DeleteButton addTarget:self action:@selector(refundAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    /*拒绝*/
    UIButton *DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DetailButton setTitle:@"拒绝" forState:UIControlStateNormal];
    [DetailButton setTitleColor:UIColorFromRGB(0xFF6969) forState:UIControlStateNormal];
    DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DetailButton.layer.cornerRadius = 16;
    DetailButton.layer.borderWidth = 1;
    DetailButton.layer.borderColor = [UIColorFromRGB(0xFF6969) CGColor];
    [DetailButton addTarget:self action:@selector(RefusedAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DetailButton];
    [DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.equalTo(DeleteButton.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
    UIButton *dayinBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [dayinBtn setTitle:@" 打印订单" forState:UIControlStateNormal];
    [dayinBtn setImage:[UIImage imageNamed:@"icn_printer_blue"] forState:UIControlStateNormal];
    [dayinBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    dayinBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    dayinBtn.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [dayinBtn addTarget:self action:@selector(DayinAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:dayinBtn];
    [dayinBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(100, 32));
    }];
    
   
}
#pragma mark - 取消
-(void)cancel{
    self.orderView.height = 332;
    [self.iconBtn setTitle:@"订单已取消" forState:UIControlStateNormal];
    /*删除*/
    UIButton *DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
    [DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
    DeleteButton.layer.cornerRadius = 16;
    DeleteButton.layer.borderWidth = 1;
    DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
    [DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    [self.orderView addSubview:DeleteButton];
    [DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-25);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    
}

#pragma mark  - 赋值
-(void)setData:(NSDictionary *)Data{
    _Data = Data;

    NSArray *goods = Data[@"goods_info"];
    NSInteger  goodMen = goods.count;
    NSInteger orderV_H = 332;
    
    //1待付款 2已付款 3已评价 4已取消
    NSInteger status = [Data[@"order_status"] integerValue];
    if ( status == 1) {
        [self.iconBtn setTitle:@"订单待支付" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_to_be_paid"] forState:UIControlStateNormal];
        
    }else if (status == 2){
        [self.iconBtn setTitle:@"订单已支付" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_paid"] forState:UIControlStateNormal];
        
        
    }else if (status == 4){
        [self.iconBtn setTitle:@"订单已评价" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateNormal];
        orderV_H = 400;
        
    }else if(status == 3){
        [self.iconBtn setTitle:@"订单待评价" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_paid"] forState:UIControlStateNormal];
        
    }else{
        [self.iconBtn setTitle:@"订单已取消" forState:UIControlStateNormal];
        [self.iconBtn setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateNormal];
        orderV_H = 340;
        
    }
    //下单时间
    self.TimeLabel.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    
    
    
    
    
    
    
    
}
- (CGFloat)getCellHeight {
    return  self.orderView.bottom;
}
#pragma mark - 操作

/** 删除 */
-(void)DeleteAction{
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_order:)]) {
        [self.delagate delete_order:self.Data];
    }
    
}
/** 查看明细 */
-(void)DetailAction{
    
//    if (self.delagate && [self.delagate respondsToSelector:@selector(Delete:)]) {
//        [self.delagate Delete:self.Data];
//    }
}
/** 打印 */
-(void)DayinAction{
    
        if (self.delagate && [self.delagate respondsToSelector:@selector(printe:)]) {
            [self.delagate printe:self.Data];
        }
    
}
/*退款*/
-(void)refundAction{
    
}
/*拒绝*/
-(void)RefusedAction{
    
}
#pragma mark - 懒加载
-(UIView *)orderView{
    if (!_orderView) {
        _orderView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 429)];
        _orderView.backgroundColor = [UIColor whiteColor];
    }
    return _orderView;
}
-(UIButton *)iconBtn{
    if (!_iconBtn) {
        _iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_iconBtn setImage:[UIImage imageNamed:@"icn_order_to_be_paid"] forState:UIControlStateNormal];
        [_iconBtn setTitle:@" " forState:UIControlStateNormal];
        [_iconBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_iconBtn.titleLabel setFont:[UIFont systemFontOfSize:15]];
    }
    return _iconBtn;
}
-(UILabel *)TimeLabel{
    if (!_TimeLabel) {
        _TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(60, 0, 150, 50)];
        _TimeLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _TimeLabel.font = [UIFont systemFontOfSize:12];
        _TimeLabel.textAlignment = 2;
    }
    return _TimeLabel ;
}
//-(UILabel *)name{
//    if (!_name) {
//        _name = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, 150, 19)];
//        _name.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
//        _name.font = [UIFont systemFontOfSize:20];
//        _name.textAlignment = 0;
//    }
//    return _name ;
//}

-(UILabel *)DiseTime{
    if (!_DiseTime) {
        _DiseTime = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 150, 12)];
        _DiseTime.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _DiseTime.font = [UIFont systemFontOfSize:14];
        _DiseTime.textAlignment = 0;
    }
    return _DiseTime ;
}
-(UILabel *)celllabel_1{
    if (!_celllabel_1) {
        _celllabel_1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 150, 12)];
        _celllabel_1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _celllabel_1.font = [UIFont systemFontOfSize:14];
        _celllabel_1.textAlignment = 2;
    }
    return _celllabel_1 ;
}
-(UILabel *)celllabel_2{
    if (!_celllabel_2) {
        _celllabel_2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 150, 12)];
        _celllabel_2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _celllabel_2.font = [UIFont systemFontOfSize:14];
        _celllabel_2.textAlignment = 2;
    }
    return _celllabel_2 ;
}
-(UILabel *)celllabel_3{
    if (!_celllabel_3) {
        _celllabel_3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 104, 150, 12)];
        _celllabel_3.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
        _celllabel_3.font = [UIFont systemFontOfSize:14];
        _celllabel_3.textAlignment = 2;
    }
    return _celllabel_3 ;
}
-(YYLabel *)celllabel_4{
    if (!_celllabel_4) {
        _celllabel_4 = [[YYLabel alloc]initWithFrame:CGRectMake(10, 104, 150, 18)];
        _celllabel_4.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _celllabel_4.font = [UIFont systemFontOfSize:20];
        _celllabel_4.textAlignment = 2;
    }
    return _celllabel_4 ;
}
//-(UIButton *)DeleteButton{
//    if (!_DeleteButton) {
//        _DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_DeleteButton setTitle:@"删除" forState:UIControlStateNormal];
//        [_DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
//        _DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _DeleteButton.layer.cornerRadius = 16;
//        _DeleteButton.layer.borderWidth = 1;
//        _DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
//        [_DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _DeleteButton;
//}
//-(UIButton *)DetailButton{
//    if (!_DetailButton) {
//        _DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_DetailButton setTitle:@"查看明细" forState:UIControlStateNormal];
//        [_DetailButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
//        [_DetailButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
//        _DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
//        _DetailButton.layer.cornerRadius = 16;
//        _DetailButton.layer.borderWidth = 1;
//        _DetailButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
//        [_DetailButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _DetailButton;
//}
@end
