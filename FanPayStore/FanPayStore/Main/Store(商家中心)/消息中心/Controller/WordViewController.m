//
//  WordViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//  消息中心

#import "WordViewController.h"
#import "WordTableViewCell.h"

@interface WordViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * WordTableView;
@property (strong,nonatomic)NSMutableArray * WordData;

@property (strong,nonatomic)UIScrollView * SJScrollView;
/** 信息类型数据 */
@property (strong,nonatomic)NSMutableArray * Data;
@property (strong,nonatomic)NSString * total_unread_news_num;
@property (strong,nonatomic)YYLabel *protocolContent ;
@end

@implementation WordViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.total_unread_news_num = @"0";

    self.navigationItem.title = @"";
    NSArray *marArr = @[@{@"icon":@"icn_msg_cnenter_system",
                          @"label":@"系统公告"
                          },
                        @{@"icon":@"icn_msg_cnenter_service",
                          @"label":@"客服助手"},
                        @{@"icon":@"icn_msg_cnenter_notice",
                          @"label":@"通知消息"},
                        @{@"icon":@"icn_msg_cnenter_cashier",
                          @"label":@"收银台"},
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.WordData addObject:dict];
        [self.Data addObject:dict];
        
    }
     [MBProgressHUD MBProgress:@"数据加载中..."];
    // 并发队列的创建方法
    dispatch_queue_t queue_B = dispatch_queue_create("net.bujige.testQueue", DISPATCH_QUEUE_CONCURRENT);
    // 异步执行任务创建方法
    dispatch_async(queue_B, ^{
          [self merchant_center];
        NSLog(@"信息线程---%@",[NSThread currentThread]);      // 打印当前线程
    });
    
   
  

    /**
     *  UI
     */
    [self createUI];
    
    [self setupNav];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 60, 44);
    [leftbutton setTitle:@"消息" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:20];
    UIBarButtonItem *lefttitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.leftBarButtonItem = lefttitem;
    
    UIButton *rightbutton = [UIButton buttonWithType:UIButtonTypeCustom];
    rightbutton.frame = CGRectMake(ScreenW-9-80, STATUS_BAR_HEIGHT, 80, 44);
    [rightbutton setTitle:@"全部忽略" forState:UIControlStateNormal];
    [rightbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    rightbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    [rightbutton addTarget:self action:@selector(HLAction) forControlEvents:UIControlEventTouchUpInside];

    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:rightbutton];
    self.navigationItem.rightBarButtonItem = rightitem;

    
}
/*全部忽略*/
-(void)HLAction{
    UserModel *model = [UserModel getUseData];
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",model.store_id]] isEqualToString:@""]) {

    }else{
        [dict setObject:model.store_id forKey:@"store_id"];
    }
   
    
    [[FBHAppViewModel shareViewModel]set_news_read:model.merchant_id andDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1){
            dispatch_async(dispatch_get_main_queue(), ^{
                self.navigationController.tabBarItem.badgeValue = nil;
            });
        }
        
    } andfailure:^{
        
    }];
    dispatch_async(dispatch_get_main_queue(), ^{
        self.navigationController.tabBarItem.badgeValue = nil;
    });
     [self merchant_center];

}
#pragma mark - 请求
-(void)merchant_center{
    
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]list_news:model.merchant_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC[@"news_info"]) {
                [self.Data addObject:dict];
            }
//            self.scrollView.Data = DIC;
            self.total_unread_news_num = [NSString stringWithFormat:@"%@",DIC[@"total_unread_news_num"]];
//            NSString *protocol = [NSString stringWithFormat:@"%@条未读消息",self.total_unread_news_num];
//            NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
//            //设置字体颜色
//            [attri_str setFont:[UIFont systemFontOfSize:15]];
//            [attri_str setColor:[UIColor colorWithHexString:@"3D8AFF"]];
//            NSRange ProRange = [protocol rangeOfString:@"条未读消息"];
//
//            [attri_str setFont:[UIFont systemFontOfSize:15] range:NSMakeRange(0, 3)];
//            [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"222222"] backgroundColor:[UIColor whiteColor] userInfo:nil];
//            self.protocolContent.attributedText = attri_str;
//            self.protocolContent.numberOfLines = 0;
//            [ self.protocolContent sizeToFit];
            
            /*信息角标*/
            if ([self.total_unread_news_num isEqualToString:@"0"]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarItem.badgeValue = nil;
                });
            }else{
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.navigationController.tabBarItem.badgeValue = self.total_unread_news_num;
                    
                });
            }
            [self.WordTableView reloadData];
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
    
    [self.view addSubview:self.WordTableView];
    [self.WordTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.top.mas_offset( 0);
    }];
    
    //list_new
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"list_new" object:nil];
    
}
- (void)conversionAction: (NSNotification *) notification {
    [self merchant_center];
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"list_new" object:nil];
    
}
-(void)headerRereshing{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    [self merchant_center];
    [self.WordTableView.mj_header endRefreshing];
}
#pragma mark - UITableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.WordData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WordTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WordTableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.Data = self.WordData[indexPath.row];
    cell.TableData = self.Data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(25,520.5,325,0.5);
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    if (indexPath.row==self.Data.count-1) {
        
    }else{
        [cell.CellBase addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(0);
            make.height.mas_offset(1);
        }];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  15.001;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];

    header_View.backgroundColor =[UIColor clearColor];

    return header_View;
    
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *num = [NSString stringWithFormat:@"%@",self.Data[indexPath.row][@"unread_news_num"]];
    
    FBHinformViewController *VC = [FBHinformViewController new];
    if (indexPath.row == 0) {
        VC.navigationItemText = @"系统公告";
        VC.news_type = @"1";
    }else if (indexPath.row == 1){
        VC.navigationItemText = @"客服助手";
        VC.news_type = @"2";

    }else if (indexPath.row == 2){
        VC.navigationItemText = @"通知消息";
        VC.news_type = @"3";
    }else{
        VC.navigationItemText = @"收银台";
        VC.news_type = @"4";
    }
    VC.Num = [num integerValue];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];

    [self.navigationController pushViewController:VC animated:NO];
    
    
}
#pragma mark - 懒加载
-(UITableView *)WordTableView{
    if (!_WordTableView) {
        _WordTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _WordTableView.delegate = self;
        _WordTableView.dataSource = self;
        _WordTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        [_WordTableView registerClass:[WordTableViewCell class] forCellReuseIdentifier:@"WordTableViewCell"];
        _WordTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
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
        _WordTableView.mj_header = header;
        
    }
    return _WordTableView;
}


-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 670);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}

-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
-(NSMutableArray *)WordData{
    if (!_WordData) {
        _WordData = [NSMutableArray array];
    }
    return _WordData;
}
@end
