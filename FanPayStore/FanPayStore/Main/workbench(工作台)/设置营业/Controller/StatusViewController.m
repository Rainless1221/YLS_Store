//
//  StatusViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/20.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StatusViewController.h"

@interface StatusViewController ()
@property (strong,nonatomic)UIButton * status_button1;
@property (strong,nonatomic)UIButton * status_button2;
@property (strong,nonatomic)UILabel * status;
@end

@implementation StatusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"营业状态";
    [self createUI];
    
    
    
}
#pragma mark - UI
-(void)createUI{
    
    UIView *Statusview = [[UIView alloc] init];
    Statusview.frame = CGRectMake(15,15,ScreenW-30,autoScaleW(238));
    Statusview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    Statusview.layer.cornerRadius = 5;
    
    [self.view addSubview:Statusview];
    
    UIImageView *Status_image = [[UIImageView alloc] init];
    Status_image.frame = CGRectMake(Statusview.width/2-autoScaleW(80),20,autoScaleW(160),autoScaleW(160));
    Status_image.image = [UIImage imageNamed:@"icn_store_medium"];
    [Statusview addSubview:Status_image];
    
#pragma mark - 营业状态
    UILabel *type_label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 20)];
    type_label.text = @"营业状态";
    [Statusview addSubview:type_label];
    [type_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-21);
        make.left.mas_offset(autoScaleW(107));
        make.size.mas_offset(CGSizeMake(70, 20));
    }];
    
    [Statusview addSubview:self.status];
    [self.status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(type_label.mas_centerY).offset(0);
        make.left.equalTo(type_label.mas_right).offset(12);
        make.size.mas_offset(CGSizeMake(50, 20));
    }];
    
    
    #pragma mark - 温馨提醒
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15.5,Statusview.bottom+20,120,18);
    label_1.numberOfLines = 0;
    [self.view addSubview:label_1];
    
    NSMutableAttributedString *string_1 = [[NSMutableAttributedString alloc] initWithString:@"温馨提醒" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:20],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    label_1.attributedText = string_1;
    
    UIView *view_yuan1 = [[UIView alloc] init];
    view_yuan1.frame = CGRectMake(16,label_1.bottom+25,6,5);
    view_yuan1.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    view_yuan1.layer.cornerRadius = 2;
    [self.view addSubview:view_yuan1];

    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(view_yuan1.right+10,label_1.bottom+20,120,13.5);
    label_2.numberOfLines = 0;
    [self.view addSubview:label_2];
    
    NSMutableAttributedString *string_2 = [[NSMutableAttributedString alloc] initWithString:@"营业状态" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_2.attributedText = string_2;
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(label_2.left,label_2.bottom+10,ScreenW-50,32.5);
    label_3.numberOfLines = 0;
    [self.view addSubview:label_3];
    
    NSMutableAttributedString *string_3 = [[NSMutableAttributedString alloc] initWithString:@"商家用户可以设置店铺的营业状态，默认是营业中，设置为打样中，则不再接受用户消费" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label_3.attributedText = string_3;
    
    
    UIView *view_yuan2 = [[UIView alloc] init];
    view_yuan2.frame = CGRectMake(16,view_yuan1.bottom+71,6,5);
    view_yuan2.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    view_yuan2.layer.cornerRadius = 2;
    [self.view addSubview:view_yuan2];
    UILabel *label_4 = [[UILabel alloc] init];
    label_4.frame = CGRectMake(view_yuan1.right+10,label_3.bottom+20,150,13.5);
    label_4.numberOfLines = 0;
    [self.view addSubview:label_4];
    
    NSMutableAttributedString *string_4 = [[NSMutableAttributedString alloc] initWithString:@"店铺是否可见" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:15],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label_4.attributedText = string_4;
    
    
    UILabel *label_5 = [[UILabel alloc] init];
    label_5.frame = CGRectMake(label_2.left,label_4.bottom+10,ScreenW-50,32.5);
    label_5.numberOfLines = 0;
    [self.view addSubview:label_5];
    
    NSMutableAttributedString *string_5 = [[NSMutableAttributedString alloc] initWithString:@"店铺设置为打样中，在用户端依然可以被搜索、浏览，但是不可下单" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label_5.attributedText = string_5;
    
#pragma mark - 设置营业
    self.status_button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.status_button2.layer.cornerRadius = 15;
    self.status_button2.layer.borderWidth = 1;
    self.status_button2.layer.borderColor = UIColorFromRGB(0xD03B34).CGColor;
    [self.status_button2 setTitle:@"取消打烊" forState:UIControlStateNormal];
    self.status_button2.backgroundColor = UIColorFromRGB(0xFF6765);
    
    [self.status_button2.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.status_button2 addTarget:self action:@selector(status_Action2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.status_button2];
    [self.status_button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-15, 44));
        make.bottom.mas_offset(-40);
    }];
    
    
    
    self.status_button1 = [UIButton buttonWithType:UIButtonTypeCustom];
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW-15,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [self.status_button1.layer addSublayer:gl];
    
    self.status_button1.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    self.status_button1.layer.shadowOffset = CGSizeMake(0,4);
    self.status_button1.layer.shadowOpacity = 1;
    self.status_button1.layer.shadowRadius = 9;
    
    [self.status_button1 setTitle:@"设置打烊" forState:UIControlStateNormal];
    [self.status_button1 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.status_button1 addTarget:self action:@selector(status_Action) forControlEvents:UIControlEventTouchUpInside];
    [self.status_button1.titleLabel setFont:[UIFont systemFontOfSize:18]];
    [self.view addSubview:self.status_button1];
    [self.status_button1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(ScreenW-15, 44));
        make.bottom.mas_offset(-40);
    }];
    
    
    
    
    if ([self.statusType isEqualToString:@"1"]) {
        /*打烊中*/
        self.status_button1.hidden = YES;
        self.status_button2.hidden = NO;
        
        
        
        self.status.text = @"打烊中";
        self.status.textColor = UIColorFromRGB(0xFF6969);
        self.status.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
        self.status.backgroundColor = UIColorFromRGB(0xFFE7E4);
        
        
    }else{
        self.status_button2.hidden = YES;
        self.status_button1.hidden = NO;
        
        self.status.text = @"营业中";
        self.status.textColor = UIColorFromRGB(0x3D8AFF);
        self.status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        self.status.backgroundColor = UIColorFromRGB(0xE5F4FF);
        
        
    }
    
}

-(void)status_Action{
    
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"状态修改提醒";
    [samView.deleteButton setTitle:@"确定" forState:UIControlStateNormal];
    NSString *card_number = [NSString stringWithFormat:@"确定要将店铺的营业状态修改为“打烊中”吗？"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"状态修改中..."];
        [self Setstatus:2];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
    
}
-(void)status_Action2{
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"状态修改提醒";
    [samView.deleteButton setTitle:@"确定" forState:UIControlStateNormal];
    NSString *card_number = [NSString stringWithFormat:@"确定要将店铺的营业状态修改为“营业中”吗？"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"状态修改中..."];
        [self Setstatus:1];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
}
#pragma mark -设置店铺状态
- (void)Setstatus:(NSInteger)statusType{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel] set_store_status:model.merchant_id andstore_id:model.store_id andstore_status:[NSString stringWithFormat:@"%ld",(long)statusType] Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            NSString *storeString = [NSString stringWithFormat:@"%@",DIC[@"store_status"]];
            
            
            if ([storeString isEqualToString:@"2"]) {
                self.status.text = @"打烊中";
                self.status.textColor = UIColorFromRGB(0xFF6969);
                self.status.layer.borderColor = UIColorFromRGB(0xFF6969).CGColor;
                self.status.backgroundColor = UIColorFromRGB(0xFFE7E4);

                self.status_button1.hidden = YES;
                self.status_button2.hidden = NO;
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StatusView" object:@"2"];
            }else if([storeString isEqualToString:@"1"]){
                self.status.text = @"营业中";
                self.status.textColor = UIColorFromRGB(0x3D8AFF);
                self.status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
                self.status.backgroundColor = UIColorFromRGB(0xE5F4FF);

                self.status_button2.hidden = YES;
                self.status_button1.hidden = NO;
                [[NSNotificationCenter defaultCenter] postNotificationName:@"StatusView" object:@"1"];
            }
            
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
-(UILabel *)status{
    if (!_status) {
        _status = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        _status.backgroundColor = UIColorFromRGB(0xE5F4FF);
        _status.font = [UIFont systemFontOfSize:12];
        _status.textColor = UIColorFromRGB(0x3D8AFF);
        _status.layer.borderWidth= 1;
        _status.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        _status.textAlignment = 1;
        _status.layer.cornerRadius = 10;
        _status.layer.masksToBounds = YES;
        _status.text = @"营业中";
    }
    return _status;
}
@end
