//
//  PrefeSetViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PrefeSetViewController.h"
#import "prefeTimeView.h"
#import "prefeZView.h"

@interface PrefeSetViewController ()<FSCalendarDataSource,FSCalendarDelegate>
{
    NSString *_shi;
    NSString *_ge;
    NSString *_time;
    NSString *_time1;
}
@property (strong,nonatomic)UILabel * Time_label;
@property (strong,nonatomic)YYLabel * prefe_label;
/*
 弹出试图
 */
@property (strong,nonatomic)UIView * timeView;
@property (strong,nonatomic)UIView * ZView;

@property (weak, nonatomic) FSCalendar *calendar;
@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;

// The start date of the range
@property (strong, nonatomic) NSMutableDictionary *date1;

@property (strong,nonatomic)prefeTimeView *time_view ;
@property (strong,nonatomic)prefeTimeView *time_view_1 ;
@property (strong,nonatomic)prefeZView *Z_view;
@end

@implementation PrefeSetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设置特惠活动";
    
    [self createUI];
}

#pragma mark - UI
-(void)createUI{
    
    /*
     设置特惠活动，提升店铺人气
     */
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(16,20,ScreenW,16);
    label_1.numberOfLines = 0;
    label_1.text = @"设置特惠活动，提升店铺人气";
    label_1.font = [UIFont fontWithName:@"Arial-BoldMT" size: 16];
    label_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [self.view addSubview:label_1];
    
    /*
     特惠活动的折扣，不得高于6折，例「6折」、「5.2折」
     */
    UILabel *label_11 = [[UILabel alloc] init];
    label_11.frame = CGRectMake(16,label_1.bottom+10,ScreenW,16);
    label_11.numberOfLines = 0;
    label_11.text = @"特惠活动的折扣，不得高于6折，例「6折」、「5.2折」";
    label_11.font = [UIFont fontWithName:@"Arial-BoldMT" size: 12];
    label_11.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [self.view addSubview:label_11];
    
#pragma mark --------------
    
    UIView *view_Time = [[UIView alloc] init];
    view_Time.frame = CGRectMake(15,97,ScreenW-30,69);
    view_Time.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_Time.layer.cornerRadius = 5;
    [self.view addSubview:view_Time];
    UITapGestureRecognizer * tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(event:)];
    [view_Time addGestureRecognizer:tapGesture];
    
    
    
    UILabel *label_time = [[UILabel alloc] init];
    label_time.frame = CGRectMake(11,15,200,14.5);
    label_time.numberOfLines = 0;
    label_time.text = @"开始结束时间";
    label_time.font = [UIFont fontWithName:@"Arial-BoldMT" size: 15];

    [view_Time addSubview:label_time];
    
    UILabel *label_time1 = [[UILabel alloc] init];
    label_time1.frame = CGRectMake(11,label_time.bottom+10,200,14.5);
    label_time1.numberOfLines = 0;
    label_time1.text = @"选择时间";
    label_time1.font = [UIFont fontWithName:@"Arial-BoldMT" size: 12];
    label_time1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [label_time1 sizeToFit];
    [view_Time addSubview:label_time1];
    
    [view_Time addSubview:self.Time_label];
    [self.Time_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_time1.mas_right).offset(5);
        make.centerY.equalTo(label_time1.mas_centerY).offset(0);
    }];
    
#pragma mark --------------

    UIView *view_Z = [[UIView alloc] init];
    view_Z.frame = CGRectMake(15,view_Time.bottom+20,ScreenW-30,69);
    view_Z.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view_Z.layer.cornerRadius = 5;
    [self.view addSubview:view_Z];
    UITapGestureRecognizer * tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self   action:@selector(event1:)];
    [view_Z addGestureRecognizer:tapGesture1];
    
    UILabel *label_Z = [[UILabel alloc] init];
    label_Z.frame = CGRectMake(11,15,200,14.5);
    label_Z.numberOfLines = 0;
    label_Z.text = @"活动折扣";
    label_Z.font = [UIFont fontWithName:@"Arial-BoldMT" size: 15];

    [view_Z addSubview:label_Z];
    
    UILabel *label_Z1 = [[UILabel alloc] init];
    label_Z1.frame = CGRectMake(11,label_Z.bottom+10,200,14.5);
    label_Z1.numberOfLines = 0;
    label_Z1.text = @"输入折扣";
    label_Z1.font = [UIFont fontWithName:@"Arial-BoldMT" size: 12];
    label_Z1.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    [label_Z1 sizeToFit];
    [view_Z addSubview:label_Z1];
    
    [view_Z addSubview:self.prefe_label];
    [self.prefe_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label_Z1.mas_right).offset(5);
        make.centerY.equalTo(label_Z1.mas_centerY).offset(0);
    }];
    
    
    NSString *protocol = [NSString stringWithFormat:@"1.0-6.0 折"];
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:12]];
    attri_str.color = [UIColor colorWithHexString:@"3D8AFF"];
    NSRange ProRange = [protocol rangeOfString:@"折"];

    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"3D8AFF"] userInfo:nil];
    self.prefe_label.attributedText = attri_str;

    
    
    
    
    UIView *boomView = [[UIView alloc] init];
    boomView.frame = CGRectMake(0,ScreenH-59,ScreenW,59);
    boomView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:boomView];
    [boomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_offset(0);
        make.height.mas_offset(59);
    }];
    UIButton *SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SaveButton.frame = CGRectMake(15,10,ScreenW-30,40);
    SaveButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    [SaveButton setTitle:@"保存" forState:UIControlStateNormal];
    [SaveButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [SaveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    SaveButton.layer.cornerRadius = 20;
    [SaveButton addTarget:self action:@selector(SaveAction) forControlEvents:UIControlEventTouchUpInside];
    [boomView addSubview:SaveButton];
    
    
    
    
    
    
    
    if (self.Dict.count >0) {
        
        NSString *pir = [NSString stringWithFormat:@"%@",self.Dict[@"discount"]];
        if ([[MethodCommon judgeStringIsNull:pir] isEqualToString:@""]) {
            
        }else{
            NSString *protocol = [NSString stringWithFormat:@"%@ 折",pir];
            NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
            //设置字体颜色
            [attri_str setFont:[UIFont systemFontOfSize:12]];
            attri_str.color = [UIColor colorWithHexString:@"3D8AFF"];
            NSRange ProRange = [protocol rangeOfString:@"折"];
            
            [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"3D8AFF"] userInfo:nil];
            self.prefe_label.attributedText = attri_str;
            
            [self.date1 setObject:[NSString stringWithFormat:@"%@",pir] forKey:@"discount"];
        }
        
        
        NSString *time = [NSString stringWithFormat:@"%@ —— %@",self.Dict[@"begin_date"],self.Dict[@"end_date"]];
        if ([[MethodCommon judgeStringIsNull:time] isEqualToString:@""]) {
            time = @"请选择";
        }else{
            _time =  [NSString stringWithFormat:@"%@",self.Dict[@"begin_date"]];
            _time1 =  [NSString stringWithFormat:@"%@",self.Dict[@"end_date"]];

            [self.date1 setObject:_time forKey:@"begin_date"];
            [self.date1 setObject:_time1 forKey:@"end_date"];
            
        }
        self.Time_label.text = [NSString stringWithFormat:@"%@",time];
        
    }
    
}


#pragma mark - 选择时间
-(void)event:(UITapGestureRecognizer *)gesture{
   
    self.timeView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.timeView.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.56];
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.timeView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(487);
        make.left.right.bottom.mas_offset(0);
    }];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 50, ScreenW, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(50);
        make.height.mas_offset(0.5);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20,0,ScreenW-40,50);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.text = @"日期选择";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(20,line.bottom+20,ScreenW-40,14);
    label_1.numberOfLines = 0;
    label_1.textAlignment = 1;
    label_1.text = @"开始日期";
    label_1.font = [UIFont systemFontOfSize:15];
    [view addSubview:label_1];
    
    UILabel *label_11 = [[UILabel alloc] init];
    label_11.frame = CGRectMake(20,line.bottom+199,ScreenW-40,14);
    label_11.numberOfLines = 0;
    label_11.textAlignment = 1;
    label_11.text = @"结束日期";
    label_11.font = [UIFont systemFontOfSize:15];
    [view addSubview:label_11];
    
    
    self.time_view = [[prefeTimeView alloc]initWithFrame:CGRectMake(0, label_1.bottom, ScreenW, 140)];
    
    [view addSubview:self.time_view];
    
    
    self.time_view_1 = [[prefeTimeView alloc]initWithFrame:CGRectMake(0, label_11.bottom, ScreenW, 140)];
    
    [view addSubview:self.time_view_1];
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(QXAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    
    UIButton *button_QD = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_QD setTitle:@"确认" forState:UIControlStateNormal];
    [button_QD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button_QD.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    button_QD.layer.cornerRadius = 10;
    [button_QD addTarget:self action:@selector(TimesureAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_QD];
    [button_QD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(44);
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:self.timeView];

    
}
#pragma mark - 选择折扣
-(void)event1:(UITapGestureRecognizer *)gesture{
    self.ZView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    self.ZView.backgroundColor =  [[UIColor blackColor] colorWithAlphaComponent:0.56];
    
    
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.ZView addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_offset(295);
        make.left.right.bottom.mas_offset(0);
    }];
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [view addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.top.mas_offset(50);
        make.height.mas_offset(0.5);
    }];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(20,0,ScreenW-40,50);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.text = @"特惠折扣";
    label.font = [UIFont systemFontOfSize:15];
    [view addSubview:label];
    
    
    self.Z_view = [[prefeZView alloc]initWithFrame:CGRectMake(0, 50, ScreenW, 140)];
    
    [view addSubview:self.Z_view];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(QXAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(0);
        make.size.mas_offset(CGSizeMake(65, 50));
    }];
    
    UIButton *button_QD = [UIButton buttonWithType:UIButtonTypeCustom];
    [button_QD setTitle:@"确认" forState:UIControlStateNormal];
    [button_QD setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button_QD.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
    button_QD.layer.cornerRadius = 10;
    [button_QD addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:button_QD];
    [button_QD mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-15);
        make.right.mas_equalTo(-15);
        make.left.mas_equalTo(15);
        make.height.mas_equalTo(44);
    }];
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.ZView];
    
    
}

-(void)QXAction{
    [self.timeView removeFromSuperview];
    [self.ZView removeFromSuperview];

}
#pragma mark - 时间
- (void)TimesureAction{
    
    
//    NSLog(@"开始   年%@ 月： %@",self.time_view.Year,self.time_view.Month);
//    NSLog(@" 结束  年%@ 月： %@",self.time_view_1.Year,self.time_view_1.Month);

    self.Time_label.text = [NSString stringWithFormat:@"%@-%@-%@ -- %@-%@-%@",self.time_view.Year,self.time_view.Month,self.time_view.Day,self.time_view_1.Year,self.time_view_1.Month,self.time_view_1.Day];
    _time =  [NSString stringWithFormat:@"%@-%@-%@",self.time_view.Year,self.time_view.Month,self.time_view.Day];
    _time1 =  [NSString stringWithFormat:@"%@-%@-%@",self.time_view_1.Year,self.time_view_1.Month,self.time_view_1.Day];
    
    if (self.Dict.count >0){
        [self.date1 setObject:[NSString stringWithFormat:@"%@",self.Dict[@"discount"]] forKey:@"discount"];
        [self.date1 setObject:_time forKey:@"begin_date"];
        [self.date1 setObject:_time1 forKey:@"end_date"];
    }else{
        [self.date1 setObject:_time forKey:@"begin_date"];
        [self.date1 setObject:_time1 forKey:@"end_date"];
        
    }
    
    
    
    
    
    [self.timeView removeFromSuperview];

}
#pragma mark - 折扣
- (void)sureAction{
    NSInteger yearRow = [self.Z_view.yearPicker selectedRowInComponent:0]  % 10+1;
    NSInteger monthRow = [self.Z_view.monthPicker selectedRowInComponent:0] % 10;
    
    _shi = [NSString stringWithFormat:@"%.1ld",yearRow];
   
    _ge = [NSString stringWithFormat:@"%.1ld",monthRow];
    
    NSString *protocol = [NSString stringWithFormat:@"%@.%@ 折",_shi,_ge];
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:12]];
    attri_str.color = [UIColor colorWithHexString:@"3D8AFF"];
    NSRange ProRange = [protocol rangeOfString:@"折"];
    
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor colorWithHexString:@"3D8AFF"] userInfo:nil];
    self.prefe_label.attributedText = attri_str;
    
    if (self.Dict.count >0){
        [self.date1 setObject:[NSString stringWithFormat:@"%@.%@",_shi,_ge] forKey:@"discount"];
        [self.date1 setObject:_time forKey:@"begin_date"];
        [self.date1 setObject:_time1 forKey:@"end_date"];
    }else{
        [self.date1 setObject:[NSString stringWithFormat:@"%@.%@",_shi,_ge] forKey:@"discount"];
    }
    

    [self.ZView removeFromSuperview];

}
#pragma mark - 保存
-(void)SaveAction{


    
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    if (self.Dict.count >0) {
        [self.date1 setObject:self.Dict[@"preferential_id"] forKey:@"preferential_id"];
    }
    
    [[FBHAppViewModel shareViewModel]insert_update_preferential_activities:model.merchant_id andstore_id:model.store_id andbankDict:self.date1 Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"prefeSave" object:self.Dict];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"prefeSavelist" object:self.Dict];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

            [self.navigationController popViewControllerAnimated:YES];
            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
    
    
    
    
}

#pragma mark - 懒加载
-(YYLabel *)prefe_label{
    if (!_prefe_label) {
        _prefe_label = [[YYLabel alloc]initWithFrame:CGRectMake(0, 46, 200, 38)];
        _prefe_label.font = [UIFont systemFontOfSize:12];
        _prefe_label.textColor = [UIColor colorWithHexString:@"3D8AFF"];
    }
    return _prefe_label;
}
-(UILabel *)Time_label{
    if (!_Time_label) {
        _Time_label = [[UILabel alloc]initWithFrame:CGRectMake(10, 46, 200, 38)];
        _Time_label.font = [UIFont systemFontOfSize:12];
        _Time_label.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Time_label.text = @"请选择";
    }
    return _Time_label;
}
-(NSMutableDictionary *)Dict{
    if (!_Dict) {
        _Dict = [NSMutableDictionary dictionary];
    }
    return _Dict;
}
-(NSMutableDictionary *)date1{
    if (!_date1) {
        _date1 = [NSMutableDictionary dictionary];
    }
    return _date1;
}
@end
