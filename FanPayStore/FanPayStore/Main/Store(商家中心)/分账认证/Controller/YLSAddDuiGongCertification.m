//
//  YLSAddDuiGongCertification.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/22.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddDuiGongCertification.h"

@interface YLSAddDuiGongCertification ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UIScrollView * BackScrollView;
@property (strong,nonatomic)UITableView * BankTableview;

/** 卡号 **/
@property (strong, nonatomic)  UITextField *card_number;
/** 类型 **/
@property (strong, nonatomic)  UIButton *bank_name;
/** 卡主身份证号 **/
@property (strong, nonatomic)  UITextField *IDcard_num;
/** 手机号 **/
@property (strong, nonatomic)  UITextField *mobile;
/** 卡主姓名 **/
@property (strong, nonatomic)  UITextField *Name;

/** 所属银行代号 */
@property (strong,nonatomic)    NSString * Bank_value;
/** 所属银行名称 */
@property (strong,nonatomic)    NSString * bank_name1;
/** 银行行号 */
@property (strong,nonatomic)    NSString * bank_code;

@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)UIView * BankView;


@end

@implementation YLSAddDuiGongCertification

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"注册对公分账账户";
    
    [self createUI];
    
    [self Bank];
}
-(void)Bank{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_xib_bank_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"bank_info"];
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC) {
                [self.Data addObject:dict];
            }
            [self.BankTableview reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
}

#pragma mark - UI
-(void)createUI{
    
    [self.view addSubview:self.BackScrollView];
    
    UIView *TFView = [[UIView alloc] init];
    TFView.frame = CGRectMake(15,15,SCREEN_WIDTH-30,252);
    TFView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    TFView.layer.cornerRadius = 5;
    [self.BackScrollView addSubview:TFView];
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(15, TFView.bottom+50, SCREEN_WIDTH-30, 44);
    [Button setTitle:@"开始认证" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    Button.backgroundColor = UIColorFromRGB(0xF7AE2B);
    Button.layer.cornerRadius = 10;
    [Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.BackScrollView addSubview:Button];
    
    /**协议*/
    YYLabel *xieyi = [[YYLabel alloc]initWithFrame:CGRectMake(15, TFView.bottom+5, 150, 45)];
    NSString *protocol = @"查看《银行卡服务协议》";
    NSMutableAttributedString *attri_str = [[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:12]];
    attri_str.color= [UIColor blackColor];
    NSRange ProRange = [protocol rangeOfString:@"《银行卡服务协议》"];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"F7AE2B"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    xieyi.attributedText = attri_str;
    xieyi.textAlignment = 1;
    xieyi.userInteractionEnabled=YES;
    UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
    [xieyi addGestureRecognizer:labelTapGestureRecognizer];
    [self.BackScrollView addSubview:xieyi];

    /*填写部分*/
    NSArray *array = @[@"对公账号",@"所属银行",@"预留手机",@"营业执照",@"公司名称"];
    for (int i=0; i<5; i++) {
        
        UIView *LineView = [[UIView alloc] init];
        LineView.frame = CGRectMake(10,50+i*51,TFView.width - 20,0.5);
        LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [TFView addSubview:LineView];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(10,50*i,90,50);
        label1.numberOfLines = 0;
        label1.font = [UIFont systemFontOfSize:15];
        label1.text = [NSString stringWithFormat:@"%@",array[i]];
        [TFView addSubview:label1];
    }
    [TFView addSubview:self.card_number];
    [TFView addSubview:self.IDcard_num];
    [TFView addSubview:self.mobile];
    [TFView addSubview:self.Name];
    [self.card_number mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.mobile mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(102);
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    [self.IDcard_num mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(153);
        make.left.mas_offset(90);
        make.right.mas_offset(-1);
        make.height.mas_offset(50);
    }];
    [self.Name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(204);
        make.left.mas_offset(90);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
    }];
    
    [TFView addSubview:self.bank_name];
    [self.bank_name mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(51);
        make.left.mas_offset(90);
        make.right.mas_offset(0);
        make.height.mas_offset(50);
    }];
    UIButton *jiantou = [UIButton buttonWithType:UIButtonTypeCustom];
    [jiantou setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    [TFView addSubview:jiantou];
    [jiantou mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.bank_name.mas_centerY).offset(0);
        make.right.mas_offset(-10);
    }];
    /**扫描银行卡*/

    UIButton *bankButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [bankButton setImage:[UIImage imageNamed:@"icn_scan_bank_card"] forState:UIControlStateNormal];
    [TFView addSubview:bankButton];
    [bankButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-10);
        make.height.mas_offset(50);
        make.width.mas_offset(30);
    }];
    
    /*选择银行卡*/
    UIView *bankView = [[UIView alloc] init];
    bankView.frame = CGRectMake(15,219.5,ScreenW,228);
    bankView.backgroundColor = [UIColor whiteColor];
    bankView.layer.cornerRadius = 6;
    [self.BankView addSubview:bankView];
    [bankView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(350);
    }];
    UIView *LineView = [[UIView alloc] init];
    LineView.frame = CGRectMake(0,50,bankView.width,0.5);
    LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [bankView addSubview:LineView];
    
    //叉号
    UIButton *queButton = [UIButton buttonWithType:UIButtonTypeCustom];
    queButton.frame = CGRectMake(0, 0, 50, 50);
    [queButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_pressed"] forState:UIControlStateNormal];
    [queButton addTarget:self action:@selector(queAction) forControlEvents:UIControlEventTouchUpInside];
    [bankView addSubview:queButton];
    
    [bankView addSubview:self.BankTableview];
    [self.BankTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(5);
        make.top.mas_offset(52);
    }];
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    UILabel *label=(UILabel*)recognizer.view;
    NSLog(@"%@被点击了",label.text);
    
}
-(void)queAction{
    [self.BankView removeFromSuperview];
    
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    BOOL returnValue = YES;
    NSMutableString* newText = [NSMutableString stringWithCapacity:0];
    [newText appendString:textField.text];// 拿到原有text,根据下面判断可能给它添加" "(空格);
    NSString * noBlankStr = [textField.text stringByReplacingOccurrencesOfString:@" "withString:@""];
    NSInteger textLength = [noBlankStr length];
    
    if (string.length) {
        if (textLength < 25) {//这个25是控制实际字符串长度,比如银行卡号长度
            if (textLength > 0 && textLength %4 == 0) {
                newText = [NSMutableString stringWithString:[newText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
                [newText appendString:@" "];
                [newText appendString:string];
                textField.text = newText;
                returnValue = NO;//为什么return NO?因为textField.text = newText;text已经被我们替换好了,那么就不需要系统帮我们添加了,如果你ruturnYES的话,你会发现会多出一个字符串
            }else {
                [newText appendString:string];
            }
            NSString *number = [newText stringByReplacingOccurrencesOfString:@" " withString:@""];
            /** 请求银行卡类型 */
            //            [self cardToBankName:number];
            
        }else { // 比25长的话 return NO这样输入就无效了
            returnValue = NO;
        }
        
    }else { // 如果输入为空,该怎么地怎么地
        
        [newText replaceCharactersInRange:range withString:string];
        
    }
    
    return returnValue;
    
}
#pragma mark - 获取所属银行信息
-(void)cardToBankName:(NSString *)card_number{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_bank_name_by_card_num:model.merchant_id andcard_number:card_number Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            /** 代号 **/
            //            self.Bank_value = DIC[@"bank_value"];
            /** 名称 **/
            //            self.Bank_name1 = DIC[@"bank_name"];
            /** 性质 **/
            //            self.Bank_card_type = DIC[@"bank_card_type"];
            //            self.bank_name.textColor = [UIColor blackColor];
            //            self.bank_name.text  = [NSString stringWithFormat:@"%@ %@",DIC[@"bank_name"],DIC[@"bank_card_type"]];
            
        }else{
            //            [SVProgressHUD setMinimumDismissTimeInterval:2];
            //            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
    
}
#pragma mark - 选择银行卡类型
-(void)BankAction{
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:self.BankView];
}
#pragma mark - 开始认证
-(void)ButtonAction{
    if (self.card_number.text==nil||self.card_number.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入卡号"];
        return ;
    }
    if (self.IDcard_num.text==nil||self.IDcard_num.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入身份证号"];
        return ;
    }
    if (self.mobile.text==nil||self.mobile.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
    if (self.Name.text==nil||self.Name.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return ;
    }
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    NSString *number = [self.card_number.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *Dict = @{@"cust_name":[NSString stringWithFormat:@"%@",self.Name.text],//公司名称
                           @"org_license":[NSString stringWithFormat:@"%@",self.IDcard_num.text],//组织机构代码 营业执照号
                           @"acct_no":[NSString stringWithFormat:@"%@",number],//企业对公账号
                           @"bank_code":[NSString stringWithFormat:@"%@",self.bank_code],//所属银行行号
                           @"mobile_no":[NSString stringWithFormat:@"%@",self.mobile.text],//企业预留经办人手机号
                           };
    YBWeakSelf
    [[FBHAppViewModel shareViewModel] exec_register_enterprise_account:model.merchant_id andstore_id:model.store_id andjoinDict:Dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            NSString *url = [NSString stringWithFormat:@"%@",DIC[@"ret_url"]];
            
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"CertifiList" object:url];
            [MBProgressHUD hideHUD];
            YLSCertifH5Controller *VC = [YLSCertifH5Controller new];
            VC.Navtitle = @"短信认证";
            VC.agreeUrl = url;
            [weakSelf.navigationController pushViewController:VC animated:NO];
//            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    } ];
    
    
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"bank_name"]];
    return cell;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 65;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    header_View.backgroundColor = UIColorFromRGB(0xF6F6F6);
    
    return header_View;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *Footer_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 0)];
    Footer_View.backgroundColor = [UIColor clearColor];
    
    return Footer_View;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self.bank_name setTitle:[NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"bank_name"]] forState:UIControlStateNormal];
    self.bank_name.selected = YES;
    [self.BankView removeFromSuperview];
    self.bank_code = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"bank_code"]];
    
}
#pragma mark - 懒加载
-(UIScrollView *)BackScrollView{
    if (!_BackScrollView) {
        _BackScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _BackScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _BackScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 667);
    }
    return _BackScrollView;
}
-(UITextField *)card_number{
    if (!_card_number) {
        _card_number = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _card_number.font = [UIFont systemFontOfSize:16];
        _card_number.textColor = [UIColor blackColor];
        _card_number.placeholder = @"请输入企业对公银行卡号";
        _card_number.delegate = self;
        _card_number.keyboardType = UIKeyboardTypePhonePad;
        
    }
    return _card_number;
}
-(UITextField *)IDcard_num{
    if (!_IDcard_num) {
        _IDcard_num = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _IDcard_num.font = [UIFont systemFontOfSize:16];
        _IDcard_num.textColor = [UIColor blackColor];
        _IDcard_num.placeholder = @"请输入组织机构代码（营业执照号）";
//        _IDcard_num.delegate = self;
        _IDcard_num.keyboardType = UIKeyboardTypePhonePad;
        
    }
    return _IDcard_num;
}
-(UITextField *)mobile{
    if (!_mobile) {
        _mobile = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _mobile.font = [UIFont systemFontOfSize:16];
        _mobile.textColor = [UIColor blackColor];
        _mobile.placeholder = @"请输入企业预留经办人手机号";
//        _mobile.delegate = self;
        _mobile.keyboardType = UIKeyboardTypePhonePad;
        
    }
    return _mobile;
}
-(UITextField *)Name{
    if (!_Name) {
        _Name = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 200, 50)];
        _Name.font = [UIFont systemFontOfSize:16];
        _Name.textColor = [UIColor blackColor];
        _Name.placeholder = @"请输入公司名称";
//        _Name.delegate = self;
    }
    return _Name;
}
-(UIButton *)bank_name{
    if (!_bank_name) {
        _bank_name = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bank_name setTitle:@"请选择对公银行卡号所属银行" forState:UIControlStateNormal] ;
        [_bank_name setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
        [_bank_name setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateSelected];
        _bank_name.titleLabel.font = [UIFont systemFontOfSize:15];
        _bank_name.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [_bank_name addTarget:self action:@selector(BankAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bank_name;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(UIView *)BankView{
    if (!_BankView) {
        _BankView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
        _BankView.backgroundColor = UIColorFromRGBA(0x000000, 0.5);
    }
    return _BankView;
}
-(UITableView *)BankTableview{
    if (!_BankTableview) {
        _BankTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _BankTableview.delegate = self;
        _BankTableview.dataSource = self;
        _BankTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _BankTableview.allowsSelectionDuringEditing = YES;
        
        [_BankTableview registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _BankTableview;
}

@end
