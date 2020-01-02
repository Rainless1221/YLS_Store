//
//  FBHRevenueController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHRevenueController.h"

@interface FBHRevenueController ()<UITableViewDelegate,UITableViewDataSource,RevenueHeaderDelegate,DatePickerDelegate>
{
    long _currentTopSectionViewCount;
    NSInteger _endint;
}
@property (strong,nonatomic)UITableView * ReveTableview;
@property (strong,nonatomic)RevenueHeaderM * headerView;
@property (strong,nonatomic)NSMutableArray * ReveData;
@property (strong,nonatomic)NSMutableArray * ReveData_row;

@property (strong,nonatomic)NSMutableArray * total_income;
@property (strong,nonatomic)NSMutableArray * total_expense;


/** 筛选 */
@property (strong,nonatomic)NSString * Reventype;
@property (assign,nonatomic)NSInteger Page;
@property (strong,nonatomic)NSString * Reven_end_date;
@end

@implementation FBHRevenueController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.Reventype = @"1";
    self.Page = 1;
    [self merchant_center];
    self.navigationItem.title = @"营收记录";
    [self createUI];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    // type  1为全部 包括收入和支出，2为收入 如用户消费付款 3为支出 如提现 不传则后台默认为1全部
    NSDictionary *Dict = [NSDictionary dictionary];
    if (self.Reven_end_date==nil) {
        Dict = @{
                 @"type":[NSString stringWithFormat:@"%@",self.Reventype],
                 @"page":[NSString stringWithFormat:@"%ld",self.Page],
                 @"limit":@"18",
                 };
    }else{
        Dict = @{
                 @"end_date":[NSString stringWithFormat:@"%@",self.Reven_end_date],
                 @"type":[NSString stringWithFormat:@"%@",self.Reventype],
                 @"page":[NSString stringWithFormat:@"%ld",self.Page],
                 @"limit":@"18",
                 };
    }
    
    [[FBHAppViewModel shareViewModel]list_checkstand_revenue:model.merchant_id andstore_id:model.store_id andlistDict:Dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1) {
            
            NSDictionary *DIC = resDic[@"data"];
            NSString *end_date = [NSString stringWithFormat:@"%@",DIC[@"end_date"]];

            NSString *str5 = [end_date substringFromIndex:end_date.length-2];
            /*年*/
            NSString *strTime = [end_date substringToIndex:4];
            /*月*/
            NSString *mon = [NSString stringWithFormat:@"%@年%@月",strTime,str5];
            [self.headerView.TimeButton setTitle:mon forState:UIControlStateNormal];
            
            
            if (self.Page  == 1) {
                [self.ReveData removeAllObjects];
                [self.ReveData_row removeAllObjects];
                [self.total_income removeAllObjects];
                [self.total_expense removeAllObjects];

            }
            
            
            [self parsingData:DIC end:end_date];
 

           
        }else{
            
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    

    
}
-(void)parsingData:(NSDictionary *)Data end:(NSString *)key{
    
    for (NSDictionary *dict in Data[@"total_income"]) {
        NSString *data = [NSString stringWithFormat:@"%@",dict[@"date"]];
        if (self.total_income.count == 0) {
            [self.total_income addObject:dict];

        }
        if ([data isEqualToString:self.total_income[self.total_income.count-1][@"date"]]) {
            
        }else{
            [self.total_income addObject:dict];

        }
    }
    
    
    for (NSDictionary *dict in Data[@"total_expense"]) {
        NSString *data = [NSString stringWithFormat:@"%@",dict[@"date"]];
        if (self.total_expense.count == 0) {
            [self.total_expense addObject:dict];
            
        }
        if ([data isEqualToString:self.total_expense[self.total_expense.count-1][@"date"]]) {
            
        }else{
            [self.total_expense addObject:dict];

        }
    }
    
   
    
    
    for (NSString *dictKey in Data[@"consumption_info"]) {
        
        for (NSDictionary *dict in Data[@"consumption_info"][dictKey]) {
            
            [self.ReveData_row addObject:dict];

        }
        
        
    }
    
    [self.ReveData removeAllObjects];
    NSMutableArray *array = [NSMutableArray arrayWithArray:self.ReveData_row];

    for (int i = 0; i < array.count; i ++) {
        
        NSString *string = array[i][@"months"];
        
        NSMutableArray *tempArray = [@[] mutableCopy];
        
        [tempArray addObject:array[i]];
        
        for (int j = i+1; j < array.count; j ++) {
            
            NSString *jstring = array[j][@"months"];
            
            if([string isEqualToString:jstring]){
                
                [tempArray addObject:array[j]];
                
                [array removeObjectAtIndex:j];
                j -= 1;
                
            }
            
        }
        
        [self.ReveData addObject:tempArray];
        
    }
    
    [self.ReveTableview reloadData];
    
}

#pragma mark - UI
-(void)createUI{
    /** 菜单栏 */
    self.headerView = [[RevenueHeaderM alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 60)];
    self.headerView.backgroundColor = [UIColor whiteColor];
    self.headerView.delagate = self;
    [self.view addSubview:self.headerView];

    
    [self.view addSubview:self.ReveTableview];
    [self.ReveTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headerView.mas_bottom).offset(0);
        make.left.right.bottom.mas_offset(0);
    }];
    
}
-(void)headerRereshing{
    self.Page = 1;
    [self merchant_center];
    [self.ReveTableview.mj_header endRefreshing];
}
-(void)footerRereshing{
    self.Page ++;
    [self merchant_center];
    [self.ReveTableview.mj_footer endRefreshing];
}
#pragma mark - 选择时间
-(void)DateAction{
    FBHPickerView *pick = [[FBHPickerView alloc]initWithFrame:CGRectMake(0,0, ScreenW, ScreenH)];
    pick.delegate = self;
    [self.view.window addSubview:pick];
}
-(void)DatePickerView:(NSString *)year withMonth:(NSString *)month withDay:(NSString *)day withDate:(NSString *)date withTag:(NSInteger)tag{
    NSLog(@"年:%@ 月:%@    %@",year,month,date);
    [self.headerView.TimeButton setTitle:date forState:UIControlStateNormal];

    self.Reven_end_date = [NSString stringWithFormat:@"%@-%@",year,month];
    self.Page = 1;
    [self.ReveTableview  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self merchant_center];
}
#pragma mark - 选择类型
- (void)RevenueButton:(NSInteger)Btntag{
    self.Page = 1;
    if (Btntag == 1) {
        self.Reventype = @"3";
    }else if(Btntag == 2){
        self.Reventype = @"4";
    }else if (Btntag == 3){
        self.Reventype = @"2";
    }else{
        self.Reventype = @"1";
    }
    [self.ReveTableview  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    [self merchant_center];
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.ReveData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = [NSArray array];
    arr =self.ReveData[section];
    return arr.count;
//    return self.ReveData_row.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ReveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReveTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSArray *arr = [NSArray array];
    arr =self.ReveData[indexPath.section];
    cell.Data = arr[indexPath.row];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    headerview.backgroundColor = UIColorFromRGB(0xF6F6F6);

    TableViewSectionHeaderView *headerView = (TableViewSectionHeaderView *)[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"TableViewSectionHeaderView"];
    
    NSString *time = [NSString stringWithFormat:@"%@",self.total_income[section][@"date"]];
    NSString *str5 = [time substringFromIndex:time.length-2];
    /*年*/
    NSString *strTime = [time substringToIndex:4];
    /*月*/
    NSString *mon = [NSString stringWithFormat:@"%@年%@月",strTime,str5];
    
    headerView.titleStr = mon;
    headerView.label1.text = [NSString stringWithFormat:@"营收 %@ 支出 %@",self.total_income[section][@"money"],self.total_expense[section][@"money"]];
    

    
    //颜色的设置
    headerView.contentView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    if (section == _currentTopSectionViewCount) {
        headerView.contentView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    } else {
        headerView.contentView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    }
    
    return headerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 62;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    FBHRevenuedetailsController *VC = [FBHRevenuedetailsController new];
    NSArray *arr = [NSArray array];
    arr =self.ReveData[indexPath.section];
    VC.log_id = arr[indexPath.row][@"log_id"];
    VC.log_type = arr[indexPath.row][@"type"];
    [self.navigationController pushViewController:VC animated:YES];

}
// MARK: Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.ReveTableview) {
        ///记录当前组数
        NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
        NSArray <ReveTableViewCell *> *cellArray = [self.ReveTableview  visibleCells];
//        //cell的section的最小值
        long cellSectionMINCount = LONG_MAX;
        for (int i = 0; i < cellArray.count; i++) {
            ReveTableViewCell *cell = cellArray[i];
            long cellSection = [self.ReveTableview indexPathForCell:cell].section;
            [dicM setValue:@(cellSection) forKey:[NSString stringWithFormat:@"%ld",cellSection]];
            if (cellSection < cellSectionMINCount) {
                cellSectionMINCount = cellSection;
            }
        }

        
        _currentTopSectionViewCount = cellSectionMINCount;
//        NSLog(@"当前悬停的组头是:%ld",_currentTopSectionViewCount);
        if (self.total_income.count == 0) {
            
        }else {
            NSString *time = [NSString stringWithFormat:@"%@",self.total_income[_currentTopSectionViewCount][@"date"]];
            NSString *str5 = [time substringFromIndex:time.length-2];
            /*年*/
            NSString *strTime = [time substringToIndex:4];
            /*月*/
            NSString *mon = [NSString stringWithFormat:@"%@年%@月",strTime,str5];
            
            [self.headerView.TimeButton setTitle:mon forState:UIControlStateNormal];
        }
        


    }
}

#pragma mark - GET
-(UITableView *)ReveTableview{
    if (!_ReveTableview) {
        _ReveTableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH - 44 - 20) style:UITableViewStyleGrouped];
        _ReveTableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _ReveTableview.estimatedRowHeight = 0;
        _ReveTableview.estimatedSectionHeaderHeight = 0;
        _ReveTableview.estimatedSectionFooterHeight = 0;
        [_ReveTableview registerNib:[UINib nibWithNibName:@"ReveTableViewCell" bundle:nil] forCellReuseIdentifier:@"ReveTableViewCell"];
        [_ReveTableview registerClass:[TableViewSectionHeaderView class] forHeaderFooterViewReuseIdentifier:@"TableViewSectionHeaderView"];

        _ReveTableview.delegate = self;
        _ReveTableview.dataSource = self;
        _ReveTableview.backgroundColor = UIColorFromRGB(0xF6F6F6);
        MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
        NSMutableArray *refreshingImages = [NSMutableArray array];
        // 隐藏时间
        header.lastUpdatedTimeLabel.hidden = YES;
        // 隐藏状态
        header.stateLabel.hidden = YES;
        NSArray *arr = @[@"MJ-1",@"MJ-2",@"MJ-3",@"MJ-4",@"MJ-5",@"MJ-6",@"MJ-7",@"MJ-8",@"MJ-9",@"MJ-10",@"MJ-11",@"MJ-12",@"MJ-13",@"MJ-14",@"MJ-15",@"MJ-16",@"MJ-17"];
        
        for (NSUInteger i = 0; i<arr.count; i++) {
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%@", arr[i]]];
            [refreshingImages addObject:image];
        }
        
        // 设置普通状态的动画图片
        [header setImages:refreshingImages forState:MJRefreshStateIdle];
        // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
        [header setImages:refreshingImages forState:MJRefreshStatePulling];
        // 设置正在刷新状态的动画图片
        [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
        // 设置header
        _ReveTableview.mj_header = header;
        
        /** 底部刷新 **/
        _ReveTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
        _ReveTableview.mj_footer.ignoredScrollViewContentInsetBottom = 30;

    }
    
    return _ReveTableview;
}
-(NSMutableArray *)ReveData{
    if (!_ReveData) {
        _ReveData = [NSMutableArray array];
    }
    return _ReveData;
}
-(NSMutableArray *)ReveData_row{
    if (!_ReveData_row) {
        _ReveData_row = [NSMutableArray array];
    }
    return _ReveData_row;
}
-(NSMutableArray *)total_income{
    if (!_total_income) {
        _total_income = [NSMutableArray array];
    }
    return _total_income;
}
-(NSMutableArray *)total_expense{
    if (!_total_expense) {
        _total_expense = [NSMutableArray array];
    }
    return _total_expense;
}

@end
