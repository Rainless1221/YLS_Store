//
//  FBHCPfabuViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHCPfabuViewController.h"
#import "CPFBView.h"
#import "ZXCollectionCell.h"
#define  image_H 0

@interface FBHCPfabuViewController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ZXCollectionCellDelegate,ThelabelDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;

@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)CPFBView * scrollView;
@property (strong,nonatomic)NSString * goods_pic;
/** 展示的图片数组*/
@property(nonatomic,strong)NSMutableArray * imageArr;
/** 返回的图片地址 */
@property (strong,nonatomic)NSMutableArray * UrlimageArr;
@property (strong,nonatomic)NSString * category_id;

@end

@implementation FBHCPfabuViewController

#pragma mark - 请求(发布产品)
-(void)merchant_center{
    double price = [self.scrollView.goods_price.text doubleValue];
    if ( price == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:0.1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确的价格"];
        return;
    }
    
    UserModel *model = [UserModel getUseData];
    self.goods_pic =  [NSString new];
    /** 环境图片 */
    for (int i =1; i<=self.UrlimageArr.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.UrlimageArr[i-1]];
        if (i == self.UrlimageArr.count) {
            self.goods_pic = [self.goods_pic stringByAppendingFormat:@"%@",urlstring];
        }else{
            self.goods_pic = [self.goods_pic stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    
    if (self.goodId) {
        NSDictionary *Dict = @{
                               @"goods_id":[NSString stringWithFormat:@"%@",self.goodId],
                               @"goods_name":self.scrollView.goods_name.text,
                               @"goods_price":self.scrollView.goods_price.text,
                               @"goods_num":self.scrollView.goods_num.text,
                               @"goods_description":self.scrollView.goods_description1.text,
                               @"goods_pic":[NSString stringWithFormat:@"%@",self.goods_pic],
                               @"discount_price":[NSString stringWithFormat:@"%@",self.scrollView.discount_price.text],
                               @"category_id":self.category_id
                               };
        
        [[FBHAppViewModel shareViewModel]edit_goods:model.merchant_id andstore_id:model.store_id andgood:Dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                //            NSDictionary *DIC=resDic[@"data"];
                //            UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
        } andfailure:^{
            
        }];
        
    }else{
        
        NSDictionary *Dict = @{
                               @"goods_name":self.scrollView.goods_name.text,
                               @"goods_price":self.scrollView.goods_price.text,
                               @"goods_num":self.scrollView.goods_num.text,
                               @"goods_description":self.scrollView.goods_description1.text,
                               @"goods_pic":[NSString stringWithFormat:@"%@",self.goods_pic],
                               @"discount_price":[NSString stringWithFormat:@"%@",self.scrollView.discount_price.text],
                               @"category_id":self.category_id

                               };
        
        [[FBHAppViewModel shareViewModel]insert_goods:model.merchant_id andstore_id:model.store_id andGoodDict:Dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                //            NSDictionary *DIC=resDic[@"data"];
                //            UserModel *model=[UserModel mj_objectWithKeyValues:DIC];
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            
        } andfailure:^{
            
        }];
    }
    
    
}
- (void)get_goods_info{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];

    [[FBHAppViewModel shareViewModel]get_goods_info:model.merchant_id andstore_id:model.store_id andgoods_id:self.goodId Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1){
            NSDictionary *DIC=resDic[@"data"];
            /** 商品数据不为空时，就是编辑商品 **/
//            if (self.Data) {
//                self.scrollView.goods_name.text = [NSString stringWithFormat:@"%@",DIC[@"goods_name"]];
//                self.scrollView.goods_price.text = [NSString stringWithFormat:@"%@",DIC[@"goods_price"]];
//                self.scrollView.discount_price.text = [NSString stringWithFormat:@"%@",DIC[@"discount_price"]];
//                self.scrollView.goods_num.text = [NSString stringWithFormat:@"%@",DIC[@"goods_count"]];
//            self.scrollView.goods_description1.text = [NSString stringWithFormat:@"%@",DIC[@"goods_desc"]];
//            self.scrollView.placeholderLabel.hidden=YES;
            
            self.scrollView.Data = DIC;

            self.category_id = [NSString stringWithFormat:@"%@",DIC[@"category_id"]];
            NSString * lableString = [NSString stringWithFormat:@"%@",DIC[@"category_name"]];
            if ([[MethodCommon judgeStringIsNull:lableString] isEqualToString:@""]) {
                
            }else{
                CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                CGFloat BtnW = rect.size.width + 20;
                CGFloat BtnH = rect.size.height + 10;
                self.scrollView.LabelBtn.size = CGSizeMake(BtnW+25, BtnH);
                [self.scrollView.LabelBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
                [self.scrollView.LabelBtn setTitle:[NSString stringWithFormat:@"%@",lableString] forState:UIControlStateNormal];
                [self.scrollView.LabelBtn setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateSelected];
                [self.scrollView.LabelBtn setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+15, 0, -10)];
                [self.scrollView.LabelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];
                
                self.scrollView.LabelBtn.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
                self.scrollView.LabelBtn.backgroundColor = UIColorFromRGB(0xFCF6DE);
                self.scrollView.LabelBtn.layer.borderWidth = 1;
                self.scrollView.LabelBtn.layer.cornerRadius = self.scrollView.LabelBtn.height/2;
                self.scrollView.LabelBtn.selected = YES;
                [self.scrollView.LabelBtn addTarget:self action:@selector(deleteLa) forControlEvents:UIControlEventTouchUpInside];
            }
            
            

                /** 图片数组 */
                self.goods_pic = [NSString stringWithFormat:@"%@",DIC[@"goods_pic"]];
                NSArray *array = [self.goods_pic componentsSeparatedByString:@","];
            
            if (array.count>=3) {
                self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 770+140);
                self.scrollView.height = 770+110;
            }
            
                for (NSString * pic in array) {
                    NSString *url = [NSString stringWithFormat:@"%@",pic];


                    [self.UrlimageArr addObject:url];
                }
                [self.collectionView reloadData];

                
                [self.scrollView.FBButton setTitle:@"保存商品" forState:UIControlStateNormal];
                
//            }
        }else{
            
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark -获取平台价计算公式中的费率 接口
-(void)get_plat_price_rate{
    UserModel *model = [UserModel getUseData];

    [[FBHAppViewModel shareViewModel]get_plat_price_rate:model.merchant_id andstore_id:model.store_id  Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            
            [PublicMethods writeToUserD:[NSString stringWithFormat:@"%@",DIC[@"plat_price_rate"]] andKey:@"plat_price_rate"];

            
        }else{
          
        }
        
    } andfailure:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    self.view.backgroundColor = MainbackgroundColor;
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    if (self.goodId) {
        [self get_goods_info];
    }
    
    [self createUI];
    [self get_plat_price_rate];
    
}
#pragma mark - UI
-(void)createUI{
    self.category_id = @"0";
    /** 店铺环境图片列表 */
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, self.scrollView.Imageview.width, 190) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.scrollView.Imageview addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(70);
        make.left.right.bottom.mas_offset(0);
    }];
    
}
/**
 * 选择商品照片
 */
- (void)DXXbutton:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 30;
    NSInteger widthHeight = ScreenW - 2 * left;
    NSInteger top = (ScreenH - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = YES;

    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (self.UrlimageArr.count>=3) {
            self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 770+240+image_H);
            self.scrollView.height = 680+230+image_H;
        }
        for (UIImage *image in photos) {
            [self image:image andtag:sender.tag];

        }

        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_UrlimageArr.count>=9) {
        return _UrlimageArr.count;
    }
    return _UrlimageArr.count+1;
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
    [cell sizeToFit];
    if (!cell) {
        NSLog(@"无法创建CollectionViewCell时打印，自定义的cell就不可能进来了。");
    }
    if (indexPath.row == _UrlimageArr.count) {
        cell.close.hidden = YES;
        cell.imgView.image = [UIImage imageNamed:@"btn_add_shop_info_image_normal"];
    }else if(_UrlimageArr.count == 0){
        
    }else{
        if (self.Data) {
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr[indexPath.row]];
            url = [self isurl:url];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
            
//            cell.imgView.image = [_imageArr objectAtIndex:indexPath.row];
//            cell.close.hidden = NO;
        }else{
            NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr[indexPath.row]];
            url = [self isurl:url];
            
            [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            cell.close.hidden = NO;
//            cell.imgView.image = [_imageArr objectAtIndex:indexPath.row];
//            cell.close.hidden = NO;
        }
        
        
    }
    
    //    cell.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //图片为正方形
    return CGSizeMake((self.scrollView.Imageview.width-20)/3, (self.scrollView.Imageview.width-20)/3);
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
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    [self DXXbutton:nil];
//    NSLog(@"选择%ld",indexPath.row);
}
/** 删除照片 */
-(void)moveImageBtnClick:(ZXCollectionCell *)aCell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
//    NSLog(@"_____%ld",indexPath.row);
//    [_imageArr removeObjectAtIndex:indexPath.row];
    [self.UrlimageArr removeObjectAtIndex:indexPath.row];
    if (self.UrlimageArr.count<3) {
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 770+140+image_H);
        self.scrollView.height = 630+130+image_H;
    }
    [self.collectionView reloadData];
}
#pragma mark - 判断链接
-(NSString *)isurl:(NSString *)image_pic{
    if ([PublicMethods isUrl:image_pic]) {
        
    }else{
        image_pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,image_pic];
    }
    return image_pic;
}
#pragma mark - 上传图片
-(void)image:(UIImage *)img andtag:(NSInteger)imatag{
    
    [[FBHAppViewModel shareViewModel]uploadImageWithData:img  andtype:@"1" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];

            NSString *urlstr = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
            [self.UrlimageArr addObject:urlstr];
            
            if (self.UrlimageArr.count>=3) {
                self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 770+140+image_H);
                self.scrollView.height = 680+130+image_H;
            }
            
            [self.collectionView reloadData];
            
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
}
#pragma mark - 添加标签
-(void)Addlabel:(NSString *)lableString and:(NSString *)category_id{
    
    if ([[MethodCommon judgeStringIsNull:lableString] isEqualToString:@""]) {
        self.category_id = @"0";
        return;
    }
    
    self.category_id = category_id;
    CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 20;
    CGFloat BtnH = rect.size.height + 10;
    self.scrollView.LabelBtn.size = CGSizeMake(BtnW+25, BtnH);// CGRectMake(94, 9, BtnW+25, BtnH);
    [self.scrollView.LabelBtn setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [self.scrollView.LabelBtn setTitle:[NSString stringWithFormat:@"%@",lableString] forState:UIControlStateNormal];
    [self.scrollView.LabelBtn setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateSelected];
    [self.scrollView.LabelBtn setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+15, 0, -10)];
    [self.scrollView.LabelBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];

    self.scrollView.LabelBtn.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    self.scrollView.LabelBtn.backgroundColor = UIColorFromRGB(0xFCF6DE);
    self.scrollView.LabelBtn.layer.borderWidth = 1;
    self.scrollView.LabelBtn.layer.cornerRadius = self.scrollView.LabelBtn.height/2;
    self.scrollView.LabelBtn.selected = YES;
    [self.scrollView.LabelBtn addTarget:self action:@selector(deleteLa) forControlEvents:UIControlEventTouchUpInside];

}
#pragma mark - 删除标签
-(void)deleteLa{
    self.category_id = @"0";
    self.scrollView.LabelBtn.width = 120;
    [self.scrollView.LabelBtn setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.scrollView.LabelBtn setTitle:@"请选择商品标签" forState:UIControlStateNormal];
    self.scrollView.LabelBtn.layer.borderWidth = 0;
    self.scrollView.LabelBtn.selected = NO;
    self.scrollView.LabelBtn.backgroundColor = [UIColor whiteColor];


}
#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 820+image_H);
    }
    return _SJScrollView;
}
-(CPFBView *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"CPFBView" owner:nil options:nil][0];
        _scrollView.backgroundColor = MainbackgroundColor;
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 760+image_H);
        _scrollView.ImageButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
        YBWeakSelf
        /** 选择商品图片 **/
        _scrollView.imageBlock = ^(BOOL choice, UIButton *btn) {
            [weakSelf DXXbutton:btn];
        };
        /** 发布商品 **/
        _scrollView.insertBlock = ^{
            [weakSelf merchant_center];
        };
        
        /** 选择标签 **/
        _scrollView.selectBlock = ^{
            TheLabelController *VC = [TheLabelController new];
            VC.delagate = weakSelf;
            [weakSelf.navigationController pushViewController:VC animated:YES];
        };
    }
    return _scrollView;
}
/**
 * 环境图片数组
 **/
- (NSMutableArray *)imageArr{
    if (!_imageArr) {
        _imageArr = [NSMutableArray array];
    }
    return _imageArr;
}
- (NSMutableArray *)UrlimageArr{
    if (!_UrlimageArr) {
        _UrlimageArr = [NSMutableArray array];
    }
    return _UrlimageArr;
}
-(NSString *)goods_pic{
    if (!_goods_pic) {
        _goods_pic = [[NSString alloc]init];
    }
    return _goods_pic;
}
@end
