//
//  FBHCPViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHCPViewController.h"
#import "CHTableViewCell.h"
#import "CHTableViewCellT.h"
#import "CHDeleTableViewCell.h"
#import "TheLabeView.h"
#import "labelView.h"

#define  TheLabe_H 36

@interface FBHCPViewController ()<UITableViewDelegate,UITableViewDataSource,ThelabelcellDelegate,LabelpullDelegate>{
    NSInteger _total_goods;
    NSInteger _total_goods1;
}
//左按钮
@property(nonatomic,weak) UIButton *leftBtn;
//右按钮
@property(nonatomic,weak) UIButton *rightBtn;
//按钮横线
@property(nonatomic,weak) UIView *leftBottomLine;
//底部视图（管理中）
@property(nonatomic,strong) UIView *bottomView;
//管理按钮
@property(nonatomic,weak) UIButton *managBtn;
//上架商品列表
@property(nonatomic,weak) UITableView *goodsTableView;
//下架商品列表
@property(nonatomic,weak) UITableView *shopsTableView;
//删除的列表
@property(nonatomic,weak) UITableView *deleTableView;
//选择的tableview,0为上架,1位下架
@property(nonatomic,assign) NSInteger isSelect;
//goodsTableView是否已经滑动过
@property(nonatomic,assign) BOOL goodsIsClips;
/**  **/
@property (nonatomic, copy) NSMutableArray *gooddata;
@property (nonatomic, copy) NSMutableArray *shopdata;
/**选择的数据*/
@property (nonatomic, strong) NSMutableArray *selectArray;
@property (strong,nonatomic)store_goodsModel * Model;

/*分页*/
@property(nonatomic,assign) NSInteger goodspage;
@property(nonatomic,assign) NSInteger shopspage;
/*头部试图*/
@property(nonatomic,strong)UIView *header;
@property(nonatomic,strong)TheLabeView *labelview;
@property (strong,nonatomic)UIView * selectBgView;
@property (strong, nonatomic) labelView    *tagList;
@property (strong,nonatomic)NSMutableArray * LabelData;
@property (strong,nonatomic)NSString * category_id;
@end

@implementation FBHCPViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.goodspage = 1;
    self.shopspage = 1;
    [self merchant_center];
    [self merchant_center1];
    [self Labelmerchant_center];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.tagList removeFromSuperview];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    //1为上架 0为下架 2为获取全部
    UserModel *model = [UserModel getUseData];
    NSString *page = [NSString stringWithFormat:@"%ld",self.goodspage];

    [[FBHAppViewModel shareViewModel]list_merchant_goods:model.merchant_id andstore_id:model.store_id andis_on_sale:@"1" andcategory_id:self.category_id andpage:page andlimit:@"50" Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
            NSDictionary *DIC=resDic[@"data"];
            if (self.goodspage ==1) {
                [self.gooddata removeAllObjects];
            }
            _total_goods = [DIC[@"total_goods"] intValue];
            self.Model = [store_goodsModel mj_objectWithKeyValues:DIC[@"store_goods"]];
            for (NSDictionary *dict in DIC[@"store_goods"]) {
                [self.gooddata addObject:dict];
            }
            
            [self.goodsTableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
-(void)merchant_center1{
    UserModel *model = [UserModel getUseData];
    NSString *page = [NSString stringWithFormat:@"%ld",self.shopspage];
    [[FBHAppViewModel shareViewModel]list_merchant_goods:model.merchant_id andstore_id:model.store_id andis_on_sale:@"0" andcategory_id:self.category_id andpage:page andlimit:@"50" Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            self.Model = [store_goodsModel mj_objectWithKeyValues:DIC[@"store_goods"]];
            if (self.shopspage ==1 ) {
                [self.shopdata removeAllObjects];

            }
            _total_goods1 = [DIC[@"total_goods"] intValue];

            for (NSDictionary *dict in DIC[@"store_goods"]) {
                [self.shopdata addObject:dict];
            }
            [self.shopsTableView reloadData];
            [self.deleTableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark - 标签请求
-(void)Labelmerchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]list_goods_category:model.merchant_id andstore_id:model.store_id  Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            
            NSDictionary *DIC=resDic[@"data"][@"goods_category"];
            //category_id
            //category_name
            [self.LabelData removeAllObjects];
            
            for (NSDictionary *dict in DIC) {
                [self.LabelData addObject:dict];
            }
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *Dict in self.LabelData) {
                [array addObject:Dict[@"category_name"]];
            }

            self.labelview = [[TheLabeView alloc]initWithFrame:CGRectMake(0, self.selectBgView.bottom, ScreenW, 36)];
            self.labelview.tagArray = self.LabelData;
            self.labelview.delagate= self;
            self.labelview.backgroundColor = UIColorFromRGB(0xE5F4FF);
            [self.labelview.pull_down addTarget:self action:@selector(pullAction:) forControlEvents:UIControlEventTouchUpInside];
            
            
            [self.view addSubview:self.labelview];
            UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.labelview.bottom, ScreenW, 1)];
            line.backgroundColor = UIColorFromRGB(0xD6EEFF);
            [self.view addSubview:line];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
/**
 *  删除按钮
 **/
-(void)DeleteButtonAction:(UIButton *)sender{
    NSMutableArray *goods = [NSMutableArray array];

    NSMutableIndexSet *insets = [[NSMutableIndexSet alloc] init];
    [[self.deleTableView indexPathsForSelectedRows] enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [insets addIndex:obj.row];
        [goods addObject: self.shopdata[obj.row][@"goods_id"]];
        
    }];
    [self.shopdata removeObjectsAtIndexes:insets];
    [self.deleTableView deleteRowsAtIndexPaths:[self.deleTableView indexPathsForSelectedRows] withRowAnimation:UITableViewRowAnimationFade];
    /** 请求删除接口 **/
//    NSLog(@"删除数组%@",goods);
    [self Delete_goods:goods];
}
#pragma mark - 删除
-(void)Delete_goods:(NSMutableArray *)goodsArr {
    
   
    
    [MBProgressHUD MBProgress:@"删除中..."];
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]delete_goods:model.merchant_id andstore_id:model.store_id andgoods_id:goodsArr Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            
            [self merchant_center1];
            self.goodsIsClips = NO;
            self.bottomView.hidden = YES;
            [self.managBtn setTitle:@"管理" forState:UIControlStateNormal];
            [self setupShopsTableView];
            
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

#pragma mark -  上架、已下架请求
-(void)sale_type:(NSString *)set_sale_type andgoods_id:(NSString *)goods_id{
    
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *dict = @{
                           @"goods_id":goods_id,
                           @"set_sale_type":set_sale_type
                           };
    
    
    [[FBHAppViewModel shareViewModel]set_goods_sale_type:model.merchant_id andstore_id:model.store_id andgoods_id:dict Success:^(NSDictionary *resDic) {
        
        
        if ([resDic[@"status"] integerValue]==1) {
            
            [self merchant_center];
            [self merchant_center1];
            
//            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家产品";
    self.goodsIsClips = NO;
    self.view.backgroundColor = MainbackgroundColor;
    /**
     *  导航栏
     */
    [self setupNav];
    /**
     * 选择栏
     */
    [self setupSelectView];
    /**
     * 上架列表
     */
    [self setupGoodsTableView];
    
    
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 28)];
    [leftbutton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    [leftbutton setTitle:@"+发布" forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [leftbutton setBackgroundImage:[UIImage imageNamed:@"btn_nav_add_product_pressed"] forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 28/2;
    [leftbutton addTarget:self action:@selector(FabuAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem=rightitem;
 
}
#pragma mark - 发布  //FBHCPfabuViewController
-(void)FabuAction{
    [self.navigationController pushViewController:[FBHCPfabuViewController new] animated:YES];
//    [self.navigationController pushViewController:[YLSAddProductController new] animated:YES];
}
#pragma mark - 选择栏
- (void)setupSelectView{
    CGFloat Bwidth = ScreenW/4;
    UIView *selectBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    selectBgView.backgroundColor = [UIColor whiteColor];
    selectBgView.layer.shadowColor = [UIColor blackColor].CGColor;
    // 设置阴影偏移量
    selectBgView.layer.shadowOffset = CGSizeMake(0,0);	
    // 设置阴影透明度
    selectBgView.layer.shadowOpacity = 0.8;
    // 设置阴影半径
    selectBgView.layer.shadowRadius = 5;
    selectBgView.clipsToBounds = NO;
    self.selectBgView = selectBgView;
    [self.view addSubview:selectBgView];
    
    //左边按钮
    UIButton *leftBtn = [[UIButton alloc]init];
    [leftBtn setTitle:@"上架中" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:18.0f];
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(clickLeftBtn:) forControlEvents:UIControlEventTouchUpInside];
    [selectBgView addSubview:leftBtn];
    leftBtn.frame = CGRectMake(0, 0, Bwidth, 33);
    leftBtn.tag = 1;
    self.leftBtn = leftBtn;
    [self.leftBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    
   
    //右边按钮
    UIButton *rightBtn = [[UIButton alloc]init];
    [rightBtn setTitle:@"已下架" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [rightBtn addTarget:self action:@selector(clickRightBtn:) forControlEvents:UIControlEventTouchUpInside];
    [rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectBgView addSubview:rightBtn];
    rightBtn.frame =CGRectMake(leftBtn.right, 0, Bwidth, 33);
    rightBtn.tag = 2;
    self.rightBtn = rightBtn;
    
    //左边底部横线
    UIView *leftBottomLine = [[UIView alloc]initWithFrame:CGRectMake(leftBtn.left+20, leftBtn.bottom, 20, 2)];
    leftBottomLine.centerX = leftBtn.centerX;
    leftBottomLine.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [leftBtn addSubview:leftBottomLine];
   
    self.leftBottomLine = leftBottomLine;

    
    //管理按钮
    UIButton *managBtn = [[UIButton alloc]init];
    [managBtn setTitle:@"管理" forState:UIControlStateNormal];
    managBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [managBtn addTarget:self action:@selector(clickmanagBtn) forControlEvents:UIControlEventTouchUpInside];
    [managBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [selectBgView addSubview:managBtn];
    managBtn.frame =CGRectMake(ScreenW - Bwidth, 0, Bwidth, 33);
    self.managBtn = managBtn;
    self.managBtn.hidden = YES;
    
    
  

}
#pragma mark - 下拉
-(void) pullAction:(UIButton *)sender{
    

    
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部",@"主食",@"推荐菜",@"汤类",@"锅煲",@"特色小食",@"时蔬",@"酒水",nil];
    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"全部",nil];
    for (NSDictionary *Dict in self.LabelData) {
        [array addObject:Dict[@"category_name"]];
    }
    [array addObject:@"其他"];

    [self.tagList removeFromSuperview];

    self.tagList = [[labelView alloc]initWithFrame:CGRectMake(0, self.labelview.bottom+1, self.labelview.width, 10)];
    self.tagList.tagArray = array;
    self.tagList.delagate = self;
    /*标签颜色*/
    self.tagList.tagColor = UIColorFromRGB(0x666666);
    /*标签背景颜色*/
    self.tagList.tagBackgroundColor = UIColorFromRGB(0xF9F9F9);
    /*选中标签颜色*/
    self.tagList.SeletagColor = UIColorFromRGB(0x3D8AFF);
    /*选中标签背景颜色*/
    self.tagList.SeletagBackgroundColor = UIColorFromRGB(0xE5F4FF);
    
    self.tagList.borderColor= UIColorFromRGB(0xDCDCDC);
    self.tagList.SeleborderColor= UIColorFromRGB(0x94C3F7);
    
    self.tagList.backgroundColor = UIColorFromRGB(0xE5F4FF);
    
    sender.selected = ! sender.selected;
    if (sender.selected == YES) {
        [self.view addSubview:self.tagList];

    }else{
        
    }


}
#pragma mark - 选中标签
-(void)Addlabelcell:(NSString *)lableString and:(NSInteger)integer{
    self.labelview.pull_down.selected = NO;
    [self.tagList removeFromSuperview];
    if (integer == 0) {
        self.category_id = @"";
        
    }else if(integer == self.LabelData.count+1){
        self.category_id =@"0";
    }else{
        self.category_id = self.LabelData[integer-1][@"category_id"];
    }
    [self merchant_center];
    [self merchant_center1];
    /* 联动菜单栏 */
    [self pulllabelcell:integer];
}
-(void)pulllabelcell:(NSInteger)integer{
    if (integer == 0) {
        self.category_id = @"";
        
    }else if(integer == self.LabelData.count+1){
        self.category_id =@"0";
    }else{
        self.category_id = self.LabelData[integer-1][@"category_id"];
    }
    [self merchant_center];
    [self merchant_center1];
}
#pragma mark - UI
-(void)createUI {

    
}
- (void)setupGoodsTableView{
    //移除元素,防止覆盖
    [self.shopsTableView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 52+TheLabe_H, ScreenW, ScreenH-52-STATUS_BAR_HEIGHT-44) style:UITableViewStylePlain];
    tableView.backgroundColor = MainbackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    [tableView registerNib:[UINib nibWithNibName:@"CHTableViewCellT" bundle:nil] forCellReuseIdentifier:@"CHTableViewCellT"];
    [tableView registerNib:[UINib nibWithNibName:@"CHDeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHDeleTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CHDeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHDeleTableViewCell"];
    [self.view addSubview:tableView];
    self.goodsTableView = tableView;
    
    tableView.defaultNoDataText = @"";
    tableView.defaultNoDataImage = [UIImage imageNamed:@"no_product_tip"];
    tableView.backgroundView = [UIView new];
    tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
//        [tableView reloadData];
    };
    
    //底部刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    tableView.mj_footer.ignoredScrollViewContentInsetBottom = kIs_iPhoneX? 60:30;
    
}
-(void)footerRereshing{
    
    self.goodspage ++;
    [self merchant_center];
    [self.goodsTableView.mj_footer  endRefreshing];
}
- (void)setupShopsTableView{
    //移除元素,防止覆盖
    [self.goodsTableView removeFromSuperview];
    [self.bottomView removeFromSuperview];
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 52+TheLabe_H, ScreenW, ScreenH-52-STATUS_BAR_HEIGHT-44) style:UITableViewStylePlain];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = MainbackgroundColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    [tableView registerNib:[UINib nibWithNibName:@"CHTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CHDeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHDeleTableViewCell"];
    [tableView registerNib:[UINib nibWithNibName:@"CHDeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHDeleTableViewCell"];
    [self.view addSubview:tableView];
    self.shopsTableView = tableView;
    
    tableView.defaultNoDataText = @"";
    tableView.defaultNoDataImage = [UIImage imageNamed:@"no_product_tip"];
    tableView.backgroundView = [UIView new];
    tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
//        self.shopdata = @[@"海胆酱焗南瓜",@"黑松露虾仁",@"越式牛仔粒",@"黑松露虾仁",@"越式牛仔粒",@"黑松露虾仁",@"越式牛仔粒"];
//        [tableView reloadData];
    };
    
    
    //底部刷新
    tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing1)];
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
    tableView.mj_footer.ignoredScrollViewContentInsetBottom = kIs_iPhoneX? 60:30;
}
-(void)footerRereshing1{
    
    self.shopspage ++;
    [self merchant_center1];
    [self.shopsTableView.mj_footer  endRefreshing];
    
}

-(void)setupBottomView{
    UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, ScreenH-(kIs_iPhoneX?199:99)-STATUS_BAR_HEIGHT, ScreenW, 49)];
    bottomView.backgroundColor = [UIColor whiteColor];
    //全选
    UIButton *QXbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    QXbutton.frame = CGRectMake(15, 0, 90, 49);
    [QXbutton setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
    [QXbutton setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
    [QXbutton setTitle:@"全选" forState:UIControlStateNormal];
    [QXbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [QXbutton addTarget:self action:@selector(BtnAction:) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:QXbutton];
    //全选文本
//    UILabel *QXlabel = [[UILabel alloc]initWithFrame:CGRectMake(68, 0, 60, 49)];
//    QXlabel.text = @"全选";
//    [bottomView addSubview:QXlabel];
    //删除
    UIButton *Dbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    Dbutton.frame = CGRectMake(ScreenW - 77, 9, 62, 32);
    [Dbutton setTitle:@"删除" forState:UIControlStateNormal];
    [Dbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    Dbutton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
    Dbutton.layer.cornerRadius = 16;
    Dbutton.layer.borderWidth = 1;
    [Dbutton addTarget:self action:@selector(DeleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [bottomView addSubview:Dbutton];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_offset(0);
        make.bottom.mas_offset(-0);
        make.height.mas_offset((kIs_iPhoneX?99:49));
    }];
    self.bottomView = bottomView;
    
}
- (void)setupDeldTableView{
    if (self.isSelect == 1) {
        //移除元素,防止覆盖
        [self.shopsTableView removeFromSuperview];
    }else{
        //移除元素,防止覆盖
        [self.goodsTableView removeFromSuperview];
    }
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 52+TheLabe_H, ScreenW, ScreenH-52-STATUS_BAR_HEIGHT-(kIs_iPhoneX ? 144:94)) style:UITableViewStylePlain];
    tableView.backgroundColor  = MainbackgroundColor;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelectionDuringEditing = YES;
    /** 允许多选 **/
    tableView.allowsMultipleSelection = YES;
    [tableView registerNib:[UINib nibWithNibName:@"CHDeleTableViewCell" bundle:nil] forCellReuseIdentifier:@"CHDeleTableViewCell"];
    [self.view addSubview:tableView];
    self.deleTableView = tableView;
    [self.deleTableView setEditing:YES animated:YES];

    [self setupBottomView];
}
#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.tableView.marrData.count;
    if (tableView == self.goodsTableView) {
        return self.gooddata.count;
    }
    return  self.shopdata.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.goodsTableView) {
        CHTableViewCellT *cell = [tableView dequeueReusableCellWithIdentifier:@"CHTableViewCellT"];
        cell.backgroundColor  = MainbackgroundColor;
        cell.Data = self.gooddata[indexPath.row];

        //下架
        cell.saleBlock = ^{
             [self sale_type:@"2" andgoods_id:[NSString stringWithFormat:@"%@",self.gooddata[indexPath.row][@"goods_id"]]];
        };
        //编辑
        cell.editorBlock = ^{
            FBHCPfabuViewController *VC = [FBHCPfabuViewController new];
//            VC.Data = self.gooddata[indexPath.row];
            VC.goodId = self.gooddata[indexPath.row][@"goods_id"];
            [self.navigationController pushViewController:VC animated:NO];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        
        
        
    }else if (tableView == self.shopsTableView){
        CHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHTableViewCell"];
        cell.goodname.text = [NSString stringWithFormat:@"%@",self.shopdata[indexPath.row]];
        cell.backgroundColor  = MainbackgroundColor;

        cell.Data = self.shopdata[indexPath.row];
        
        //上架
        cell.onlineBlock = ^{
            [self sale_type:@"1" andgoods_id:[NSString stringWithFormat:@"%@",self.shopdata[indexPath.row][@"goods_id"]]];
        };
        
        //删除
        cell.DeleteBlock = ^{
            NSMutableArray *goodsArr = [NSMutableArray array];
            [goodsArr addObject:self.shopdata[indexPath.row][@"goods_id"]];
            DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
            samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
            samView.deleteLabel.text = @"删除提醒";
            NSString *card_number = [NSString stringWithFormat:@"您是否要将本商品删除。"];
            samView.deleteText.text = card_number;
            
            samView.DeleteCardBlock = ^{
                [self Delete_goods:goodsArr];

            };
            [[UIApplication sharedApplication].keyWindow addSubview:samView];
        };
        //编辑
        cell.BianjiBlock = ^{
            FBHCPfabuViewController *VC = [FBHCPfabuViewController new];
            VC.goodId = self.shopdata[indexPath.row][@"goods_id"];
            [self.navigationController pushViewController:VC animated:NO];
        };
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
        
        
        
    }else{
       CHDeleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CHDeleTableViewCell"];
        cell.backgroundColor  = MainbackgroundColor;
        cell.Data = self.shopdata[indexPath.row];

        /** 判断下 */
        if (cell.isSelected == YES) {
            cell.accessoryType = UITableViewCellAccessoryCheckmark;
        }else{
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 30)];

    self.header = [[UIView alloc]initWithFrame:CGRectMake(10, 10, ScreenW-20, 30)];
    self.header.backgroundColor = UIColorFromRGB(0xFFEEC3);
    self.header.layer.cornerRadius = 10;
    self.header.layer.borderWidth = 1;
    self.header.layer.borderColor = UIColorFromRGB(0xFABB81).CGColor;

    [headerview addSubview:self.header];
    /*icon*/
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(5, 7, 12, 15)];
    icon.image= [UIImage imageNamed:@"icon_goodsbar_notice_yellow"];
    [self.header addSubview:icon];
    /*提示*/
    
    UILabel *munlabel= [[UILabel alloc]initWithFrame:CGRectMake(icon.right + 10, 0, self.header.width - 30, 30)];
    
    munlabel.font = [UIFont systemFontOfSize:12];
    [self.header addSubview:munlabel];
    
    if (tableView == self.goodsTableView) {
        NSString *string = [NSString stringWithFormat:@"上架商品共 %ld 件",_total_goods];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        
        NSRange range1 = [[str string] rangeOfString:@"上架商品共"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        NSRange range2 = [[str string] rangeOfString:@"件"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        NSRange range3 = [[str string] rangeOfString:[NSString stringWithFormat:@"%ld",_total_goods]];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xE1291A) range:range3];
        munlabel.attributedText = str;

    }else{
        NSString *string = [NSString stringWithFormat:@"下架商品共 %ld 件",_total_goods1];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:string];
        
        NSRange range1 = [[str string] rangeOfString:@"下架商品共"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
        NSRange range2 = [[str string] rangeOfString:@"件"];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range2];
        NSRange range3 = [[str string] rangeOfString:[NSString stringWithFormat:@"%ld",_total_goods1]];
        [str addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xE1291A) range:range3];
        munlabel.attributedText = str;
    }

    
    return headerview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.deleTableView) {
        return 170;
    }
    return 202;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.isEditing) {
        return;
    }
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self.navigationController pushViewController:[FBHgoodDetailsController new] animated:NO];

}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}


#pragma mark - 切换 上架、已下架
//上架中
-(void)clickLeftBtn:(UIButton *)sender{
    
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            self.leftBottomLine.centerX = sender.centerX;
            sender.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
            [sender setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i+1];
        but.selected = NO;
        but.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(15)];
        [but setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    }
    
    
    self.managBtn.hidden = YES;
    self.isSelect = 0;
    [self setupGoodsTableView];
    
    self.goodsIsClips = NO;
    self.bottomView.hidden = YES;
    [self.managBtn setTitle:@"管理" forState:UIControlStateNormal];
    
    self.header.hidden = NO;
}
#pragma mark - 已下架
-(void)clickRightBtn:(UIButton *)sender{
    for (int i = 0; i<2; i++) {
        if (sender.tag == i+1) {
            self.leftBottomLine.centerX = sender.centerX;
            sender.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(18)];
            [sender setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
            continue;
        }
        UIButton *but = (UIButton *)[self.view viewWithTag:i+1];
        but.selected = NO;
        but.titleLabel.font = [UIFont boldSystemFontOfSize:autoScaleW(15)];
        [but setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    }
    
    self.managBtn.hidden = NO;
    self.isSelect = 1;
    [self setupShopsTableView];

    self.header.hidden = YES;

}
#pragma mark - 管理
-(void)clickmanagBtn{
    if (self.shopdata.count == 0) {
        return;
    }
    
    if (self.isSelect == 0) {
        self.goodsIsClips = !self.goodsIsClips;
        if (self.goodsIsClips) {
            self.bottomView.hidden = NO;
            [self.managBtn setTitle:@"取消" forState:UIControlStateNormal];
            [self setupDeldTableView];

        }else{
            self.bottomView.hidden = YES;
            [self.managBtn setTitle:@"管理" forState:UIControlStateNormal];
            [self setupGoodsTableView];

        }
    }else{
        self.goodsIsClips = !self.goodsIsClips;
        if (self.goodsIsClips) {
            self.bottomView.hidden = NO;
            [self.managBtn setTitle:@"取消" forState:UIControlStateNormal];
            [self setupDeldTableView];
 
        }else{
            self.bottomView.hidden = YES;
            [self.managBtn setTitle:@"管理" forState:UIControlStateNormal];
            [self setupShopsTableView];

        }
    }
    
}
#pragma mark - 全选
- (void)BtnAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    
    if (sender.isSelected) {
        [self.shopdata enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.deleTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:idx inSection:0] animated:NO scrollPosition:UITableViewScrollPositionNone];
        }];
    }else{
        
        [self.deleTableView reloadData];

    }
    
}

#pragma mark - GET
-(NSMutableArray *)shopdata{
    if (!_shopdata) {
        _shopdata = [NSMutableArray array];
    }
    return _shopdata;
}
-(NSMutableArray *)gooddata{
    if (!_gooddata) {
        _gooddata = [NSMutableArray array];
    }
    return _gooddata;
}
- (NSMutableArray *)selectArray {
    if (!_selectArray) {
        _selectArray = [NSMutableArray array];
    }
    return _selectArray;
}
-(NSMutableArray *)LabelData{
    if (!_LabelData) {
        _LabelData = [NSMutableArray array];
    }
    return _LabelData;
}
@end
