//
//  FBHAllcardController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHAllcardController.h"
#import "CardWinView.h"
#import "FBHcardSaoViewController.h"//扫描添加银行卡

@interface FBHAllcardController ()<UITextFieldDelegate>
/** 手机号 **/
@property (weak, nonatomic) IBOutlet UITextField *mobile;
/** 卡号 **/
@property (weak, nonatomic) IBOutlet UITextField *card_number;
/** 类型 **/
@property (weak, nonatomic) IBOutlet UILabel *bank_name;
/** 卡主姓名 **/
@property (weak, nonatomic) IBOutlet UITextField *Name;
/** 卡主身份证号 **/
@property (weak, nonatomic) IBOutlet UITextField *IDcard_num;
/** 所属银行代号 */
@property (strong,nonatomic)NSString * Bank_value;
/** 所属银行名称 */
@property (strong,nonatomic)NSString * Bank_name1;
/** 银行卡性质 */
@property (strong,nonatomic)NSString * Bank_card_type;

@end

@implementation FBHAllcardController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
#pragma mark - 请求
-(void)merchant_center{
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
    if (self.Name.text==nil||self.Name.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入姓名"];
        return ;
    }
    if (self.mobile.text==nil||self.mobile.text.length == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入手机号码"];
        return ;
    }
   
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    NSString *number = [self.card_number.text stringByReplacingOccurrencesOfString:@" " withString:@""];

    NSDictionary *Dict = @{@"bank_name":[NSString stringWithFormat:@"%@",self.Bank_name1],
                           @"bank_code":[NSString stringWithFormat:@"%@",self.Bank_value],
                           @"card_number":[NSString stringWithFormat:@"%@",number],
                           @"card_property":[NSString stringWithFormat:@"%@",self.Bank_card_type],
                           @"mobile":[NSString stringWithFormat:@"%@",self.mobile.text],
                           @"name":[NSString stringWithFormat:@"%@",self.Name.text],
                           @"ID_card_num":[NSString stringWithFormat:@"%@",self.IDcard_num.text],
                           @"mobile_code":[NSString stringWithFormat:@"%@",self.mobile_code_string]
                           };
    
    [[FBHAppViewModel shareViewModel] insert_bank_card:model.merchant_id andbankDict:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
//            NSDictionary *DIC=resDic[@"data"];
            
            //添加成功
            CardWinView *tipView = [[NSBundle mainBundle] loadNibNamed:@"CardWinView" owner:self options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            tipView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
            YBWeakSelf
            tipView.RemoveBlock = ^{
//                [weakSelf.navigationController popViewControllerAnimated:YES ];
                FBHbankcardController *homeVC = [[FBHbankcardController alloc] init];
                UIViewController *target = nil;
                for (UIViewController * controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[homeVC class]]) {
                        target = controller;
                    }
                }
                if (target) {
                    [weakSelf.navigationController popToViewController:target animated:YES];
                }
            };
            [self.view.window addSubview:tipView];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加银行卡";
    [self createUI];
}
#pragma mark -- 银行卡类型列表
-(void)Banklist{
    UserModel *model = [UserModel getUseData];

    //需要填加选择的银行卡类型信息
    [[FBHAppViewModel shareViewModel] list_bank_info:model.merchant_id andpage:@"1" andlimit:@"15" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"bank_card_info"];
            Bank_infoModel *model=[Bank_infoModel mj_objectWithKeyValues:DIC];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 获取所属银行信息
-(void)cardToBankName:(NSString *)card_number{
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_bank_name_by_card_num:model.merchant_id andcard_number:card_number Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            /** 代号 **/
            self.Bank_value = DIC[@"bank_value"];
            /** 名称 **/
            self.Bank_name1 = DIC[@"bank_name"];
            /** 性质 **/
            self.Bank_card_type = DIC[@"bank_card_type"];
            self.bank_name.text  = [NSString stringWithFormat:@"%@ %@",DIC[@"bank_name"],DIC[@"bank_card_type"]];
            
        }else{
//            [SVProgressHUD setMinimumDismissTimeInterval:2];
//            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];

    
}
#pragma mark - UI
-(void)createUI{
    self.card_number.delegate = self;
    self.mobile.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.mobile.keyboardType= UIKeyboardTypeDecimalPad;
    self.card_number.keyboardType= UIKeyboardTypeDecimalPad;
    self.IDcard_num.keyboardType= UIKeyboardTypeDecimalPad;

}
/** 银行卡类型列表 **/
- (IBAction)BankAction:(UIButton *)sender {
    [self Banklist];
}
//扫描添加
- (IBAction)SaoAction:(id)sender {
//    [self.navigationController pushViewController:[FBHcardSaoViewController new] animated:NO];

}

//绑定银行卡
- (IBAction)BoundAction:(id)sender {
    [self merchant_center];

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
            [self cardToBankName:number];

        }else { // 比25长的话 return NO这样输入就无效了
            returnValue = NO;
        }
        
    }else { // 如果输入为空,该怎么地怎么地
        
        [newText replaceCharactersInRange:range withString:string];
        
    }
 
    return returnValue;
 

    
//    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    if (text.length >= 16) {
//        [self cardToBankName:text];
//    }
//    NSLog(@"完整的文本 ：%@",text);
//    NSLog(@"每次输入的单个文字 ：%@",string);
//    NSLog(@"textField.text 显示的会少一个文字 ：%@",textField.text);
//
//    return YES;
}

@end
