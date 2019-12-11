//
//  YLSHelpViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/27.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSHelpViewController.h"
#import "HelpDetailsViewController.h"

@interface YLSHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UIImageView * Backimage;
@property (strong,nonatomic)UITableView * helpTableView;
@property (strong,nonatomic)NSMutableArray  * Data;
@property (assign,nonatomic)NSInteger page;
@end

@implementation YLSHelpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"帮助与客服";
     [self createUI];
    self.page = 1;
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict = @{
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"limit":@"15"
                           };
    
    [[FBHAppViewModel shareViewModel]list_common_problem:model.merchant_id andproblem:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"][@"problem_info"];
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC) {
                [self.Data addObject:dict];
            }
            [self.helpTableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.Backimage];
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(16,28,200,15.5);
    label.numberOfLines = 0;
    label.font = [UIFont systemFontOfSize:16];
    label.text = @"Hi，这里是一鹿省帮助客服";
    label.textColor = [UIColor whiteColor];
    [self.Backimage addSubview:label];
    
    
    UILabel *label_text = [[UILabel alloc] init];
    label_text.frame = CGRectMake(16,53,ScreenW,15.5);
    label_text.numberOfLines = 0;
    label_text.font = [UIFont systemFontOfSize:12];
    label_text.text = @"选择您遇到的问题，可以为您提供快捷的解答哦。";
    label_text.textColor = [UIColor whiteColor];
    [self.Backimage addSubview:label_text];
    
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(15,164,345,357.5);
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-146);
    }];
    [view addSubview:self.helpTableView];
    [self.helpTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(50);
        make.left.mas_offset(0);
        make.right.mas_offset(-0);
        make.bottom.mas_offset(-0);
    }];
    
    UIImageView *image_icon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 32, 32)];
    image_icon.image = [UIImage imageNamed:@"icn_faq"];
    [view addSubview:image_icon];
    
    UILabel *label_icon = [[UILabel alloc] init];
    label_icon.frame = CGRectMake(60,0,100,50);
    label_icon.numberOfLines = 0;
    label_icon.text = @"常见问题";
    label_icon.font = [UIFont systemFontOfSize:15];
    [view addSubview:label_icon];
    
    
    //可否按钮
    UIButton *KF_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [KF_Button setTitle:@"在线客服" forState:UIControlStateNormal];
    [KF_Button setImage:[UIImage imageNamed:@"icn_reply_online_blue"] forState:UIControlStateNormal];
    [KF_Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    KF_Button.titleLabel.font = [UIFont systemFontOfSize:16];
    KF_Button.layer.cornerRadius = 6;
    KF_Button.layer.borderWidth = 1;
    KF_Button.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    [KF_Button addTarget:self action:@selector(onlineAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:KF_Button];
    [KF_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_bottom).offset(30);
        make.left.mas_offset(25);
        make.right.mas_offset(-25);
        make.height.mas_offset(40);
    }];
    //电话按钮
    UIButton *PH_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [PH_Button setTitle:@"400-181-9111" forState:UIControlStateNormal];
    [PH_Button setImage:[UIImage imageNamed:@"icn_reply_hotline_blue"] forState:UIControlStateNormal];
    [PH_Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    PH_Button.titleLabel.font = [UIFont systemFontOfSize:16];
    PH_Button.layer.cornerRadius = 6;
    PH_Button.layer.borderWidth = 1;
    PH_Button.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    [PH_Button addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:PH_Button];
    [PH_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(KF_Button.mas_bottom).offset(15);
        make.left.mas_offset(25);
        make.right.mas_offset(-25);
        make.height.mas_offset(40);
    }];
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HelpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HelpTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
//    cell.helpLabel.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"question"]];
    cell.Data =self.Data[indexPath.row];
    return cell;

}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *idString = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"problem_id"]];
    /**
     * 点击跳转到详情界面
     * 1、传问题ID过去
     * 2、到公共的web界面
     * 3、或者是请求后展示文本
     **/
    [self HelpDetail:idString];
    

}
#pragma mark - 问题详情
-(void)HelpDetail:(NSString *)problemID{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    //问题详情
    [[FBHAppViewModel shareViewModel]detail_common_problem:model.merchant_id andproblem_id:problemID Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {

            NSDictionary *DIC=resDic[@"data"][@"problem_info"];
            HelpDetailsViewController *VC = [HelpDetailsViewController new];
            VC.Data = DIC;
            [self.navigationController pushViewController:VC animated:YES];

        }else{

            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
#pragma mark -/** 在线客服 **/
- (void)onlineAction:(UIButton *)sender{
    QYSource *source = [[QYSource alloc] init];
    source.title = @"一鹿省客服";
    source.urlString = @"https://qiyukf.com/";
    storeBaseModel *model = [storeBaseModel getUseData];
    [QYCustomUIConfig sharedInstance].customerHeadImageUrl =  [NSString stringWithFormat:@"%@",model.store_logo];
    
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"一鹿省客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}
#pragma mark -/** 拨打电话  */
- (void)phoneAction:(UIButton *)sender{
    /** 弹出选择是否确定要拨打电话 */
    NSString *telephoneNumber=@"400-181-9111";
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",telephoneNumber];
    UIApplication *application = [UIApplication sharedApplication];
    NSURL *URL = [NSURL URLWithString:str];
    if (@available(iOS 10.0, *)) {
        [application openURL:URL options:@{} completionHandler:^(BOOL success) {
            //OpenSuccess=选择 呼叫 为 1  选择 取消 为0
            NSLog(@"OpenSuccess=%d",success);
            
        }];
    } else {
        // Fallback on earlier versions
    }
}
#pragma mark - 懒加载
-(UIImageView *)Backimage{
    if (!_Backimage) {
        _Backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, IPHONEWIDTH(120))];
        _Backimage.image = [UIImage imageNamed:@"bg_faq_top"];
    }
    return _Backimage;
}
-(UITableView *)helpTableView{
    if (!_helpTableView) {
        _helpTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-30, 350) style:UITableViewStyleGrouped];
        _helpTableView.delegate = self;
        _helpTableView.dataSource = self;
        [_helpTableView registerNib:[UINib nibWithNibName:@"HelpTableViewCell" bundle:nil] forCellReuseIdentifier:@"HelpTableViewCell"];
        _helpTableView.backgroundColor = [UIColor whiteColor];
    }
    return _helpTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
