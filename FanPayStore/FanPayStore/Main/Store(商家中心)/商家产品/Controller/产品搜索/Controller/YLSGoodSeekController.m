//
//  YLSGoodSeekController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/1.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import "YLSGoodSeekController.h"
#import "SeekCell.h"
#import "SearchBarView.h"

@interface YLSGoodSeekController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate,SearchDelegate>
@property (strong,nonatomic)UITableView * GoodsTableview;
/** 数据 **/
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableArray * categoryData;
/*搜索框*/
@property (strong,nonatomic)UISearchBar * GoodSearch;
@property (strong,nonatomic)SearchBarView * SearchView;
/*分页*/
@property(nonatomic,assign) NSInteger goodspage;
@end

@implementation YLSGoodSeekController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.goodspage = 1;
    /**
     *  导航栏
     */
    [self setupNav];
    /**
     *  UI
     */
    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:NavView];
    /*返回按钮*/
    UIButton *thirdBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn1.frame = CGRectMake(0, STATUS_BAR_HEIGHT, 44, 44);
    [thirdBtn1 setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    [thirdBtn1 addTarget:self action:@selector(popAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn1];
    
    /*搜索按钮*/
    UIButton *thirdBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    thirdBtn2.frame = CGRectMake(NavView.width-69, STATUS_BAR_HEIGHT+7, 49, 30);
    [thirdBtn2 setTitle:@"搜索" forState:UIControlStateNormal];
    [thirdBtn2 setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
    thirdBtn2.titleLabel.font = [UIFont systemFontOfSize:12];
    thirdBtn2.layer.borderWidth = 0.7;
    thirdBtn2.layer.borderColor = UIColorFromRGB(0xE4E6EB).CGColor;
    thirdBtn2.layer.cornerRadius = 15;
    [thirdBtn2 addTarget:self action:@selector(SeekAction) forControlEvents:UIControlEventTouchUpInside];
    [NavView addSubview:thirdBtn2];
    
    [NavView addSubview:self.SearchView];
    [self.SearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(47);
        make.right.mas_equalTo(thirdBtn2.mas_left).offset(-10);
        make.height.mas_equalTo(30);
        make.bottom.mas_equalTo(-7);
    }];
    
}
-(void)popAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
/*搜索事件*/
-(void)SeekAction{
    [self.SearchView.SearchField resignFirstResponder];
    [self Search:self.SearchView.SearchField.text];
}
#pragma mark -搜索商品
-(void)Search:(NSString *)SearchString{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    NSDictionary *dict = @{
                           @"goods_name":[NSString stringWithFormat:@"%@",SearchString],
//                           @"page": [NSString stringWithFormat:@"%ld",self.goodspage],
//                           @"limit":@"20",
                           };
    [[FBHAppViewModel shareViewModel]search_merchant_goods:model.merchant_id andstore_id:model.store_id andgoods_id:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
            NSDictionary *DIC=resDic[@"data"];
            [self.Data removeAllObjects];
            [self.categoryData removeAllObjects];
            
            NSString *category_name = [NSString new];
            for (NSDictionary *dict in DIC[@"store_goods"]) {
                NSString *category_name1 = [NSString stringWithFormat:@"%@",dict[@"category_name"]];
                if ([category_name1 isEqualToString:category_name]) {
                    
                }else{
                    category_name = [NSString stringWithFormat:@"%@",dict[@"category_name"]];
                    [self.categoryData addObject:dict];
                }
            }
            
            
            for (int i = 0; i<self.categoryData.count; i++) {
                NSMutableArray *Array = [NSMutableArray array];
                NSString *category_name = [NSString stringWithFormat:@"%@",self.categoryData[i][@"category_name"]];
                for (NSDictionary *dict in DIC[@"store_goods"]) {
                    if ([category_name isEqualToString:[NSString stringWithFormat:@"%@",dict[@"category_name"]]]) {
                        [Array addObject:dict];
                    }
                    
                }
                [self.Data addObject:Array];
            }
            
            
            
            [self.GoodsTableview reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
}
-(void)footerRereshing{
    self.goodspage ++;
    [self Search:self.SearchView.SearchField.text];
    [self.GoodsTableview.mj_footer  endRefreshing];
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.GoodsTableview];
    [self.GoodsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(44+STATUS_BAR_HEIGHT);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-5);
    }];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(SaveAction:) name:@"Save" object:nil];
}
- (void)SaveAction:(NSNotification *) notification {
    [self Search:self.SearchView.SearchField.text];
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.categoryData.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *arr = self.Data[section];
    return arr.count;
//    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SeekCell * cell= [tableView dequeueReusableCellWithIdentifier:@"SeekCell"];
    cell = [[SeekCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeekCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.keyString = self.SearchView.SearchField.text;
    cell.Data = self.Data[indexPath.section][indexPath.row];
    cell.BianjiBlock = ^{
        YLSAddProductController *VC = [YLSAddProductController new];
        VC.goodId = self.Data[indexPath.section][indexPath.row][@"goods_id"];
        [self.navigationController pushViewController:VC animated:YES];
    };
    cell.SoldBlock = ^{
        [self sale_type:@"2" andgoods_id:[NSString stringWithFormat:@"%@",self.Data[indexPath.section][indexPath.row][@"goods_id"]]];
        [self Search:self.SearchView.SearchField.text];
    };
    
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = UIColorFromRGB(0xF6F6F6);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,10,100,14);
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%@",self.categoryData[section][@"category_name"]];
    label.font = [UIFont systemFontOfSize:12];
    label.textColor =  UIColorFromRGB(0x999999);
    [headerV addSubview:label];

    return headerV;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 52)];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 31;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
#pragma mark - 滑动
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    
    [self.SearchView.SearchField resignFirstResponder];
    NSLog(@"滑动开始");
    
}
#pragma mark -  上架、已下架请求
-(void)sale_type:(NSString *)set_sale_type andgoods_id:(NSString *)goods_id{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *dict = @{
                           @"goods_id":goods_id,
                           @"set_sale_type":set_sale_type
                           };
    
    [[FBHAppViewModel shareViewModel]set_goods_sale_type:model.merchant_id andstore_id:model.store_id andgoods_id:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
            [self Search:self.SearchView.SearchField.text];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"Save" object:nil];
    
}
#pragma mark - 懒加载
-(UITableView *)GoodsTableview{
    if (!_GoodsTableview) {
        _GoodsTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44) style:UITableViewStylePlain];
        [_GoodsTableview registerClass:[SeekCell class] forCellReuseIdentifier:@"SeekCell"];
        _GoodsTableview.delegate =  self;
        _GoodsTableview.dataSource = self;
        _GoodsTableview.backgroundColor = [UIColor clearColor];
        _GoodsTableview.separatorStyle = UITableViewCellAccessoryNone;
        _GoodsTableview.defaultNoDataText = @"";
        _GoodsTableview.defaultNoDataImage = [UIImage new];
        //底部刷新
//        _GoodsTableview.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
//        _GoodsTableview.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
//        _GoodsTableview.mj_footer.ignoredScrollViewContentInsetBottom = kIs_iPhoneX? 60:30;
    }
    return _GoodsTableview;
}
- (UISearchBar *)GoodSearch {
    if (!_GoodSearch) {
        _GoodSearch = [[UISearchBar alloc]init];
        [_GoodSearch layoutIfNeeded];
        _GoodSearch.layer.cornerRadius = 15;
        _GoodSearch.layer.masksToBounds = YES;
        _GoodSearch.layer.borderWidth = 0.5;
        _GoodSearch.layer.borderColor = UIColorFromRGB(0xE4E6EB).CGColor;
        _GoodSearch.keyboardType = UIKeyboardAppearanceDefault;
        _GoodSearch.placeholder = @"商品名称";
        _GoodSearch.delegate = self;
        _GoodSearch.barTintColor = [UIColor clearColor];//UIColorFromRGB(0xFAFBFC);//底部的颜色
        _GoodSearch.searchBarStyle = UISearchBarStyleMinimal;
        _GoodSearch.barStyle = UIBarStyleDefault;
    }
    return _GoodSearch;
}
-(SearchBarView *)SearchView{
    if (!_SearchView) {
        _SearchView = [[SearchBarView alloc]init];
        _SearchView.layer.cornerRadius = 15;
        _SearchView.delagate = self;
        _SearchView.layer.masksToBounds = YES;
        _SearchView.layer.borderWidth = 0.5;
        _SearchView.layer.borderColor = UIColorFromRGB(0xE4E6EB).CGColor;
        _SearchView.backgroundColor = UIColorFromRGB(0xFAFBFC);
    }
    return _SearchView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableArray *)categoryData{
    if (!_categoryData) {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}
@end
