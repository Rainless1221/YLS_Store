//
//  FBHPreferController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/29.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "FBHPreferController.h"
#import "PreferCollectionViewCell.h"
#import "PreferReusableView.h"
#import "PrefeSetViewController.h"
#import "PhotoModel.h"

@interface FBHPreferController ()<UICollectionViewDelegate,UICollectionViewDataSource,productDelegate>
{
    NSString *_pir;
    BOOL _isGuan;
}
@property (strong,nonatomic)UICollectionView * PreferCollection;
@property (strong,nonatomic)NSMutableArray * GoodsMun;
@property (strong,nonatomic)NSMutableDictionary * GoodsMun_header;

/*底部试图*/
@property (strong,nonatomic)UIView * boomView;
@property (strong,nonatomic)UIButton * allSelectBtn;
@property (nonatomic, assign) int selectNum;
@property (nonatomic, assign) BOOL isAllSelect;

@end

@implementation FBHPreferController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"特惠详情";
    _isGuan = NO;
    [self createUI];
    //选中数量
    self.selectNum = 0;
    //全选状态
    self.isAllSelect = NO;
   
   
    [self get_preferential_detail];

    
}
#pragma mark - 请求
-(void)get_preferential_detail{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_preferential_detail:model.merchant_id andstore_id:model.store_id andpreferential_id:self.preferential_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            self.GoodsMun_header = DIC[@"pre_act_info"];

            
            NSArray *marArr = @[@"iconicn_shop_type_cycle_blue"
                                ];
            
            [self.GoodsMun removeAllObjects];
            for (NSDictionary *dict in marArr) {
                [self.GoodsMun addObject:dict];
                
            }
            for (NSDictionary *dict in DIC[@"pre_goods_info"]) {
                PhotoModel *model = [PhotoModel modelWithDictionary:dict];
                model.isSelected = @"normal";
                [self.GoodsMun addObject:model];
            }
            
           self.preferential_id =   DIC[@"pre_act_info"][@"preferential_id"];
            
            
            
            
            [self.PreferCollection reloadData];
            
        }else{
            
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}

#pragma mark - UI
-(void)createUI{
    
    [self.view addSubview:self.PreferCollection];
    [self.PreferCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.mas_offset(0);
    }];
    
    [self.view addSubview:self.boomView];
    [self.boomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_offset(0);
        make.height.mas_offset(59);
    }];
    self.boomView.hidden = YES;
    //全选
    [self.boomView addSubview:self.allSelectBtn];
    [self.allSelectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_offset(0);
        make.width.mas_offset(60);
    }];
    
    
    UIButton *SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    SaveButton.frame = CGRectMake(ScreenW-100,10,80,40);
    SaveButton.backgroundColor = [UIColor colorWithRed:255/255.0 green:47/255.0 blue:43/255.0 alpha:1.0];
    [SaveButton setTitle:@"删除" forState:UIControlStateNormal];
    [SaveButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [SaveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    SaveButton.layer.cornerRadius = 20;
    [SaveButton addTarget:self action:@selector(DeleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.boomView addSubview:SaveButton];
    
    
    //prefeSave
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(conversionAction:) name:@"prefeSave" object:nil];
    
}
- (void)conversionAction: (NSNotification *) notification {
 
    self.GoodsMun_header = notification.object;
    
//    [self.PreferCollection reloadData];
    [self get_preferential_detail];
}
#pragma mark - UICollectionViewDelegate
//返回section个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    
    
    return self.GoodsMun.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PreferCollectionViewCell *cell = (PreferCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"PreferCollectionViewCell" forIndexPath:indexPath];
    
    if (indexPath.row == 0) {
        cell.addButton.hidden  = NO;
        cell.Goodname.hidden = YES;
        cell.sedeimage.hidden = YES;
        cell.pic_Image.hidden = YES;
        cell.Goodprice.hidden = YES;
        cell.Goodprice_1.hidden = YES;
        cell.icon.hidden = YES;
        cell.icon_text.hidden = YES;

        cell.backgroundColor = [UIColor colorWithRed:212/255.0 green:229/255.0 blue:255/255.0 alpha:1.0];
        
    }else{
        cell.backgroundColor = [UIColor whiteColor];
        cell.addButton.hidden  = YES;
        cell.Goodname.hidden = NO;
        cell.sedeimage.hidden = NO;
        cell.pic_Image.hidden = NO;
        cell.Goodprice.hidden = NO;
        cell.Goodprice_1.hidden = NO;
        cell.icon.hidden = NO;
        cell.icon_text.hidden = NO;

//        cell.Data = self.GoodsMun[indexPath.row];
        
        PhotoModel *itemModel = self.GoodsMun[indexPath.row];
        [cell setCellWithModel:itemModel];
        
        
        if (_isGuan == YES) {
            cell.isguan = YES;
            for (NSIndexPath *indexPath in self.GoodsMun) {
                [collectionView deselectItemAtIndexPath:indexPath animated:NO];
                
            }
        }else{
            cell.isguan = NO;
        }
    }
    
    
    
    cell.layer.cornerRadius = 5;
    
    return cell;
}
//设置每个item的尺寸
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(self.view.width/2-20, autoScaleW(238));
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){ScreenW,215};
}
//设置每个item的UIEdgeInsets
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 15;
}
//点击item方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == 0) {
        if (_isGuan== YES) {
            return;
        }
        
        if (_pir == nil) {
            
        }else{
            FBHFBSPViewController *VC = [FBHFBSPViewController new];
            VC.discount_id = self.preferential_id;
            VC.delagate = self;
            [self.navigationController pushViewController:VC animated:NO];
        }
        
    }else{
        if (_isGuan== NO) {
            return;
        }
        
        PhotoModel *itemModel = self.GoodsMun[indexPath.row];
        itemModel.isSelected = [itemModel.isSelected isEqual:@"normal"] ? @"select" : @"normal";
        
        if ([itemModel.isSelected isEqualToString: @"select"]) {
            self.selectNum = self.selectNum + 1;
        } else {
            self.selectNum = self.selectNum - 1;
        }
        
        if (self.selectNum == self.GoodsMun.count-1) {
            self.isAllSelect = YES;
            self.allSelectBtn.selected = YES;
        } else {
            self.isAllSelect = NO;
            self.allSelectBtn.selected = NO;

        }
        
        [self.PreferCollection reloadItemsAtIndexPaths:@[indexPath]];
        
    }
 
    
}
#pragma mark - 多选

//- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//
//
//    if ([[collectionView indexPathsForSelectedItems] containsObject:indexPath]) {
//        //取消选中 返回NO，这样collectionView就不会再调用didSelectItemAtIndexPath方法
//        [collectionView deselectItemAtIndexPath:indexPath animated:YES];
//
//        return NO;
//    }
//    return YES;
//}
#pragma mark - 全选
-(void)allSelectAction:(UIButton *)sender{
    for (int i = 1; i < self.GoodsMun.count; i++) {
        PhotoModel *itemModel = self.GoodsMun[i];
        itemModel.isSelected = self.isAllSelect ? @"normal" : @"select";
        
    }
    self.isAllSelect = !self.isAllSelect;
//    [self.allSelectBtn setTitle:self.isAllSelect ? @"取消全选" : @"全选" forState:UIControlStateNormal];
    self.allSelectBtn.selected = self.isAllSelect ? YES:NO;
    [self.PreferCollection reloadData];
    
}
#pragma mark - 删除
-(void)DeleAction{
    
//    if (self.isAllSelect) {
//
//        [self.GoodsMun removeAllObjects];
//        NSArray *marArr = @[@"iconicn_shop_type_cycle_blue"
//                            ];
//
//        for (NSDictionary *dict in marArr) {
//            [self.GoodsMun addObject:dict];
//
//        }
//
//    }else {
//        for (int i = 1; i < self.GoodsMun.count; i++) {
//
//            PhotoModel *itemModel = self.GoodsMun[i];
//            if ([itemModel.isSelected isEqualToString:@"select"]) {
//                [self.GoodsMun removeObject:itemModel];
//                // 当有元素被删除的时候i的值回退1 从而抵消因删除元素而导致的元素下标位移的变化
//                i--;
//            }
//        }
//    }
    
    
    
    
    NSString *tokenString = [[NSString alloc]init];

    for (int i =1; i<self.GoodsMun.count; i++) {

        PhotoModel *itemModel = self.GoodsMun[i];
        if ([itemModel.isSelected isEqualToString:@"select"]){
            if (i == self.GoodsMun.count-1) {
                tokenString = [tokenString stringByAppendingFormat:@"%@",itemModel.p_goods_id];
            }else{
                tokenString = [tokenString stringByAppendingFormat:@"%@,",itemModel.p_goods_id];
            }
        }
    }
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"删除提醒";
    NSString *card_number = [NSString stringWithFormat:@"您是否要将选中的商品从此次活动中删除。"];
    samView.deleteText.text = card_number;
    
    samView.DeleteCardBlock = ^{
        
        [MBProgressHUD MBProgress:@"删除中..."];
        UserModel *model = [UserModel getUseData];
        
        NSDictionary *dict = @{@"preferential_id":[NSString stringWithFormat:@"%@",self.preferential_id],
                               @"p_goods_id":tokenString
                               };
        
        [[FBHAppViewModel shareViewModel]delete_preferential_goods:model.merchant_id andstore_id:model.store_id andbankDict:dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                
                
                
                
                NSLog(@"删除!!!");
                self.isAllSelect = NO;
                self.selectNum = self.isAllSelect ? (unsigned)self.GoodsMun.count : 0;
                self.allSelectBtn.selected = self.isAllSelect ? YES:NO;
                _isGuan = NO;
                self.boomView.hidden= YES;
                
                self.PreferCollection.allowsMultipleSelection = NO;
                [self.PreferCollection mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_offset(0);
                }];
                [self get_preferential_detail];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"prefeSavelist" object:nil];

                //            [self.PreferCollection reloadData];
                
            }else{
                
            }
            
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
    };
    
    
    [[UIApplication sharedApplication].keyWindow addSubview:samView];

   

    
}
#pragma mark - 头部
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    if([kind isEqualToString:UICollectionElementKindSectionHeader])
    {
        PreferReusableView *headerView = [self.PreferCollection dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"PreferReusableView" forIndexPath:indexPath];
        headerView.Data = self.GoodsMun_header;
        NSString *pir = [NSString stringWithFormat:@"%@",self.GoodsMun_header[@"discount"]];
        if ([[MethodCommon judgeStringIsNull:pir] isEqualToString:@""]) {
            
        }else{
            _pir = pir;
        }
        headerView.SetPrefeActionBlock = ^{
            PrefeSetViewController *VC = [PrefeSetViewController new];
            VC.Dict = self.GoodsMun_header;
            [self.navigationController pushViewController:VC animated:NO];
        };
        

        
        headerView.GuanPrefeActionBlock = ^(UIButton * _Nonnull guan) {
            if (self.GoodsMun.count<=1) {
                return ;
            }
            if (guan.selected == YES) {
                _isGuan = YES;
                self.boomView.hidden = NO;
                self.PreferCollection.allowsMultipleSelection = YES;
                [self.PreferCollection mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_offset(-50);
                }];
              
            }else{
                _isGuan = NO;
                self.boomView.hidden= YES;
                
                self.PreferCollection.allowsMultipleSelection = NO;
                [self.PreferCollection mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.bottom.mas_offset(0);
                }];
               
                for (int i = 1; i < self.GoodsMun.count; i++) {
                    PhotoModel *itemModel = self.GoodsMun[i];
                    itemModel.isSelected =  @"normal" ;
                    
                }
                //选中数量
                self.selectNum = 0;
                //全选状态
                self.isAllSelect = NO;
                
            }
            
            [self.PreferCollection reloadData];
        };
        

        return headerView;
    }
    
    
    return nil;
}
#pragma mark - 返回产品数据
-(void)product:(NSArray *)productArr andindexPaths:(NSArray *)indexPath{

//    for (NSDictionary *Dict in productArr) {
//        PhotoModel *model = [PhotoModel modelWithDictionary:Dict];
//        model.isSelected = @"normal";
//        [self.GoodsMun addObject:model];
//
//    }
//
//    [self.PreferCollection reloadData];
    
}
- (void)dealloc {
    //单条移除观察者
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"prefeSave" object:nil];
    
}
#pragma mark - 懒加载
-(UICollectionView *)PreferCollection{
    if (!_PreferCollection) {
        
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
        
        CGFloat itemWidth = (SCREEN_WIDTH - 30) / 3;
        
        // 设置每个item的大小
        layout.itemSize = CGSizeMake(itemWidth, itemWidth + 20 + 30);
        
        // 设置列间距
        layout.minimumInteritemSpacing = 1;
        
        // 设置行间距
        layout.minimumLineSpacing = 1;
        
        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        
        _PreferCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) collectionViewLayout:layout];
        /** mainCollectionView 的布局(必须实现的) */
        _PreferCollection.collectionViewLayout = layout;
        
        //mainCollectionView 的背景色
        _PreferCollection.backgroundColor = [UIColor clearColor];
        
        //禁止滚动
        //_collectionView.scrollEnabled = NO;
        
        //设置代理协议
        _PreferCollection.delegate = self;
        
        //设置数据源协议
        _PreferCollection.dataSource = self;
        
        [_PreferCollection registerClass:[PreferCollectionViewCell class] forCellWithReuseIdentifier:@"PreferCollectionViewCell"];
        [_PreferCollection registerClass:[PreferReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"PreferReusableView"];

    }
    
    return _PreferCollection;
}
-(UIView *)boomView{
    if (!_boomView) {
        _boomView = [[UIView alloc] init];
        _boomView.frame = CGRectMake(0,ScreenH-59,ScreenW,59);
        _boomView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _boomView;
}
- (UIButton *)allSelectBtn {
    if (!_allSelectBtn) {
        _allSelectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [_allSelectBtn setTitle:@" 全选" forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"icn_commodity_edit_unselected"] forState:UIControlStateNormal];
        [_allSelectBtn setImage:[UIImage imageNamed:@"icn_commodity_edit_selected"] forState:UIControlStateSelected];
        _allSelectBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_allSelectBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        _allSelectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        _allSelectBtn.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        [_allSelectBtn addTarget:self action:@selector(allSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _allSelectBtn;
}
-(NSMutableArray *)GoodsMun{
    if (!_GoodsMun) {
        _GoodsMun = [NSMutableArray array];
    }
    return _GoodsMun;
}
-(NSMutableDictionary *)GoodsMun_header{
    if (!_GoodsMun_header) {
        _GoodsMun_header = [NSMutableDictionary dictionary];
    }
    return _GoodsMun_header;
}

@end
