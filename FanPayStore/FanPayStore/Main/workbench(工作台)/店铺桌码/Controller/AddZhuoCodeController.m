//
//  AddZhuoCodeController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/13.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "AddZhuoCodeController.h"
#import "ZhuoImageViewController.h"

@interface AddZhuoCodeController ()
@property (strong,nonatomic)UITextField * ZhuoField;
@end

@implementation AddZhuoCodeController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加店铺桌码";

    /**
     *  UI
     */
    [self createUI];
    
}
#pragma mark - UI
-(void)createUI{
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,0,250,49);
    label.numberOfLines = 0;
    label.text= @"桌号名称";
    label.font = [UIFont systemFontOfSize:15];
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    [self.view addSubview:label];
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,49,ScreenW-30,100);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];

    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(25,view.bottom+10,ScreenW-50,32.5);
    label1.numberOfLines = 0;
    label1.text= @"桌号名称可由数字，字母或者汉字组成，例：「A1」、「桌2」、「心喜阁」";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1.0];
    [self.view addSubview:label1];
    
    [view addSubview:self.ZhuoField];
    
    
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,ScreenW-30,44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [AddButton.layer addSublayer:gl];
//
//    AddButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    AddButton.layer.shadowOffset = CGSizeMake(0,4);
//    AddButton.layer.shadowOpacity = 1;
//    AddButton.layer.shadowRadius = 9;
    
    [AddButton setTitle:@"点击生成" forState:UIControlStateNormal];
    [AddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AddButton addTarget:self action:@selector(AddAction) forControlEvents:UIControlEventTouchUpInside];
    [AddButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    AddButton.backgroundColor  = UIColorFromRGB(0xF7AE2B);
    AddButton.layer.cornerRadius = 10;
    [self.view addSubview:AddButton];
    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label1.mas_bottom).offset(80);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
}
#pragma mark - 生成桌码
-(void)AddAction{

    if (self.ZhuoField.text==nil||self.ZhuoField.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入桌码"];
        return ;
    }
    if (self.ZhuoField.text.length>10) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入不多余十个文字"];
        return ;
    }
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]create_table_number_qrcode:model.merchant_id andstore_id:model.store_id andtable_number:self.ZhuoField.text Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1){
             NSDictionary *DIC=resDic[@"data"];
          //table_number_qrcode 二维码图片地址
            //table_number_qrcode_content 二维码图片内容
            
            ZhuoImageViewController *VC = [ZhuoImageViewController new];
            VC.zhuohao.text = self.ZhuoField.text;
            VC.table_number_qrcode = [NSString stringWithFormat:@"%@",DIC[@"table_number_qrcode"]];
            [self.navigationController pushViewController:VC animated:NO];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"table_number" object:@""];

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
-(UITextField *)ZhuoField{
    if (!_ZhuoField) {
        _ZhuoField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 100)];
        _ZhuoField.placeholder= @"请输入少于十个桌号名称";
        _ZhuoField.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _ZhuoField.font = [UIFont systemFontOfSize:IPHONEWIDTH(18)];
        _ZhuoField.textAlignment = 1;
    }
    return _ZhuoField;
}
@end
