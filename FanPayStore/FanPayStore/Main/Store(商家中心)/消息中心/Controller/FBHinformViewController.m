//
//  FBHinformViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHinformViewController.h"
#import "informTableViewCell.h"
#import "NewVTableViewCell.h"
#import "HuoDTableViewCell.h"
#import "FBHinformDetailViewController.h"//详情

@interface FBHinformViewController ()<UITableViewDelegate,UITableViewDataSource>
/** 分页 **/
@property (assign,nonatomic)NSInteger page;
/**  **/
@property (strong,nonatomic)NSMutableArray * Data;

@end

@implementation FBHinformViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.page = 1;
//    [self merchant_center];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navigationItemText;
    [self createUI];
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    UserModel *model = [UserModel getUseData];

    NSDictionary *dict = @{
                           @"news_type":[NSString stringWithFormat:@"%@",self.news_type],
                           @"page":[NSString stringWithFormat:@"%ld",(long)self.page],
                           @"limit":@"20",
                           };
    [[FBHAppViewModel shareViewModel]list_news_info:model.merchant_id andDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            
            if (self.page == 1) {
                [self.Data removeAllObjects];
            }
            for (NSDictionary *dict in DIC[@"news_info"]) {
                [self.Data addObject:dict];
            }
            [self news_read];

            [self.tableView reloadData];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
    
}
#pragma mark - 已读
-(void)news_read{
    UserModel *model = [UserModel getUseData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //店铺ID
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",model.store_id]] isEqualToString:@""]) {
        
    }else{
        [dict setObject:model.store_id forKey:@"store_id"];
    }
    //消息ID
    NSString *ArrayString = [NSString new];
    for (int i = 1; i<=self.Data.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.Data[i-1][@"read_id"]];
        if (i == self.Data.count) {
            ArrayString = [ArrayString stringByAppendingFormat:@"%@",urlstring];
        }else{
            ArrayString = [ArrayString stringByAppendingFormat:@"%@,",urlstring];
        }
        [dict setObject:ArrayString forKey:@"news_id"];

    }

    
    [[FBHAppViewModel shareViewModel]set_news_read:model.merchant_id andDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];
            
        }
        
    } andfailure:^{
        
    }];

}
#pragma mark - UI
-(void)createUI{
    self.tableView.frame  = CGRectMake(0, 0, ScreenW, ScreenH-64);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource =self;
    [self.tableView registerNib:[UINib nibWithNibName:@"informTableViewCell" bundle:nil] forCellReuseIdentifier:@"informTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"NewVTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewVTableViewCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"HuoDTableViewCell" bundle:nil] forCellReuseIdentifier:@"HuoDTableViewCell"];
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
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
    self.tableView.mj_header = header;
    
}
-(void)footerRereshing{
    self.page ++;
    [MBProgressHUD MBProgress:@"数据加载中..."];
    [self merchant_center];
    [self.tableView.mj_footer endRefreshing];
}
-(void)headerRereshing{
    self.page = 1;
    [MBProgressHUD MBProgress:@"数据加载中..."];
    [self merchant_center];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    /**
     * 1、判读是否有图片
     * 2、先判断是否有详情可以进入
     **/
    //步骤 1 news_title
    if (kStringIsEmpty(self.Data[indexPath.row][@"news_pic"])) {
        NewVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewVTableViewCell" forIndexPath:indexPath];
        cell.backgroundColor = MainbackgroundColor;
        cell.Data = self.Data[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }else{
        NSString *has_detail = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"has_detail"]];
        if ([has_detail isEqualToString:@"1"]) {
            HuoDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HuoDTableViewCell" forIndexPath:indexPath];
            cell.backgroundColor = MainbackgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.Data = self.Data[indexPath.row];
            return cell;
        }else{
            informTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informTableViewCell" forIndexPath:indexPath];
            cell.backgroundColor = MainbackgroundColor;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

            cell.Data = self.Data[indexPath.row];
            return cell;
        }
        
    }
    
//    if ([self.news_type isEqualToString:@"1"]) {
//        /** 系统 */
//        NewVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewVTableViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }else if ([self.news_type isEqualToString:@"2"]){
//        /** 客服助手 */
//        HuoDTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HuoDTableViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }else if ([self.news_type isEqualToString:@"3"]){
//        /** 通知 */
//        informTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"informTableViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }else{
//        /** 收银台 */
//        NewVTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewVTableViewCell" forIndexPath:indexPath];
//        cell.backgroundColor = [UIColor clearColor];
//        return cell;
//    }
    
    
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (kStringIsEmpty(self.Data[indexPath.row][@"news_pic"])) {
        return 111;
    }else{
        NSString *has_detail = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"has_detail"]];
        if ([has_detail isEqualToString:@"1"]) {
            return 287;
        }
        return 159;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *has_detail = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"has_detail"]];
    
//    if ([has_detail isEqualToString:@"1"]) {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];

        /** 有详情 **/
        FBHinformDetailViewController *VC = [FBHinformDetailViewController new];
        VC.news_id = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"read_id"]];
        VC.navigationItemText = self.navigationItemText;
//        VC.news_title.text = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"news_title"]];
        VC.Data =self.Data[indexPath.row];
        [self.navigationController pushViewController:VC animated:NO];

//    }else{
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];
//
//    }

}

#pragma mark - GET
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
