//
//  FanSiSViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/24.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FanSiSViewController.h"

@interface FanSiSViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 列表 **/
@property (strong,nonatomic)UITableView * userTableView;
@property (strong,nonatomic)UITableView * storeTableView;
/** 数据数组 */
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * Data1;
/** 分页 */
@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)UIView * menuV;

@end

@implementation FanSiSViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = [NSString stringWithFormat:@"%@粉丝",self.NavString];
    self.page = 1;
    [self merchant_center:self.page];
    
    /**
     用户or商户
     */
    [self menuView];
    /**
     * UI
     */
    [self createUI];
    
}
#pragma mark - 请求粉丝列表
-(void)merchant_center:(NSInteger)page{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    NSString *pageStr = [NSString stringWithFormat:@"%ld",(long)page];
    [[FBHAppViewModel shareViewModel]get_sec_class_fans_info:model.merchant_id anduser_id:self.user_id andstore_id:self.user_type andpage:pageStr andlimit:@"15" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            if (self.page == 1) {
                [self.Data removeAllObjects];
                [self.Data1 removeAllObjects];
            }
            for (NSDictionary *dict in DIC[@"user_info"]) {
                [self.Data addObject:dict];
            }
            for (NSDictionary *dict in DIC[@"merchant_info"]) {
                [self.Data1 addObject:dict];
            }
            
            [self.userTableView reloadData];
            [self.storeTableView reloadData];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - 菜单栏
- (void)menuView{
    self.menuV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    self.menuV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.menuV];
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"用户",@"商户",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = UIColorFromRGB(0xF5F7FA);//[UIColor colorWithRed:252/255.0 green:245/255.0 blue:248/255.0 alpha:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x222222),UITextAttributeTextColor,nil];
    [segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x222222),UITextAttributeTextColor,nil];
    [segmentedControl setTitleTextAttributes:dics forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.layer.masksToBounds = YES;
    segmentedControl.layer.cornerRadius = 15;
    
    [self.menuV addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(300, 30));
    }];
    
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
        NSLog(@"用户");
        self.storeTableView.hidden = YES;
        self.userTableView.hidden = NO;
        [self.userTableView reloadData];
    } else {
        NSLog(@"商户");
        self.storeTableView.hidden = NO;
        self.userTableView.hidden = YES;
        [self.storeTableView reloadData];
    }
}
#pragma mark - UI
-(void)createUI{
    
    [self.view addSubview:self.userTableView];
    [self.view addSubview:self.storeTableView];
    self.storeTableView.hidden = YES;
    
    [self.userTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuV.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(kIs_iPhoneX ? 20:0);
    }];
    
    
    [self.storeTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.menuV.mas_bottom).offset(0);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(kIs_iPhoneX ? 20:0);
    }];
}
-(void)footerRereshing{
    self.page ++;
    [self merchant_center:self.page];
    [self.userTableView.mj_footer endRefreshing];
}
-(void)footerRereshing1{
    self.page ++;
    [self merchant_center:self.page];
    [self.storeTableView.mj_footer endRefreshing];
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.userTableView) {
        return self.Data.count;
    }else{
        return self.Data1.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.userTableView) {
        FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FSTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.Data = self.Data[indexPath.row];
        return cell;
    }else{
        FSTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FSTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.Data1 = self.Data1[indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.01f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 68;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark - GET
-(UITableView *)userTableView{
    if (!_userTableView) {
        _userTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH-50) style:UITableViewStyleGrouped];
        _userTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _userTableView.delegate = self;
        _userTableView.dataSource = self;
        _userTableView.allowsSelectionDuringEditing = YES;
        _userTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _userTableView.estimatedRowHeight = 0;
        _userTableView.estimatedSectionHeaderHeight = 0;
        _userTableView.estimatedSectionFooterHeight = 0;
        [_userTableView registerNib:[UINib nibWithNibName:@"FSTableViewCell" bundle:nil] forCellReuseIdentifier:@"FSTableViewCell"];
        _userTableView.defaultNoDataText = @"您暂时没有粉丝哦~";
        _userTableView.defaultNoDataImage = [UIImage imageNamed:@"no_fans_tip"];
        _userTableView.backgroundView = [UIView new];
        _userTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
            
        };
        /** 底部刷新 **/
        _userTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    }
    return _userTableView ;
}

-(UITableView *)storeTableView{
    if (!_storeTableView) {
        _storeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 50, ScreenW, ScreenH-50) style:UITableViewStyleGrouped];
        _storeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _storeTableView.delegate = self;
        _storeTableView.dataSource = self;
        _storeTableView.allowsSelectionDuringEditing = YES;
        _storeTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _storeTableView.estimatedRowHeight = 0;
        _storeTableView.estimatedSectionHeaderHeight = 0;
        _storeTableView.estimatedSectionFooterHeight = 0;
        [_storeTableView registerNib:[UINib nibWithNibName:@"FSTableViewCell" bundle:nil] forCellReuseIdentifier:@"FSTableViewCell"];
        _storeTableView.defaultNoDataText = @"您暂时没有粉丝哦~";
        _storeTableView.defaultNoDataImage = [UIImage imageNamed:@"no_fans_tip"];
        _storeTableView.backgroundView = [UIView new];
        _storeTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
            
        };
        /** 底部刷新 **/
        _storeTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing1)];
    }
    return _storeTableView ;
}
/**
 * 粉丝数据数组
 **/
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableArray *)Data1{
    if (!_Data1) {
        _Data1 = [NSMutableArray array];
    }
    return _Data1;
}

@end
