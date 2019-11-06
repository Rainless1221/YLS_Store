//
//  StoreBranchController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StoreBranchController.h"

@interface StoreBranchController ()<UICollectionViewDelegate,UICollectionViewDataSource>
/* 列表 */
@property (strong,nonatomic)UICollectionView * BranchCollection;
/* 店面数 */
@property (strong,nonatomic)NSMutableArray * StoreMun;
@end

@implementation StoreBranchController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"分店管理";
    [self merchant_center];
    [self createUI];
    
}
#pragma mark - 请求数据
-(void)merchant_center{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    NSString *branch_type =[PublicMethods  readFromUserD:@"branch_type"];
    [[FBHAppViewModel shareViewModel] get_branch_store_info:model.merchant_id andstore_id:model.store_id andbranch_type:branch_type Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];

            [self.StoreMun removeAllObjects];
            for (NSDictionary *dict in DIC[@"branch_store_info"]) {
                [self.StoreMun addObject:dict];
            }
            
            [self.BranchCollection reloadData];
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
    
    [self.view addSubview:self.BranchCollection];
    [self.BranchCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView:) name:@"BranchView" object:nil];
}
- (void)refreshTableView: (NSNotification *) notification{
    [self merchant_center];

}
#pragma mark ——————   collectionView代理方法  ——————
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.StoreMun.count+1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BranchViewCell *cell = (BranchViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"BranchViewCell" forIndexPath:indexPath];
    if (indexPath.row == self.StoreMun.count) {
        //店名
        cell.StoreName.text = @"添加分店";
        //icon
        cell.branchicon.image = [UIImage imageNamed:@"btn_add_branch_store_normal"];
        //主or分。branch_type

    }else{
        cell.addButton.hidden  = NO;
        cell.branchimage.hidden = NO;

        cell.Data = self.StoreMun[indexPath.row];
        
        cell.conversionBlock = ^{

            if (indexPath.row == self.StoreMun.count) {
                [self.navigationController pushViewController:[AddBranchController new] animated:NO];
            }else{
                AddBranchController *VC = [AddBranchController new];
                VC.Data = self.StoreMun[indexPath.row];
                [self.navigationController pushViewController:VC animated:NO];
                
            }
            

        };
        

    }
    
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.width/2-20, autoScaleW(190));
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){ScreenW,20};
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == self.StoreMun.count) {
        [self.navigationController pushViewController:[AddBranchController new] animated:NO];
    }else{

        [[WMZAlert shareInstance]showAlertWithType:AlertTypeSystemPush headTitle:@"切换店铺" textTitle:@"确定切换到该店铺?" leftHandle:^(id anyID) {
            //        取消按钮点击回调
            
        } rightHandle:^(id anyID) {
            
            UserModel *model = [UserModel getUseData];
            
            NSDictionary *UserDict = [NSDictionary dictionary];
            UserDict = self.StoreMun[indexPath.row];
//            //        确定按钮点击回调
//            UserModel *model1 = [UserModel mj_objectWithKeyValues:self.StoreMun[indexPath.row]];
//
//            //保存用户信息
//            [model1 saveUserData];
            
            NSString *branch_type = [NSString stringWithFormat:@"%@",UserDict[@"branch_type"]];
//            if ([branch_type isEqualToString:@"2"]){
                /** 主店 **/
                //        确定按钮点击回调
                UserModel *model1 = [UserModel mj_objectWithKeyValues:self.StoreMun[indexPath.row]];
                
                //保存用户信息
                [model1 saveUserData];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"conversion" object:@""];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];
                
                for (UIViewController *controller in self.navigationController.viewControllers) {
                    if ([controller isKindOfClass:[FBHStoreViewController class]]) {
                        [self.navigationController popToViewController:controller animated:YES];
                    }
                }
                return ;
//            }
           
            return;
            
            NSDictionary *dict = @{
                                   @"branch_mer_id":[NSString stringWithFormat:@"%@",UserDict[@"merchant_id"]],
                                   @"branch_store_id":[NSString stringWithFormat:@"%@",UserDict[@"store_id"]],
                                   };
            [[FBHAppViewModel shareViewModel]update_token_info_when_switch_store:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
                
                if ([resDic[@"status"] integerValue]==1) {
                    //        确定按钮点击回调
                    UserModel *model1 = [UserModel mj_objectWithKeyValues:self.StoreMun[indexPath.row]];
//                    15750753078
                    //保存用户信息
                    [model1 saveUserData];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"conversion" object:@""];
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"list_new" object:@""];

                    for (UIViewController *controller in self.navigationController.viewControllers) {
                        if ([controller isKindOfClass:[FBHStoreViewController class]]) {
                            [self.navigationController popToViewController:controller animated:YES];
                        }
                    }
                }else{
                    
                    [SVProgressHUD setMinimumDismissTimeInterval:2];
                    [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
                    
                }
                
            } andfailure:^{
                
            }];
            
            
            
        }];
        
        

    }
    
    
    
    
    
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        UICollectionReusableView *headerView = [self.BranchCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"BranchView" forIndexPath:indexPath];
        if(headerView == nil)
        {
            headerView = [[UICollectionReusableView alloc] init];
        }
        headerView.backgroundColor = [UIColor clearColor];
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0,10,ScreenW,11.5);
        label.numberOfLines = 0;
        label.textAlignment =1;
        label.text = @"点击图片切换店铺";
        label.font = [UIFont systemFontOfSize:12];
        [headerView addSubview:label];
        
        return headerView;
    }
    
    
    return nil;
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"BranchView" object:nil];
    
}
#pragma mark - 懒加载
-(UICollectionView *)BranchCollection{
    if (!_BranchCollection) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (SCREEN_WIDTH - 30) / 3;
        
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 20 + 30);
        
        // 设置列间距
        layout.minimumInteritemSpacing = 1;
        
        // 设置行间距
        layout.minimumLineSpacing = 1;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _BranchCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:layout];
        /** mainCollectionView 的布局(必须实现的) */
        _BranchCollection.collectionViewLayout = layout;
        
        //mainCollectionView 的背景色
        _BranchCollection.backgroundColor = [UIColor clearColor];
        
        //禁止滚动
        //_collectionView.scrollEnabled = NO;
        
        //设置代理协议
        _BranchCollection.delegate = self;
        
        //设置数据源协议
        _BranchCollection.dataSource = self;
        
        [_BranchCollection registerClass:[BranchViewCell class] forCellWithReuseIdentifier:@"BranchViewCell"];
        [_BranchCollection registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"BranchView"];


    }
    return _BranchCollection;
}
-(NSMutableArray *)StoreMun{
    if (!_StoreMun) {
        _StoreMun = [NSMutableArray array];
    }
    return _StoreMun;
}
@end
