//
//  FBHFBSPViewController.m
//  FanPayStore
//
//  Created by 苹果笔记本 on 2019/5/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHFBSPViewController.h"

@interface FBHFBSPViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)UICollectionView *collectionView;
@property (strong,nonatomic)NSMutableArray * gooddata;
/** 分页 */
@property (assign,nonatomic)NSInteger page;

@end

@implementation FBHFBSPViewController
-(NSMutableArray *)gooddata{
    if (!_gooddata) {
        _gooddata = [NSMutableArray array];
    }
    return _gooddata;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    //1为上架 0为下架 2为获取全部
    UserModel *model = [UserModel getUseData];
    NSString *page = [NSString stringWithFormat:@"%ld",self.page];
    [[FBHAppViewModel shareViewModel]list_merchant_goods:model.merchant_id andstore_id:model.store_id andis_on_sale:@"1" andcategory_id:nil andpage:page andlimit:@"150" Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            //            self.Model = [store_goodsModel mj_objectWithKeyValues:DIC[@"store_goods"]];
            
            if (self.page ==1) {
                [self.gooddata removeAllObjects];
            }
            for (NSDictionary *dict in DIC[@"store_goods"]) {
                [self.gooddata addObject:dict];
            }
            [self.collectionView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"优惠商品";
    [self createUI];
    self.page = 1;
    [self merchant_center];
    /*导航栏*/
    [self setupNav];
}
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 28)];
    [leftbutton setTitle:@"确定" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [leftbutton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    leftbutton.titleLabel.font = [UIFont systemFontOfSize:14];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];self.navigationItem.rightBarButtonItem=rightitem;
    
}

-(void)RighAction{
    //    NSLog(@"%@",self.collectionView.indexPathsForSelectedItems);
    NSArray *arr = self.collectionView.indexPathsForSelectedItems;
    NSMutableArray *idArray = [NSMutableArray array];
    NSMutableArray *idArray1 = [NSMutableArray array];
    NSString *tokenString = [[NSString alloc]init];
    for (NSIndexPath *indexPath in arr) {
        [idArray addObject:self.gooddata[indexPath.item][@"goods_id"]];
        [idArray1 addObject:self.gooddata[indexPath.item]];
    }
    for (int i =1; i<=idArray.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",idArray[i-1]];
        if (i == idArray.count) {
            tokenString = [tokenString stringByAppendingFormat:@"%@",urlstring];
        }else{
            tokenString = [tokenString stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    
    if (self.discount_id) {
        [self discount_goods:tokenString];
        if (self.delagate && [self.delagate respondsToSelector:@selector(product:andindexPaths:)]) {
            [self.delagate product:idArray1 andindexPaths:arr];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
        
    }else{
        
        
        
        if (self.delagate && [self.delagate respondsToSelector:@selector(product:andindexPaths:)]) {
            [self.delagate product:idArray1 andindexPaths:arr];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    
    
    
}
#pragma mark - UI
-(void)createUI{
    /**
     创建layout(布局)
     UICollectionViewFlowLayout 继承与UICollectionLayout
     对比其父类 好处是 可以设置每个item的边距 大小 头部和尾部的大小
     */
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    
    CGFloat itemWidth = (SCREEN_WIDTH - 30) / 3;
    
    // 设置每个item的大小
    layout.itemSize = CGSizeMake(itemWidth, itemWidth + 20 + 30);
    
    // 设置列间距
    layout.minimumInteritemSpacing = 1;
    
    // 设置行间距
    layout.minimumLineSpacing = 1;
    
    //每个分区的四边间距UIEdgeInsetsMake
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    //
    // 设置Item的估计大小,用于动态设置item的大小，结合自动布局（self-sizing-cell）
    //layout.estimatedItemSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置布局方向(滚动方向)
    //        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    // 设置头视图尺寸大小
    //layout.headerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    
    // 设置尾视图尺寸大小
    //layout.footerReferenceSize = CGSizeMake(<#CGFloat width#>, <#CGFloat height#>);
    //
    // 设置分区(组)的EdgeInset（四边距）
    //layout.sectionInset = UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>);
    //
    // 设置分区的头视图和尾视图是否始终固定在屏幕上边和下边
    //        layout.sectionFootersPinToVisibleBounds = YES;
    //        layout.sectionHeadersPinToVisibleBounds = YES;
    
    /**
     初始化mainCollectionView
     设置collectionView的位置
     */
    _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:layout];
    
    /** mainCollectionView 的布局(必须实现的) */
    _collectionView.collectionViewLayout = layout;
    
    //mainCollectionView 的背景色
    _collectionView.backgroundColor = [UIColor clearColor];
    
    //禁止滚动
    //_collectionView.scrollEnabled = NO;
    
    //设置代理协议
    _collectionView.delegate = self;
    
    //设置数据源协议
    _collectionView.dataSource = self;
    //多选
    _collectionView.allowsMultipleSelection = YES;
    /**
     四./注册cell
     在重用池中没有新的cell就注册一个新的cell
     相当于懒加载新的cell
     定义重用标识符(在页面最上定义全局)
     用自定义的cell类,防止内容重叠
     注册时填写的重用标识符 是给整个类添加的 所以类里有的所有属性都有重用标识符
     */
    //[_collectionView registerClass:<#(nullable Class)#> forCellWithReuseIdentifier:<#(nonnull NSString *)#>];
    
    //    UINib *nib = [UINib nibWithNibName:@"SZCollectionViewCell" bundle:[NSBundle mainBundle]];
    //    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"SZCollectionViewCell"];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"SZCollectionViewCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"SZCollectionViewCell"];
    
    //注册头部(初始化头部)
    //[_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>];
    
    //注册尾部
    //[_collectionView registerClass:<#(nullable Class)#> forSupplementaryViewOfKind:<#(nonnull NSString *)#> withReuseIdentifier:<#(nonnull NSString *)#>];
    
    [self.view addSubview:self.collectionView];
    
    
    /** 底部刷新 **/
    self.collectionView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(footerRereshing)];
    
    
    
}
-(void)footerRereshing{
    self.page ++;
    [self merchant_center];
    [self.collectionView.mj_footer endRefreshing];
}
#pragma mark - 添加
-(void)discount_goods:(NSString *)tokenString{
    
    UserModel *model = [UserModel getUseData];
    NSDictionary *dict =@{
                          @"preferential_id":[NSString stringWithFormat:@"%@",self.discount_id],
                          @"goods_id":[NSString stringWithFormat:@"%@",tokenString],
                          //                          @"discount_price":[NSString stringWithFormat:@"%@",self.discount_price.text],
                          };
    
    [[FBHAppViewModel shareViewModel]insert_preferential_goods:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];

            [[NSNotificationCenter defaultCenter] postNotificationName:@"prefeSave" object:nil];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"prefeSavelist" object:nil];

            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
    
    
    return;
#pragma mark - 之前的翻倍活动
    //商品的id
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString * tokenString = [defaults objectForKey:@"goods_id"];
    
    NSDictionary *Dict =@{
                          @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                          @"goods_id":[NSString stringWithFormat:@"%@",tokenString],
                          //                          @"discount_price":[NSString stringWithFormat:@"%@",self.discount_price.text],
                          };
    
    [[FBHAppViewModel shareViewModel]insert_discount_goods:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            //            NSDictionary *DIC=resDic[@"data"];
            
            
            [self.navigationController popViewControllerAnimated:YES];
            //            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
}
#pragma mark ——————   collectionView代理方法  ——————
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.gooddata.count;
    //    return 6;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    SZCollectionViewCell *cell = (SZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"SZCollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.Data = self.gooddata[indexPath.row];
    
    for (NSIndexPath *indexPath in self.indexPatharray) {
        [collectionView deselectItemAtIndexPath:indexPath animated:NO];
        
    }
    
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.width/2-20, 290);
    
}
//footer的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(10, 10);
//}
//header的size
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
//    return CGSizeMake(KScreenWidth, KScreenHeight + H_(60));
//}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(5, 15, 0, 15);
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 5;
}
//头部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"reusableView" forIndexPath:indexPath];
    headerView.backgroundColor = [UIColor grayColor];
    return headerView;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
}
#pragma mark - 多选

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if ([[collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
        //取消选中 返回NO，这样collectionView就不会再调用didSelectItemAtIndexPath方法
        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
        
        return NO;
    }
    return YES;
}

@end
