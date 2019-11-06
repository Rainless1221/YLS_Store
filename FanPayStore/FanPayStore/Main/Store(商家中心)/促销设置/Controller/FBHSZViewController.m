//
//  FBHSZViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHSZViewController.h"

@interface FBHSZViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *TableView;
@property (strong, nonatomic)ActivityScreenView * ScreenView;
@property (nonatomic, copy) NSMutableArray *data;
@property (nonatomic, copy) NSMutableArray *data1;
/** 分页 */
@property (assign,nonatomic)NSInteger page;
@property (assign,nonatomic)NSInteger typeInt;
@property (nonatomic, copy) NSMutableArray *FBData;

@end

@implementation FBHSZViewController
-(NSMutableArray *)data{
    if (!_data ) {
        _data = [NSMutableArray array];
    }
    return _data;
}
-(NSMutableArray *)data1{
    if (!_data1 ) {
        _data1 = [NSMutableArray array];
    }
    return _data1;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.page = 1;
    
    [self merchant_center:1];
}
#pragma mark - 请求
-(void)merchant_center:(NSInteger )typeInt{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    //1表示全部 2表示进行中 3表示已结束 不传则默认为1全部
    UserModel *model = [UserModel getUseData];
    NSString *type = [NSString stringWithFormat:@"%ld",typeInt];
    NSDictionary *Dict =@{
                          @"type":type,
                          @"page":[NSString stringWithFormat:@"%ld",self.page],
                          @"limit":@"15",
                          };
    
    [[FBHAppViewModel shareViewModel]list_goods_discount:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            if (self.page == 1) {
                [self.data removeAllObjects];
                [self.data1 removeAllObjects];
            }
            for (NSDictionary *dict in DIC[@"ongoing_discount_info"]) {
                [self.data addObject:dict];
            }
            
            for (NSDictionary *dict in DIC[@"finished_discount_info"]) {
                [self.data1 addObject:dict];
            }
            
            [self.FBData removeAllObjects];
            
            if (self.data.count>0) {
                [self.FBData addObject:self.data];
            }
            if (self.data1.count>0) {
                [self.FBData addObject:self.data1];
            }
            
            [self.TableView reloadData];
            //            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
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
        
        [[FBHAppViewModel shareViewModel]delete_store_discount:model.merchant_id andstore_id:model.store_id anddiscount:discount Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                [self merchant_center:self.typeInt];
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
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"促销设置";
    self.typeInt = 1;
//    [self.view addSubview:self.HeadView];
     [self.view addSubview:self.ScreenView];
    [self setupNav];
    [self createUI];
}
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 28)];
    [leftbutton setTitle:@"+ 添加" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [leftbutton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];self.navigationItem.rightBarButtonItem=rightitem;
    
}

-(void)RighAction{
    FBHiscountViewController *VC =[FBHiscountViewController new];
    //    VC.typeString = @"1";
    [self.navigationController pushViewController:VC animated:NO];
}

#pragma mark - UI
-(void)createUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 55, ScreenW, ScreenH-STATUS_BAR_HEIGHT-99) style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    [tableView registerNib:[UINib nibWithNibName:@"FBHSZTableViewCell" bundle:nil] forCellReuseIdentifier:@"FBHSZTableViewCell"];
    //    [tableView registerNib:[UINib nibWithNibName:@"FBHSZTableViewCell" bundle:nil] forCellReuseIdentifier:@"FBHSZTableViewCell"];
    
    [self.view addSubview:tableView];
    self.TableView = tableView;
    
    tableView.defaultNoDataText = @"";
    tableView.defaultNoDataImage = [UIImage imageNamed:@"no_product_tip"];
    tableView.backgroundView = [UIView new];
    tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        [self merchant_center:1];
    };
    /** 底部刷新 **/
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    tableView.mj_footer.ignoredScrollViewContentInsetBottom = kIs_iPhoneX? 60:30;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}
#pragma mark - 刷新
-(void)footerRereshing{
    self.page ++;
    [self merchant_center:1];
    [self.TableView.mj_footer endRefreshing];
}
- (void)onDeviceOrientationChange:(NSNotification *)noti {
    
    CGFloat width , height;
    width = [UIScreen mainScreen].bounds.size.width;
    height = ScreenH-STATUS_BAR_HEIGHT-99;
    self.TableView.frame = CGRectMake(0, 0, width, height);
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    //    if (self.data.count >0 ||  self.data1.count>0) {
    //        self.HeadView.HButton.hidden = NO;
    //        return 2;
    //    }
    //    return 0;
    
    return self.FBData.count;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    if (section==0) {
    //        return self.data.count;
    //    }else{
    //        return self.data1.count;
    //    }
    NSArray*arr = self.FBData[section];
    return arr.count;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *headeLbel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 25)];
    NSArray *arr = self.FBData[section];
    
    headeLbel.text = [NSString stringWithFormat:@"%@",arr[0][@"desc"]];
    //    if (section == 0) {
    //        headeLbel.text = @"进行中";
    //    }else{
    //        headeLbel.text = @"已结束";
    //    }
    return headeLbel;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FBHSZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FBHSZTableViewCell"];
    NSArray *arr = self.FBData[indexPath.section];
    cell.Data = arr[indexPath.row];
    
    //    if (indexPath.section == 1) {
    //        cell.Data = self.data1[indexPath.row];
    //        [cell.statusLabel setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_end"] forState:UIControlStateNormal];
    //    }else {
    //        cell.Data = self.data[indexPath.row];
    //        [cell.statusLabel setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_progress"] forState:UIControlStateNormal];
    //    }
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if (indexPath.section) {
            
        }
        // 删除数据源的数据,self.cellData是你自己的数据
        //        [self.cellData removeObjectAtIndex:indexPath.row];
        NSString *dgood = self.FBData[indexPath.section][indexPath.row][@"discount_id"];
        [self Delete:dgood];
        // 删除列表中数据
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";//默认文字为 Delete
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSArray *arr = self.FBData[indexPath.section];
    NSString *desc = arr[indexPath.row][@"desc"];
    if ([desc isEqualToString:@"已结束"]) {
        
    }else{
        FBHFdetailsController *VC=[FBHFdetailsController new];
        VC.discount_id = self.data[indexPath.row][@"discount_id"];
        [self.navigationController pushViewController:VC animated:NO];
    }
    
}

#pragma mark - GET


-(ActivityScreenView *)ScreenView{
    if (!_ScreenView) {
        _ScreenView = [[ActivityScreenView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, autoScaleW(50))];
        
        _ScreenView.ActivityBlock = ^(UIButton *btn, NSString *btnTitle) {
            [_ScreenView.Screenbutton setTitle:[NSString stringWithFormat:@" %@",btnTitle] forState:UIControlStateNormal];
            self.page = 1;
            self.typeInt = btn.tag;
            [self merchant_center:btn.tag];
        };
    }
    return _ScreenView;
}
-(NSMutableArray *)FBData{
    if (!_FBData) {
        _FBData= [NSMutableArray array];
    }
    return _FBData;
}
@end
