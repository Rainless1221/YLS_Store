//
//  FBHFdetailsController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHFdetailsController.h"

@interface FBHFdetailsController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)UITableView *TableView;
@property (strong,nonatomic)FdetailsHead * HeadView;
@property (strong,nonatomic)NSMutableArray * data;
@property (strong,nonatomic)NSArray * Headdata;
@end

@implementation FBHFdetailsController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict =@{
                          @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                          @"page":@"1",
                          @"limit":@"150",
                          };
    
    [[FBHAppViewModel shareViewModel]list_store_discount_goods:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            [self.data removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_discount_goods"]) {
                [self.data addObject:dict];
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
    
    NSDictionary *dict =@{
                          @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                          };
    [[FBHAppViewModel shareViewModel]detail_goods_discount:model.merchant_id andstore_id:model.store_id anddiscount:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]== 1) {
            NSDictionary *DIC=resDic[@"data"];
            self.HeadView.Data = DIC[@"goods_discount_info"];
            //            self.Headdata = DIC[@"goods_discount_info"];
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
#pragma mark - 删除
-(void)Delete:(NSString *)Dgoodid{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将本商品删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        NSDictionary *Dict =@{
                              @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                              @"d_goods_id":Dgoodid,
                              };
        [[FBHAppViewModel shareViewModel]delete_discount_goods:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                [self merchant_center];
                
                
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
    self.navigationItem.title = @"翻呗详情";
    /**
     重新返回按钮
     */
    FL_Button *backBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"" forState:UIControlStateNormal];
    [backBtn setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    //样式
    backBtn.status = FLAlignmentStatusImageLeft;
    backBtn.fl_padding = 10;
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    backBtn.frame = CGRectMake(0, 0, 60, 40);
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
    
    [self createUI];
    
    
    
}
-(void)backBtnClicked{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FBHSZViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }
}
#pragma mark - UI
-(void)createUI{
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-STATUS_BAR_HEIGHT-(kIs_iPhoneX ? 132:95)  ) style:UITableViewStyleGrouped];
    tableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    [tableView registerNib:[UINib nibWithNibName:@"FdetailsTableViewCell" bundle:nil] forCellReuseIdentifier:@"FdetailsTableViewCell"];
    //    [tableView registerNib:[UINib nibWithNibName:@"FBHSZTableViewCell" bundle:nil] forCellReuseIdentifier:@"FBHSZTableViewCell"];
    self.HeadView =
    [[NSBundle mainBundle] loadNibNamed:@"FdetailsHead" owner:nil options:nil][0];
    self.HeadView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 240);
    self.HeadView.backgroundColor = [UIColor clearColor];
    tableView.tableHeaderView = self.HeadView;
    YBWeakSelf
    self.HeadView.ModifyBlock = ^(UIButton *btn) {
        FBHiscountViewController *VC = [FBHiscountViewController new];
        VC.discount_id = weakSelf.discount_id;
        VC.Data_dict = weakSelf.HeadView.Data;
        //        VC.typeString = @"1";
        for (NSDictionary *dict in weakSelf.data) {
            [VC.UrlimageArr addObject:dict[@"goods_pic"]];
        }
        [weakSelf.navigationController pushViewController:VC animated:NO];
    };
    
    [self.view addSubview:tableView];
    self.TableView = tableView;
    
    tableView.defaultNoDataText = @"还没有优惠产品哦~";
    tableView.defaultNoDataImage = [UIImage imageNamed:@"no_fanbei_product_tip"];
    tableView.backgroundView = [UIView new];
    tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
    };
    
    //添加按钮
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton setTitle:@"  添加优惠商品" forState:UIControlStateNormal];
    addButton.titleLabel.font = [UIFont systemFontOfSize:16];
    [addButton setImage:[UIImage imageNamed:@"icn_fanbei_add_product"] forState:UIControlStateNormal];
    [addButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
    addButton.layer.cornerRadius = 10;
    [addButton addTarget:self action:@selector(AllgoodAction:) forControlEvents:UIControlEventTouchUpInside];
    [addButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.view addSubview:addButton];
    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(kIs_iPhoneX ? -35:-10);
        make.height.mas_offset(40);
    }];
    
    
    //    self.AddButton.frame = CGRectMake(15, ScreenH - (kIs_iPhoneX ? 132+STATUS_BAR_HEIGHT:95+STATUS_BAR_HEIGHT), ScreenW - 30, 44);
    
    
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    FdetailsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FdetailsTableViewCell"];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.Data = self.data[indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 110;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        // 删除数据源的数据,self.cellData是你自己的数据
        //        [self.cellData removeObjectAtIndex:indexPath.row];
        NSString *dgood = self.data[indexPath.row][@"d_goods_id"];
        [self Delete:dgood];
        // 删除列表中数据
        //        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
}
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"";//默认文字为 Delete
}
-(void)tableView:(UITableView *)tableView willBeginEditingRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (UIView *subview in tableView.subviews) {
        if ([NSStringFromClass([subview class]) isEqualToString:@"UISwipeActionPullView"]) {
            if ([NSStringFromClass([subview.subviews[0] class]) isEqualToString:@"UISwipeActionStandardButton"]) {
                
                //                subview.subviews[0].backgroundColor = [UIColor colorWithHexString:@"#FF556A"];
                UIImageView * imgV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icn_delete_white"]];
                imgV.centerX = 40;imgV.centerY = 50;
                [subview.subviews[0] addSubview:imgV];
            }
        }
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
#pragma mark - 添加优惠商品
- (IBAction)AllgoodAction:(id)sender {
    FBHFBSPViewController *VC = [FBHFBSPViewController new];
    VC.discount_id = self.discount_id;
    [self.navigationController pushViewController:VC animated:NO];
}

#pragma mark - 懒加载
-(NSMutableArray *)data{
    if (!_data) {
        _data = [NSMutableArray array];
    }
    return _data;
}@end
