//
//  FBHPreferlistController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FBHPreferlistController.h"
#import "PreferlistCell.h"
#import "PreferlistHeader.h"
#import "PrefeSetViewController.h"

@interface FBHPreferlistController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * listTableView;
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSMutableDictionary * HeaderData;
@property (strong,nonatomic)NSMutableArray * ongoingData;
@property (strong,nonatomic)NSMutableArray * finishedData;
@property (strong,nonatomic)NSMutableArray * not_startData;
@property (strong,nonatomic)PreferlistHeader *Header;
/** 分页 */
@property (assign,nonatomic)NSInteger page;
@property (strong,nonatomic)NSString * status;

@end

@implementation FBHPreferlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特惠活动";
    
    [self list_preferential];
    
    [self createUI];
    
}
#pragma mark - 请求
-(void)list_preferential
{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    NSDictionary *dict = @{@"type":[NSString stringWithFormat:@"%@",self.status],
                           @"page":[NSString stringWithFormat:@"%ld",self.page],
                           @"limit":@"15"
                           };
    
    [[FBHAppViewModel shareViewModel]list_preferential_activities:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            /*统计信息 */
           self.HeaderData =  DIC[@"statistical_information"];
            self.Header.Data = self.HeaderData;

            if (self.page ==1) {
                [self.not_startData removeAllObjects];
                [self.ongoingData removeAllObjects];
                [self.finishedData removeAllObjects];

            }
            [self.Data removeAllObjects];

            //ongoing_preferential_info进行中的特惠活动信息
            for (NSDictionary *dict in DIC[@"ongoing_preferential_info"]) {
                [self.ongoingData addObject:dict];
            }
            //finished_preferential_info已结束的特惠活动信息
            for (NSDictionary *dict in DIC[@"finished_preferential_info"]) {
                [self.finishedData addObject:dict];
            }
            //not_start_preferential_info 未开始的特惠活动信息
            for (NSDictionary *dict in DIC[@"not_start_preferential_info"]) {
                [self.not_startData addObject:dict];
            }
            
            for (NSDictionary *dict in self.not_startData) {
                [self.Data addObject:dict];
            }
            for (NSDictionary *dict in self.ongoingData) {
                [self.Data addObject:dict];
            }
            for (NSDictionary *dict in self.finishedData) {
                [self.Data addObject:dict];
            }
            [self.listTableView reloadData];
            
        }else{
            
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        
    }];
}
#pragma mark - UI
-(void)createUI{
    YBWeakSelf
    self.Header = [[PreferlistHeader alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 252)];
    self.Header.addActionBlock = ^{
        [weakSelf.navigationController pushViewController:[PrefeSetViewController new] animated:NO];
        
    };
    self.Header.Menublock = ^(NSString * _Nonnull btntag) {
        weakSelf.page = 1;
        weakSelf.status = btntag;
        [weakSelf list_preferential];
        [weakSelf.listTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    };
    [self.view addSubview:self.Header];
    
    [self.view addSubview:self.listTableView];
    [self.listTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(252);
        make.left.right.bottom.mas_offset(0);
    }];
    
    self.listTableView.defaultNoDataText = @"";
    self.listTableView.defaultNoDataImage = [UIImage imageNamed:@"no_product_tip"];
    self.listTableView.backgroundView = [UIView new];
    self.listTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        //        [self merchant_center];
    };
    self.listTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(headerRereshing)];
    
    /** 底部刷新 **/
    self.listTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    //prefeSavelist
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"prefeSavelist" object:nil];
    
}
/**
 * 刷新
 */
-(void)headerRereshing{
    self.page = 1;
    [self list_preferential];
    [self.listTableView.mj_header endRefreshing];
}
-(void)footerRereshing{
    self.page ++;
    [self list_preferential];
    [self.listTableView.mj_footer endRefreshing];
}
- (void)conversionAction: (NSNotification *) notification {
    
    [self list_preferential];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
//    if ([self.status isEqualToString:@"1"]) {
//        return self.Data.count;
//    }else if ([self.status isEqualToString:@"2"]){
//        return self.ongoingData.count;
//
//    }else if([self.status isEqualToString:@"3"])
//    {
//        return self.finishedData.count;
//
//    }else if([self.status isEqualToString:@"4"])
//    {
//        return self.not_startData.count;
//
//    }else{
        return self.Data.count;

//    }

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // 定义唯一标识
        static NSString *CellIdentifier = @"Cell";
       // 通过indexPath创建cell实例 每一个cell都是单独的
      PreferlistCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        // 判断为空进行初始化  --（当拉动页面显示超过主页面内容的时候就会重用之前的cell，而不会再次初始化）
        if (!cell) {
            cell = [[PreferlistCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
         }
    
    
//    PreferlistCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PreferlistCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.Data = self.Data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 164;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    YBWeakSelf
//    PreferlistHeader *Header = [[PreferlistHeader alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 252)];
//    Header.Data = self.HeaderData;
//    Header.addActionBlock = ^{
//        [weakSelf.navigationController pushViewController:[PrefeSetViewController new] animated:NO];
//
//    };
//    Header.Menublock = ^(NSString * _Nonnull btntag) {
//        weakSelf.page = 1;
//        weakSelf.status = btntag;
//        [weakSelf list_preferential];
//        [weakSelf.listTableView  scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
//    };
//
//    return Header;
//}
#pragma mark - 点击
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    NSString *desc = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"desc"]];
    
    if ([desc isEqualToString:@"已结束"]) {
        return;
    }else if ([desc isEqualToString:@""]){
        
    }
    
    FBHPreferController *VC=  [FBHPreferController new];
    VC.preferential_id = self.Data[indexPath.row][@"preferential_id"];
    [self.navigationController pushViewController:VC animated:NO];
    
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section) {
            
        }
        // 删除数据源的数据,self.cellData是你自己的数据
        //        [self.cellData removeObjectAtIndex:indexPath.row];
        NSString *dgood = self.Data[indexPath.row][@"preferential_id"];
        [self Delete:dgood];
        // 删除列表中数据
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}
#pragma mark - 删除活动
-(void)Delete:(NSString*)discount{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将本活动删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        
        [[FBHAppViewModel shareViewModel]delete_preferential_activity:model.merchant_id andstore_id:model.store_id andpreferential_id:discount Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                self.page = 1;
                [self list_preferential];
                [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
            
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
    
    
}
#pragma mark - 懒加载
-(UITableView *)listTableView{
    if (!_listTableView) {
        _listTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _listTableView.delegate = self;
        _listTableView.dataSource = self;
        _listTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        
//        [_listTableView registerClass:[PreferlistCell class] forCellReuseIdentifier:@"PreferlistCell"];
        _listTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _listTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableDictionary *)HeaderData{
    if (!_HeaderData) {
        _HeaderData = [NSMutableDictionary dictionary];
    }
    return _HeaderData;
}
-(NSMutableArray *)ongoingData{
    if (!_ongoingData) {
        _ongoingData = [NSMutableArray array];
    }
    return _ongoingData;
}
-(NSMutableArray *)finishedData{
    if (!_finishedData) {
        _finishedData = [NSMutableArray array];
    }
    return _finishedData;
}
-(NSMutableArray *)not_startData{
    if (!_not_startData) {
        _not_startData = [NSMutableArray array];
    }
    return _not_startData;
}
@end
