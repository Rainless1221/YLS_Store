//
//  DetailsQTView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  订单信息——其他信息

#import "DetailsQTView.h"

@implementation DetailsQTView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.clipsToBounds=YES;
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(11,0,120,60);
    label.numberOfLines = 0;
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size: 18];
    label.text = @"其他信息";
    [self addSubview:label];
    
    UIImageView *iocn = [[UIImageView alloc]init];
    iocn.image = [UIImage imageNamed:@"input_arrow_right_deepgray"];
    [self addSubview:iocn];
    [iocn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(label.mas_centerY).offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 9.9));
    }];
    UIView *view_line_1 = [[UIView alloc] init];
    view_line_1.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_1];
    [view_line_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(60);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    NSInteger lineW = (ScreenW-50)/9;
    for (int i=0; i<=lineW; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
        line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
        [view_line_1 addSubview:line];
    }
    
    UIView *view_1 = [[UIView alloc] init];
    view_1.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_1.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2].CGColor;
    view_1.layer.shadowOffset = CGSizeMake(0,0);
    view_1.layer.shadowOpacity = 1;
    view_1.layer.shadowRadius = 2;
    view_1.layer.cornerRadius = 5;
    [self addSubview:view_1];
    [view_1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view_line_1.mas_centerY).offset(0);
        make.left.mas_offset(-5);
        make.size.mas_offset(CGSizeMake(10, 9));
    }];
    UIView *view_11 = [[UIView alloc] init];
    view_11.backgroundColor = UIColorFromRGB(0xF6F6F6);
    view_11.layer.shadowColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.22].CGColor;
    view_11.layer.shadowOffset = CGSizeMake(0,0);
    view_11.layer.shadowOpacity = 1;
    view_11.layer.shadowRadius = 2;
    view_11.layer.cornerRadius = 5;
    [self addSubview:view_11];
    [view_11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view_line_1.mas_centerY).offset(0);
        make.right.mas_offset(5);
        make.size.mas_offset(CGSizeMake(10, 9));
    }];
    
//    NSArray *Array = @[@"消费地址",@"用户信息",@"入住人数",@"订单编号",@"订单时间",@"支付时间",@"支付方式"];
//    for (int i = 0; i<Array.count; i++) {
//
//        UILabel *label = [[UILabel alloc] init];
//        label.frame = CGRectMake(0,80+i*28,90,13);
//        label.numberOfLines = 0;
//        label.font = [UIFont fontWithName:@"American Typewriter" size: 14];
//        label.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
//        label.text = [NSString stringWithFormat:@"%@",Array[i]];
//        label.textAlignment = 1;
//        [self addSubview:label];
//
//    }

    
    UILabel *label_address = [[UILabel alloc] init];
    label_address.frame = CGRectMake(0,80,90,13);
    label_address.numberOfLines = 0;
    label_address.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_address.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_address.text = @"消费地址";
    label_address.textAlignment = 0;
    [self addSubview:label_address];
    [label_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(80);
        make.left.mas_offset(10);
        make.width.mas_offset(90);
    }];
    [self addSubview:self.store_address];
    [self.store_address mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(80);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
    UILabel *label_user_info = [[UILabel alloc] init];
    label_user_info.frame = CGRectMake(0,self.store_address.bottom + 15,90,13);
    label_user_info.numberOfLines = 0;
    label_user_info.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_user_info.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_user_info.text = @"用户信息";
    label_user_info.textAlignment = 0;
    [self addSubview:label_user_info];
    [label_user_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.store_address.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.width.mas_offset(90);
    }];
    
    [self addSubview:self.user_info];
    [self.user_info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_user_info.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
    UILabel *label_user_info_ren = [[UILabel alloc] init];
    label_user_info_ren.frame = CGRectMake(0,self.user_info.bottom + 15,90,13);
    label_user_info_ren.numberOfLines = 0;
    label_user_info_ren.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_user_info_ren.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_user_info_ren.text = @"人数      ";
    label_user_info_ren.textAlignment = 0;
    [self addSubview:label_user_info_ren];
    [label_user_info_ren mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.user_info.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.width.mas_offset(90);
    }];
    
    [self addSubview:self.people_count];
    [self.people_count mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_user_info_ren.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
    UILabel *label_user_info_zuo = [[UILabel alloc] init];
    label_user_info_zuo.frame = CGRectMake(0,label_user_info_ren.bottom + 15,90,13);
    label_user_info_zuo.numberOfLines = 0;
    label_user_info_zuo.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_user_info_zuo.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_user_info_zuo.text = @"桌号      ";
    label_user_info_zuo.textAlignment = 0;
    [self addSubview:label_user_info_zuo];
    [label_user_info_zuo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_user_info_ren.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.width.mas_offset(90);
    }];
    [self addSubview:self.table_number];
    [self.table_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_user_info_zuo.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    UILabel *label_remark = [[UILabel alloc] init];
    label_remark.frame = CGRectMake(0,label_user_info_zuo.bottom + 15,90,13);
    label_remark.numberOfLines = 0;
    label_remark.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_remark.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_remark.text = @"订单备注";
    label_remark.textAlignment = 0;
    [self addSubview:label_remark];
    [label_remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_user_info_zuo.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.remark];
    [self.remark mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_remark.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    UILabel *label_order_sn  = [[UILabel alloc] init];
    label_order_sn.frame = CGRectMake(0,self.remark.bottom + 40,90,13);
    label_order_sn.numberOfLines = 0;
    label_order_sn.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_order_sn.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_order_sn.text = @"订单编号";
    label_order_sn.textAlignment = 0;
    [self addSubview:label_order_sn];
    [label_order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.remark.mas_bottom).offset(40);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.order_sn];
    [self.order_sn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_order_sn.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
    
    UILabel *label_add_time  = [[UILabel alloc] init];
    label_add_time.frame = CGRectMake(0,self.order_sn.bottom + 15,90,13);
    label_add_time.numberOfLines = 0;
    label_add_time.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_add_time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_add_time.text = @"订单时间";
    label_add_time.textAlignment = 0;
    [self addSubview:label_add_time];
    [label_add_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_order_sn.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.add_time];
    [self.add_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_add_time.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    UILabel *label_paid_time  = [[UILabel alloc] init];
    label_paid_time.frame = CGRectMake(0,self.add_time.bottom + 15,90,13);
    label_paid_time.numberOfLines = 0;
    label_paid_time.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_paid_time.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_paid_time.text = @"支付时间";
    label_paid_time.textAlignment = 0;
    [self addSubview:label_paid_time];
    [label_paid_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_add_time.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.paid_time];
    [self.paid_time mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_paid_time.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
    UILabel *label_paid_type  = [[UILabel alloc] init];
    label_paid_type.frame = CGRectMake(0,self.paid_time.bottom + 15,90,13);
    label_paid_type.numberOfLines = 0;
    label_paid_type.font = [UIFont fontWithName:@"American Typewriter" size: 14];
    label_paid_type.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_paid_type.text = @"支付方式";
    label_paid_type.textAlignment = 0;
    [self addSubview:label_paid_type];
    [label_paid_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_paid_time.mas_bottom).offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(90, 13));
    }];
    
    [self addSubview:self.paid_type];
    [self.paid_type mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label_paid_type.mas_top).offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
    }];
    
    
#pragma mark - 联系按钮
    UIView *view_line_2 = [[UIView alloc] init];
    view_line_2.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self addSubview:view_line_2];
    [view_line_2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-40);
        make.left.mas_offset(@(10));
        make.right.mas_offset(@(-10));
        make.height.mas_equalTo(0.5);
    }];
    for (int i=0; i<=lineW; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(i*9+9, 0, 5, 0.5)];
        line.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.7);
        [view_line_2 addSubview:line];
    }
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [phoneButton setTitle:@"   致电用户" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [phoneButton setImage:[UIImage imageNamed:@"icn_reply_hotline_black"] forState:UIControlStateNormal];
    phoneButton.backgroundColor = UIColorFromRGBA(0xFAFAFA, 0.7);
    phoneButton.titleLabel.font = [UIFont systemFontOfSize:IPHONEHIGHT(14)];
    [phoneButton addTarget:self action:@selector(labelTouchUpInside) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:phoneButton];
    [phoneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(39);
    }];
    
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    /**拨打电话*/
    NSString * mobile= [NSString stringWithFormat:@"%@",Data[@"user_info"][@"mobile"]];
    if ([[MethodCommon judgeStringIsNull:mobile] isEqualToString:@""]) {
        _Phone = @"";
    }
    _Phone = mobile;
    
    NSString *address = [NSString stringWithFormat:@"%@",Data[@"store_address"]];
    if ([[MethodCommon judgeStringIsNull:address] isEqualToString:@""]) {
        
    }else{
        self.store_address.text = address;
    }
    
    
    
    NSString *phon = [NSString stringWithFormat:@"%@",Data[@"user_info"][@"mobile2"]];
    if ([[MethodCommon judgeStringIsNull:phon] isEqualToString:@""]) {
        
    }else{
//        NSString *string =[phon stringByReplacingOccurrencesOfString:[phon substringWithRange:NSMakeRange(3,4)]withString:@"****"];
        self.user_info.text = [NSString stringWithFormat:@"%@(%@)  %@",Data[@"user_info"][@"user_name"],Data[@"user_info"][@"sex"],phon];
    }
    
    
    NSString *people_count = [NSString stringWithFormat:@"%@",Data[@"people_count"]];
    
    if ([[MethodCommon judgeStringIsNull:people_count] isEqualToString:@""]) {
        
    }else{
        self.people_count.text = [NSString stringWithFormat:@"%@人",people_count];
        
    }
    
    
    NSString *remark = [NSString stringWithFormat:@"%@",Data[@"remark"]];
    if ([[MethodCommon judgeStringIsNull:remark] isEqualToString:@""]) {
        
    }else{
        self.remark.text = [NSString stringWithFormat:@"%@",remark];

    }
    
    NSString *table_number = [NSString stringWithFormat:@"%@",Data[@"table_number"]];

    if ([[MethodCommon judgeStringIsNull:table_number] isEqualToString:@""]) {
        
    }else{
        self.table_number.text = [NSString stringWithFormat:@"%@",table_number];
        
    }
    
    
    
    
    
    NSString *order_sn=[NSString stringWithFormat:@"%@",Data[@"order_sn"]];
    if ([[MethodCommon judgeStringIsNull:order_sn] isEqualToString:@""]) {
        
    }else{
        self.order_sn.text = order_sn;

    }
    
    
    NSString *add_time=[NSString stringWithFormat:@"%@",Data[@"add_time"]];
    if ([[MethodCommon judgeStringIsNull:add_time] isEqualToString:@""]) {
        
    }else{
        self.add_time.text = add_time;

    }
    
    
    NSString *paid_time=[NSString stringWithFormat:@"%@",Data[@"paid_time"]];
    if ([[MethodCommon judgeStringIsNull:paid_time] isEqualToString:@""]) {
        
    }else{
        self.paid_time.text = paid_time;

    }
    
    
    
    NSString *pid = [NSString stringWithFormat:@"%@",Data[@"paid_type"]];
    if ([pid isEqualToString:@"4"]) {
        self.paid_type.text = @"余额支付";
        
    }else if ([pid isEqualToString:@"1"]){
        self.paid_type.text = @"支付宝支付";
        
    }else if ([pid isEqualToString:@"2"]){
        self.paid_type.text = @"微信支付";
        
    }else if ([pid isEqualToString:@"3"]){
        self.paid_type.text = @"银行卡快捷支付";
        
    }else{
        self.paid_type.text = @"";

    }
   
}
#pragma mark - 拨打电话
//-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
-(void) labelTouchUpInside{
//    UILabel *label=(UILabel*)recognizer.view;
//    NSLog(@"%@拨打电话",label.text);
    NSMutableString* str = [[NSMutableString alloc] initWithFormat:@"tel:%@",_Phone];
    
    UIWebView * callWebview = [[UIWebView alloc] init];
    
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    
    [self addSubview:callWebview];

}
#pragma mark - 懒加载
-(UILabel *)store_address{
    if (!_store_address) {
        _store_address = [[UILabel alloc]initWithFrame:CGRectMake(90, 80, 120, 13)];
        _store_address.numberOfLines = 0;
        _store_address.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _store_address.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _store_address;
}
-(UILabel *)user_info{
    if (!_user_info) {
        _user_info = [[UILabel alloc]init];
        _user_info.numberOfLines = 0;
        _user_info.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _user_info.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
//        _user_info.userInteractionEnabled=YES;
//        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
//        [_user_info addGestureRecognizer:labelTapGestureRecognizer];
    }
    return _user_info;
}
-(UILabel *)remark{
    if (!_remark) {
        _remark = [[UILabel alloc]init];
        _remark.numberOfLines = 0;
        _remark.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _remark.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _remark;
}
-(UILabel *)table_number{
    if (!_table_number) {
        _table_number = [[UILabel alloc]init];
        _table_number.numberOfLines = 0;
        _table_number.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _table_number.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _table_number;
}
-(UILabel *)people_count{
    if (!_people_count) {
        _people_count = [[UILabel alloc]init];
        _people_count.numberOfLines = 0;
        _people_count.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _people_count.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _people_count;
}
-(UILabel *)order_sn{
    if (!_order_sn) {
        _order_sn = [[UILabel alloc]init];
        _order_sn.numberOfLines = 0;
        _order_sn.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _order_sn.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _order_sn;
}
-(UILabel *)add_time{
    if (!_add_time) {
        _add_time = [[UILabel alloc]init];
        _add_time.numberOfLines = 0;
        _add_time.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _add_time.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _add_time;
}
-(UILabel *)paid_time{
    if (!_paid_time) {
        _paid_time = [[UILabel alloc]init];
        _paid_time.numberOfLines = 0;
        _paid_time.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _paid_time.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _paid_time;
}
-(UILabel *)paid_type{
    if (!_paid_type) {
        _paid_type = [[UILabel alloc]init];
        _paid_type.numberOfLines = 0;
        _paid_type.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _paid_type.font = [UIFont fontWithName:@"Arial-BoldMT" size: 14];
    }
    return _paid_type;
}
@end
