//
//  FBHJoinInTController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHJoinInTController.h"

@interface FBHJoinInTController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)JoinInViewT * scrollView;
@property (strong,nonatomic)UIView * BaseView;
/*输入框*/
@property (strong,nonatomic)UITextField * nameField;
@property (strong,nonatomic)UITextField * mobileField;
@property (strong,nonatomic)UITextField * emailField;
@property (strong,nonatomic)UITextField * addressField;
@end

@implementation FBHJoinInTController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];


}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"加盟代理-提交";
    

   
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.BaseView];
    
    
#pragma mark - 提示
    NSArray *LabelArr = @[@"联系人",@"联系电话",@"联系邮箱",@"电铺地址"];
    for (int i =0; i<3; i++) {
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(20, 71+72*i, self.BaseView.width-40, 1)];
        line.backgroundColor = UIColorFromRGB(0xEAEAEA);
        [self.BaseView addSubview:line];
        
    }
    for (int i = 0; i<LabelArr.count; i++) {
        UILabel *lablel = [[UILabel alloc]initWithFrame:CGRectMake(20, 20+i*72, 200, 12)];
        lablel.text = LabelArr[i];
        lablel.textColor = UIColorFromRGB(0x999999);
        lablel.font = [UIFont systemFontOfSize:12];
        [self.BaseView addSubview:lablel];

    }
    
#pragma mark - 输入
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(20, 50, self.BaseView.width-45, 20)];
    self.nameField.placeholder = @"请输入您的名称";
    self.nameField.textColor = UIColorFromRGB(0x222222);
    self.nameField.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.nameField];

    
    self.mobileField = [[UITextField alloc]initWithFrame:CGRectMake(20, 50+68*1, self.BaseView.width-45, 20)];
    self.mobileField.placeholder = @"请输入您的联系电话";
    self.mobileField.textColor = UIColorFromRGB(0x222222);
    self.mobileField.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.mobileField];
    
    
    self.emailField = [[UITextField alloc]initWithFrame:CGRectMake(20, 50+68*2, self.BaseView.width-45, 20)];
    self.emailField.placeholder = @"请输入您的联系邮箱";
    self.emailField.textColor = UIColorFromRGB(0x222222);
    self.emailField.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.emailField];
    
    
    
    self.addressField = [[UITextField alloc]initWithFrame:CGRectMake(20, 50+68*3, self.BaseView.width-45, 20)];
    self.addressField.placeholder = @"请详细输入店铺详细地址";
    self.addressField.textColor = UIColorFromRGB(0x222222);
    self.addressField.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.addressField];
    
    
    /* 提交按钮*/
    UIButton *affirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    affirmButton.frame = CGRectMake(25, 345, ScreenW-50, 44);
    [affirmButton setTitle:@"确认提交" forState:UIControlStateNormal];
    [affirmButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    [affirmButton setBackgroundColor:UIColorFromRGB(0xF7AE2A)];
    affirmButton.layer.borderColor = UIColorFromRGB(0xF78A2A).CGColor;
    affirmButton.layer.cornerRadius = 10;
    affirmButton.layer.borderWidth = 1;
    affirmButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [affirmButton addTarget:self action:@selector(affirmButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.SJScrollView addSubview:affirmButton];
    
    
    
    

}
#pragma mark - 提交
-(void)affirmButtonAction{
    if (self.nameField.text==nil||self.nameField.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入您的名称"];
        return ;
    }
    if (self.mobileField.text==nil||self.mobileField.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入您的联系电话"];
        return ;
    }
    if (self.emailField.text==nil||self.emailField.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请输入您的联系邮箱"];
        return ;
    }
    if (self.addressField.text==nil||self.addressField.text.length==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请详细输入店铺详细地址"];
        return ;
    }
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"merchant_name":[NSString stringWithFormat:@"%@",self.nameField.text],
                           @"merchant_mobile":[NSString stringWithFormat:@"%@",self.mobileField.text],
                           @"merchant_email":[NSString stringWithFormat:@"%@",self.emailField.text],
                           @"store_address":[NSString stringWithFormat:@"%@",self.addressField.text]
                           };
    
    [[FBHAppViewModel shareViewModel]insert_join_agent:model.merchant_id andstore_id:model.store_id andjoinDict:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
    
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

#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 667);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}

-(JoinInViewT *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"JoinInViewT" owner:nil options:nil][0];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 667);
        YBWeakSelf
        _scrollView.joinblock = ^{
            DMTypeView *tipView = [[NSBundle mainBundle] loadNibNamed:@"DMTypeView" owner:weakSelf options:nil].lastObject;
            tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
            [weakSelf.view.window addSubview:tipView];
        };
    }
    return _scrollView;
}

-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 315)];
        _BaseView.backgroundColor = [UIColor whiteColor];
        _BaseView.layer.cornerRadius = 6;
    }
    return _BaseView;
}
@end
