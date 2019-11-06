//
//  ModifyController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ModifyController.h"

@interface ModifyController ()<UIScrollViewDelegate,TZImagePickerControllerDelegate>
@property (strong,nonatomic)UIScrollView * StoreScrollView;
@property (strong,nonatomic)LawPeopleView * LawPeople;
@property (strong,nonatomic)IdentityView  * Identity;
@property (strong,nonatomic)BankView  * Bank;
@property (strong,nonatomic)AgreementView  * Agreement;
@property (strong,nonatomic)BusinessView  * Business;
@property (strong,nonatomic)AccountView  * Account;

/*提交*/
@property (strong,nonatomic)UIView * submitView;
@property (strong,nonatomic)UIButton * submitButton;

@property (strong,nonatomic)NSMutableArray * bankArr;
@property (strong,nonatomic)NSMutableArray * bankArrZ;
@property (strong,nonatomic)NSMutableArray * province;
/*图片*/
@property (strong,nonatomic)NSString * Pic_1;
@property (strong,nonatomic)NSString * Pic_2;
@property (strong,nonatomic)NSString * Pic_3;
@property (strong,nonatomic)NSString * Pic_4;
@property (strong,nonatomic)NSString * Pic_5;
@property (strong,nonatomic)NSString * Pic_6;
@property (strong,nonatomic)NSString * Pic_7;

/** 省 */
@property (nonatomic,copy) NSString *bank_province;
/** 市 */
@property (nonatomic,copy) NSString *bank_city;
@end

@implementation ModifyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.NavString;
    [self createUI];
    [self get_bank_info];
    [self get_province_and_city];
    [self get_ysepay_merchant_info];
}
#pragma mark - 请求数据
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    /*
     获取提现账户信息完成情况
     */
    
    [[FBHAppViewModel shareViewModel]get_completion_ysepay_mer_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC = resDic[@"data"];
            
           
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
}
-(void)get_bank_info{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_bank_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"bank_info"];
            [self.bankArr removeAllObjects];
            for (NSDictionary *dict in DIC) {
                NSMutableDictionary *type = [NSMutableDictionary dictionary];
                [type setValue:dict[@"bank_name"] forKey:@"category_name"];
                [self.bankArr addObject:type];
            }
        }
        
    } andfailure:^{
        
    }];
}
-(void)get_province_and_city{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_province_and_city:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"province_city_info"];
            [self.province removeAllObjects];
            for (NSDictionary *dict in DIC) {
                [self.province addObject:dict];
            }
        }
        
    } andfailure:^{
        
    }];
}
-(void)get_branch_bank{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_branch_bank:model.merchant_id andstore_id:model.store_id andprovince:self.bank_province andcity:self.bank_city andbank_name:self.Bank.bank_type.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"sub_branch_info"];
            [self.bankArrZ removeAllObjects];
            for (NSDictionary *dict in DIC) {
                NSMutableDictionary *type = [NSMutableDictionary dictionary];
                [type setValue:dict[@"sub_branch_name"] forKey:@"category_name"];
                [self.bankArrZ addObject:type];
            }
            
        }
        
    } andfailure:^{
        
    }];
}
-(void)get_ysepay_merchant_info{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_ysepay_merchant_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"][@"ys_mer_info"];
            /** 保存信息 */
            ysepayModel *model = [ysepayModel mj_objectWithKeyValues:DIC];
            [model saveUserData];
            
            
        }
    } andfailure:^{
        
    }];
}
#pragma mark - UI
-(void)createUI{
    
    ysepayModel *model = [ysepayModel getUseData];
    
    [self.view addSubview:self.StoreScrollView];
    if ([self.NavString isEqualToString:@"法人信息"]) {
        [self.StoreScrollView addSubview:self.LawPeople];
        self.LawPeople.Data = model;
    }else if ([self.NavString isEqualToString:@"身份证信息"]){
        [self.StoreScrollView addSubview:self.Identity];
        self.Identity.Data = model;


    }else if ([self.NavString isEqualToString:@"银行卡信息"]){
        [self.StoreScrollView addSubview:self.Bank];
        self.Bank.Data = model;
        self.bank_province = model.bank_province;
        self.bank_city = model.bank_city;

        [self get_branch_bank];
    }else if ([self.NavString isEqualToString:@"客户协议书"]){
        [self.StoreScrollView addSubview:self.Agreement];
        self.Agreement.Data = model;


    }else if ([self.NavString isEqualToString:@"营业执照"]){
        [self.StoreScrollView addSubview:self.Business];
        self.Business.Data = model;


    }else{
        [self.StoreScrollView addSubview:self.Account];
        self.Account.Data = model;

    }

    
    [self.view addSubview:self.submitView];
    [self.submitView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(59);
    }];
    
    [self.submitView addSubview:self.submitButton];
}

#pragma mark  - 提交修改
-(void)SubmitActiom{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    //
    NSString *bank_account_type = [NSString stringWithFormat:@"%@",self.Bank.bank_account_type.text];
    
    if ([bank_account_type isEqualToString:@"对私"]) {
        bank_account_type = @"1";
    }else if ([bank_account_type isEqualToString:@"对公"]){
        bank_account_type = @"2";
        
    }else{
        
    }
    
    
    NSString *bank_card_type = [NSString stringWithFormat:@"%@",self.Bank.bank_card_type.text];
    
    if ([bank_card_type isEqualToString:@"借记卡"]) {
        bank_card_type = @"1";
    }else if ([bank_card_type isEqualToString:@"贷记卡"]){
        bank_card_type = @"2";
    }else if ([bank_card_type isEqualToString:@"单位结算卡"]){
        bank_card_type = @"3";
    }else{
        
    }
    
    NSDictionary *dict = @{@"cust_type":[NSString stringWithFormat:@"%ld",(long)self.cust_type],
                           @"legal_name":[NSString stringWithFormat:@"%@",self.LawPeople.legal_name.text],
                           @"legal_tel":[NSString stringWithFormat:@"%@",self.LawPeople.legal_tel.text],
                           
                           @"cert_no":[NSString stringWithFormat:@"%@",self.Identity.cert_no.text],
                           
                           @"bus_license":[NSString stringWithFormat:@"%@",self.Business.bus_license.text],
                           @"bus_license_expire":[NSString stringWithFormat:@"%@",self.Business.bus_license_expire.text],
                           
                           @"bank_account_no":[NSString stringWithFormat:@"%@",self.Bank.bank_account_no.text],
                           @"bank_account_name":[NSString stringWithFormat:@"%@",self.Bank.bank_account_name.text],
                           @"bank_name":[NSString stringWithFormat:@"%@",self.Bank.bank_name.text],
                           @"bank_type":[NSString stringWithFormat:@"%@",self.Bank.bank_type.text],
                           @"bank_telephone_no":[NSString stringWithFormat:@"%@",self.Bank.bank_telephone_no.text],
                           @"bank_account_type":[NSString stringWithFormat:@"%@",bank_account_type],
                           @"bank_card_type":[NSString stringWithFormat:@"%@",bank_card_type],
                           @"bank_province":[NSString stringWithFormat:@"%@",self.bank_province],
                           @"bank_city":[NSString stringWithFormat:@"%@",self.bank_city],
                           
                           @"ID_card_front_pic":[NSString stringWithFormat:@"%@",self.Pic_1],
                           @"ID_card_back_pic":[NSString stringWithFormat:@"%@",self.Pic_2],
                           @"bank_card_front_pic":[NSString stringWithFormat:@"%@",self.Pic_3],
                           @"bank_card_back_pic":[NSString stringWithFormat:@"%@",self.Pic_4],
                           @"customer_agreement_pic":[NSString stringWithFormat:@"%@",self.Pic_5],
                           @"business_license_pic":[NSString stringWithFormat:@"%@",self.Pic_6],
                           @"opening_permit_pic":[NSString stringWithFormat:@"%@",self.Pic_7]
                           };
    
    [[FBHAppViewModel shareViewModel]add_ysepay_merchant_info:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            //            NSDictionary *DIC = resDic[@"data"];
            
            
            [self.navigationController popViewControllerAnimated:YES];

            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            
        }
        [[NSNotificationCenter defaultCenter] postNotificationName:@"MoneyCer" object:@""];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"conversion" object:@""];

        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
}

- (void)ImageArr:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
//        [sender setImage:photos[0] forState:UIControlStateNormal];
        for (UIImage *image in photos) {
            [self image:image andtag:sender];
        }
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - 上传图片
-(void)image:(UIImage *)img andtag:(UIButton *)imatag{
    [[FBHAppViewModel shareViewModel]uploadImageWithData:img andtype:@"2" Success:^(NSDictionary *resDic) {
        NSString *urlstr = [[NSString alloc]init];
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            urlstr = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
            switch (imatag.tag) {
                case 1:
                    self.Pic_1 = urlstr;
                    break;
                case 2:
                    self.Pic_2 = urlstr;
                    
                    break;
                case 3:
                    self.Pic_3 = urlstr;
                    
                    break;
                case 4:
                    self.Pic_4 = urlstr;
                    
                    break;
                case 5:
                    self.Pic_5 = urlstr;
                    
                    break;
                case 6:
                    self.Pic_6 = urlstr;
                    
                    break;
                case 7:
                    self.Pic_7 = urlstr;
                    
                    break;
                default:
                    break;
            }
            [imatag setImageWithURL:[NSURL URLWithString:urlstr] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 懒加载
-(UIScrollView *)StoreScrollView{
    if (!_StoreScrollView) {
        _StoreScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-59)];
        _StoreScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _StoreScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 702);
        _StoreScrollView.delegate = self;
    }
    return _StoreScrollView;
}

-(LawPeopleView *)LawPeople{
    if (!_LawPeople) {
        _LawPeople = [[LawPeopleView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
    }
    return _LawPeople;
}
-(IdentityView *)Identity{
    if (!_Identity) {
        _Identity = [[IdentityView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
        /*选择图片*/
        _Identity.ImagePicBlock = ^(UIButton * _Nonnull Btn) {
            [self ImageArr:Btn];
        };
    }
    return _Identity;
}
-(BankView *)Bank{
    if (!_Bank) {
        _Bank = [[BankView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 611)];
        _Bank.SettypeBlock = ^(UIButton * _Nonnull btn) {
            MoetytypeView *periodV = [[MoetytypeView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
            
            if (btn.tag == 1) {
                periodV.view_H = 300;periodV.isAdds = NO;
                periodV.Navlabel.text = @"账户性质";
                NSArray *marArr = @[@{@"category_name":@"对私",@"category_id":@"1"},@{@"category_name":@"对公",@"category_id":@"2"}];
                
                for (NSDictionary *dict in marArr) {
                    [periodV.Data addObject:dict];
                }
                
                periodV.fbhtypeBlock = ^(NSString * _Nonnull type, NSString * _Nonnull sex_type, NSString * _Nonnull name, NSString * _Nonnull imag) {
                    self.Bank.bank_account_type.text = name;
                };
                
            }else if (btn.tag == 2){
                periodV.view_H = 400;periodV.isAdds = NO;
                periodV.Navlabel.text = @"银行卡类型";
                NSArray *marArr = @[@{@"category_name":@"借记卡",@"category_id":@"1"},@{@"category_name":@"贷记卡",@"category_id":@"2"},@{@"category_name":@"单位结算卡",@"category_id":@"3"}];
                
                for (NSDictionary *dict in marArr) {
                    [periodV.Data addObject:dict];
                }
                
                periodV.fbhtypeBlock = ^(NSString * _Nonnull type, NSString * _Nonnull sex_type, NSString * _Nonnull name, NSString * _Nonnull imag) {
                    self.Bank.bank_card_type.text = name;
                };
            }else if (btn.tag == 3){
                
                PickerPCView *pickerV =  [[PickerPCView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
                pickerV.Navlabel.text = @"所在城市";
                pickerV.Data = self.province;
                
                pickerV.AddressBlcok = ^(NSString * _Nonnull province, NSString * _Nonnull city) {
                    self.bank_province = province;
                    self.bank_city = city;
                    self.Bank.Field_8.text= [NSString stringWithFormat:@"%@%@",province,city];
                };
                
                [pickerV.Baseview addSubview:pickerV.pickerView];
                [[UIApplication sharedApplication].keyWindow addSubview:pickerV];

            }else if (btn.tag == 4){
                periodV.view_H = 400;periodV.isAdds = NO;
                periodV.Navlabel.text = @"所属银行";
                
                for (NSDictionary *dict in self.bankArr) {
                    [periodV.Data addObject:dict];
                }
                periodV.fbhtypeBlock = ^(NSString * _Nonnull type, NSString * _Nonnull sex_type, NSString * _Nonnull name, NSString * _Nonnull imag) {
                    self.Bank.bank_type.text = name;
                    [self get_branch_bank];
                    
                };
            }else{
                
                
                periodV.view_H = 400;periodV.isAdds = NO;
                periodV.Navlabel.text = @"开户支行";
                
                for (NSDictionary *dict in self.bankArrZ) {
                    [periodV.Data addObject:dict];
                }
                periodV.fbhtypeBlock = ^(NSString * _Nonnull type, NSString * _Nonnull sex_type, NSString * _Nonnull name, NSString * _Nonnull imag) {
                    self.Bank.bank_name.text = name;
                    self.Bank.bank_name1.text = name;

                };
                
                
            }
            
            
            
            if (btn.tag==3) {
                
            }else{
                [[UIApplication sharedApplication].keyWindow addSubview:periodV];
                
            }
            
            
        };
        
        
        /*选择图片*/
        _Bank.ImagePicBlock = ^(UIButton * _Nonnull Btn) {
            [self ImageArr:Btn];
            
        };
    }
    return _Bank;
}

-(AgreementView *)Agreement{
    if (!_Agreement) {
        _Agreement = [[AgreementView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
        /*选择图片*/
        _Agreement.ImagePicBlock = ^(UIButton * _Nonnull Btn) {
            [self ImageArr:Btn];
        };
    }
    return _Agreement;
}
-(BusinessView *)Business{
    if (!_Business) {
        _Business = [[BusinessView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
        /*选择图片*/
        _Business.ImagePicBlock = ^(UIButton * _Nonnull Btn) {
            [self ImageArr:Btn];
        };
    }
    return _Business;
}
-(AccountView *)Account{
    if (!_Account) {
        _Account = [[AccountView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 667)];
        /*选择图片*/
        _Account.ImagePicBlock = ^(UIButton * _Nonnull Btn) {
            [self ImageArr:Btn];
        };
    }
    return _Account;
}
-(UIView *)submitView{
    if (!_submitView) {
        _submitView = [[UIView alloc] init];
        _submitView.frame = CGRectMake(0,0,ScreenW,59);
        _submitView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _submitView;
}
-(UIButton *)submitButton{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.frame = CGRectMake(15, 9, self.submitView.width-30, 40);
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        [_submitButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [_submitButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
        _submitButton.layer.cornerRadius = 10;
        [_submitButton addTarget:self action:@selector(SubmitActiom) forControlEvents:UIControlEventTouchUpInside];

    }
    return _submitButton;
}
-(NSMutableArray *)bankArr{
    if (!_bankArr) {
        _bankArr = [NSMutableArray array];
    }
    return _bankArr;
}
-(NSMutableArray *)bankArrZ{
    if (!_bankArrZ) {
        _bankArrZ = [NSMutableArray array];
    }
    return _bankArrZ;
}
-(NSMutableArray *)province{
    if (!_province) {
        _province = [NSMutableArray array];
    }
    return _province;
}
@end
