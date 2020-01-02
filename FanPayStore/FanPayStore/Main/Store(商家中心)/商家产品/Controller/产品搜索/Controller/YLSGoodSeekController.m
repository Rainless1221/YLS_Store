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

@interface YLSGoodSeekController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
@property (strong,nonatomic)UITableView * GoodsTableview;
/** 数据 **/
@property (strong,nonatomic)NSMutableArray * Data;
/*搜索框*/
@property (strong,nonatomic)UISearchBar * GoodSearch;
@property (strong,nonatomic)SearchBarView * SearchView;
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
    
}
#pragma mark - UI
-(void)createUI{

    [self.view addSubview:self.GoodsTableview];
    [self.GoodsTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(44+STATUS_BAR_HEIGHT);
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-5);
    }];
    
    
}

#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //    return self.Data.count;
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    SeekCell * cell= [tableView dequeueReusableCellWithIdentifier:@"SeekCell"];
    cell = [[SeekCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SeekCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    //    cell.Data = self.Data[indexPath.row];
    
    cell.BianjiBlock = ^{
        YLSAddProductController *VC = [YLSAddProductController new];
//        VC.goodId = self.gooddata[indexPath.row][@"goods_id"];
        [self.navigationController pushViewController:VC animated:YES];
    };
    cell.SoldBlock = ^{
//        [self sale_type:@"2" andgoods_id:[NSString stringWithFormat:@"%@",self.gooddata[indexPath.row][@"goods_id"]]];
    };
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = UIColorFromRGB(0xF6F6F6);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,10,100,14);
    label.numberOfLines = 0;
    label.text = @"甜品蛋糕";
    label.font = [UIFont systemFontOfSize:12];
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
    
//    SeekCell * cell = (SeekCell *)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
//    //直接返回cell 高度
//    return [cell getCellHeight];
    
        return 90;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

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
@end
