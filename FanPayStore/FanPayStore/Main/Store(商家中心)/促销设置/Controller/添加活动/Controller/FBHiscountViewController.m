
//
//  FBHiscountViewController.m
//  FanBeiHua
//
//  Created by 苹果笔记本 on 2019/4/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHiscountViewController.h"
#import "StoreDiscountView.h"
#import "ZXCollectionCell.h"

@interface FBHiscountViewController ()<UIScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,ZXCollectionCellDelegate,productDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)StoreDiscountView * scrollView;
/*good 图片列表*/
@property (nonatomic,strong)UICollectionView *collectionView;

/** id */
@property (strong,nonatomic)NSMutableArray * idimageArr;
/* 选中位置数据 */
@property (strong,nonatomic)NSArray * indexPath;
@end

@implementation FBHiscountViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    self.scrollView.height = self.SJScrollView.contentSize.height;
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-40, 106) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.scrollView.GoodView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(5);
        make.right.bottom.mas_offset(-5);
    }];
    
    
    if (self.discount_id) {
        self.navigationItem.title = @"修改翻呗活动";
        NSLog(@" 设置 : %@",self.Data_dict);
        //额度
        NSString *discount_condition = [NSString stringWithFormat:@"%@",self.Data_dict[@"discount_amount"]];
        NSInteger condition = [discount_condition integerValue];
        self.scrollView.discount_condition.text = [NSString stringWithFormat:@"%ld",condition];
        
        //时间
        NSString *begin_date = [NSString stringWithFormat:@"%@",self.Data_dict[@"begin_datetime"]];
        NSString *end_date = [NSString stringWithFormat:@"%@",self.Data_dict[@"end_datetime"]];
        
        NSString *begin_datetime = [begin_date substringFromIndex:11];
        NSString *end_datetime = [end_date substringFromIndex:11];
        
        
        /** 全天时间 */
        NSString * time1 = [begin_date substringToIndex:10];
        NSString * time2 = [end_date substringToIndex:10];
        
        
        
        if ([begin_datetime isEqualToString:@"00:00:00"] || [end_datetime isEqualToString:@"23:59:59"]) {
            
            [self.scrollView.begin_date setTitle:time1 forState:UIControlStateNormal];
            [self.scrollView.end_date setTitle:time2 forState:UIControlStateNormal];
            [self.scrollView.begin_time setTitle:begin_datetime forState:UIControlStateNormal];
            [self.scrollView.end_time setTitle:end_datetime forState:UIControlStateNormal];
            /**
             直接调用按钮事件，来设定是什么选择什么类型
             也可以在修改是判断来调用看是哪个类型
             */
            [self.scrollView DiscountAction:self.scrollView.DiscountButton1];
        }else{
            
            [self.scrollView.begin_date setTitle:time1 forState:UIControlStateNormal];
            [self.scrollView.end_date setTitle:time2 forState:UIControlStateNormal];
            
            [self.scrollView.begin_time setTitle:begin_datetime forState:UIControlStateNormal];
            [self.scrollView.end_time setTitle:end_datetime forState:UIControlStateNormal];
            /**
             直接调用按钮事件，来设定是什么选择什么类型
             也可以在修改是判断来调用看是哪个类型
             */
            [self.scrollView DiscountAction:self.scrollView.DiscountButton2];
        }
        
        
        
    }else{
        self.navigationItem.title = @"添加翻呗活动";

        /**
         直接调用按钮事件，来设定是什么选择什么类型
         也可以在修改是判断来调用看是哪个类型
         */
        [self.scrollView DiscountAction:self.scrollView.DiscountButton1];
    }
    
    
    
}

#pragma mark - 请求
-(void)merchant_center{
    //1表全天翻呗 2表限时翻呗
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict = [NSDictionary dictionary];
    if (self.scrollView.discount_type ==1) {
        Dict = @{
                 @"discount_type":[NSString stringWithFormat:@"%ld",self.scrollView.discount_type],
                 @"discount_condition":[NSString stringWithFormat:@"%@",self.scrollView.discount_condition.text],
                 @"begin_date":[NSString stringWithFormat:@"%@",self.scrollView.begin_date.titleLabel.text],
                 //                               @"begin_time":[NSString stringWithFormat:@"%@",self.scrollView.begin_time.titleLabel.text],
                 @"end_date":[NSString stringWithFormat:@"%@",self.scrollView.end_date.titleLabel.text],
                 //                               @"end_time":[NSString stringWithFormat:@"%@",self.scrollView.end_time.titleLabel.text],
                 @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                 };
    }else{
        Dict = @{
                 @"discount_type":[NSString stringWithFormat:@"%ld",self.scrollView.discount_type],
                 @"discount_condition":[NSString stringWithFormat:@"%@",self.scrollView.discount_condition.text],
                 @"begin_date":[NSString stringWithFormat:@"%@",self.scrollView.begin_date.titleLabel.text],
                 @"begin_time":[NSString stringWithFormat:@"%@",self.scrollView.begin_time.titleLabel.text],
                 @"end_date":[NSString stringWithFormat:@"%@",self.scrollView.end_date.titleLabel.text],
                 @"end_time":[NSString stringWithFormat:@"%@",self.scrollView.end_time.titleLabel.text],
                 @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                 };
    }
    
    
    
    [[FBHAppViewModel shareViewModel]insert_update_store_discount:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            /*
             *  1、获取ID
             *  2、再去请求添加产品接口
             */
            self.discount_id = DIC[@"discount_id"];
            NSString *tokenString = [[NSString alloc]init];

            for (int i =1; i<=self.idimageArr.count; i++) {
                
                NSString *urlstring = [NSString stringWithFormat:@"%@",self.idimageArr[i-1]];
                if (i == self.idimageArr.count) {
                    tokenString = [tokenString stringByAppendingFormat:@"%@",urlstring];
                }else{
                    tokenString = [tokenString stringByAppendingFormat:@"%@,",urlstring];
                }
                
            }
            [self discount_goods:tokenString];
            
//            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
}

#pragma mark - 添加产品
-(void)discount_goods:(NSString *)tokenString{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];

    //商品的id
    //    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    //    NSString * tokenString = [defaults objectForKey:@"goods_id"];
    
    UserModel *model = [UserModel getUseData];
    NSDictionary *Dict =@{
                          @"discount_id":[NSString stringWithFormat:@"%@",self.discount_id],
                          @"goods_id":[NSString stringWithFormat:@"%@",tokenString],
                          //                          @"discount_price":[NSString stringWithFormat:@"%@",self.discount_price.text],
                          };
    
    [[FBHAppViewModel shareViewModel]insert_discount_goods:model.merchant_id andstore_id:model.store_id anddiscount:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            //            NSDictionary *DIC=resDic[@"data"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];

    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    
}
#pragma mark - 返回产品数据
-(void)product:(NSArray *)productArr andindexPaths:(NSArray *)indexPath{
    self.indexPath = indexPath;
    for (NSDictionary *Dict in productArr) {
        [self.UrlimageArr addObject:Dict[@"goods_pic"]];
        [self.idimageArr addObject:Dict[@"goods_id"]];
    }
    int i = self.UrlimageArr.count/4;

    [self.scrollView.GoodView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ScreenW-30, 106+i*106));
    }];
    _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1100+i*106);   
    
    
    
    [self.collectionView reloadData];
    
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return _UrlimageArr.count+1;
    
//    return 6;
}
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify = @"cell";
    ZXCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    [cell.close setImage:[UIImage imageNamed:@"btn_delete_shop_info_image_normal"] forState:UIControlStateNormal];
    
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    if (indexPath.row == _UrlimageArr.count) {
        cell.close.hidden = YES;
        cell.imgView.image = [UIImage imageNamed:@"btn_add_marketing_product_pressed"];
    }else if(_UrlimageArr.count == 0){
        
    }else{
        if (self.discount_id) {
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr[indexPath.row]];
            //            url = [self isurl:url];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
        }else{
            
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr[indexPath.row]];
//            url = [self isurl:url];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
        }
        
        
    }
    cell.delegate = self;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((ScreenW-50)/4, (ScreenW-50)/4);
}
//定义每个UICollectionView 的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 5, 5, 5);
}
//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
        /* 跳转到商品选择 */
        FBHFBSPViewController *VC = [FBHFBSPViewController new];
        VC.delagate = self;
        VC.indexPatharray =self.indexPath;
        [self.navigationController pushViewController:VC animated:NO];
    

}
/** 删除照片 */
-(void)moveImageBtnClick:(ZXCollectionCell *)aCell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
    NSLog(@"_____%ld",indexPath.row);
    [self.UrlimageArr removeObjectAtIndex:indexPath.row];
    int i = self.UrlimageArr.count/4;
    [self.scrollView.GoodView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(ScreenW-30, 106+i*106));
    }];
    _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1100+i*106);
    
    [self.collectionView reloadData];
}
#pragma mark - GET
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1100);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(StoreDiscountView *)scrollView{
    if (!_scrollView) {
        _scrollView =[[ StoreDiscountView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-20)];
        _scrollView.layer.cornerRadius = 5;
        _scrollView.saveblock = ^{
            [self merchant_center];
        };
    }
    return _scrollView;
}
-(NSMutableArray *)UrlimageArr{
    if (!_UrlimageArr) {
        _UrlimageArr = [NSMutableArray array];
    }
    return _UrlimageArr;
}
-(NSMutableArray *)idimageArr{
    if (!_idimageArr) {
        _idimageArr = [NSMutableArray array];
    }
    return _idimageArr;
}
@end
