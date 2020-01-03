//
//  YLSAddProductController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "YLSAddProductController.h"
#import "YLSAddProductView.h"
#define  ScrollView_H 899
#define  ScrollJIna_H 130

@interface YLSAddProductController ()<ThelabelDelegate,AddProductDelegate,AttriAndDelegate,ZXCollectionCellDelegate,TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate>
{
    CGFloat _View_h;
}
@property (strong,nonatomic)UIScrollView * ProductScrollView;
@property (strong,nonatomic)YLSAddProductView *  ProductView;
/*标签ID*/
@property (strong,nonatomic)NSString * category_id;
/*属性数组*/
@property (strong,nonatomic)NSMutableArray * AttributeArraty;
/*属性视图*/
@property (strong,nonatomic)UIView * AttBaseView;
/*图片展示视图*/
@property (nonatomic,strong)UICollectionView *collectionView;
/** 展示的图片数组*/
@property(nonatomic,strong)NSMutableArray * imageArr;
/** 返回的图片地址 */
@property (strong,nonatomic)NSMutableArray * UrlimageArr;
/*发布、保存按钮*/
@property (strong,nonatomic)UIButton * SaveButton;
@property (strong,nonatomic)NSString * goods_pic;

@end

@implementation YLSAddProductController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布商品";
    /**
     UI
     */
    [self createUI];
    
    if (self.goodId) {
        [self get_goods_info];
    }
    
}
- (void)get_goods_info{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_goods_info:model.merchant_id andstore_id:model.store_id andgoods_id:self.goodId Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue] == 1){
            NSDictionary *DIC=resDic[@"data"];
            
            self.ProductView.Data = DIC;
            NSString *json = [NSString stringWithFormat:@"%@",DIC[@"goods_attributes"]];
            //string转data
            NSData * jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
            //json解析
            self.AttributeArraty = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
            
            [self AddlAttri:@"" and:@"" and:self.AttributeArraty];
            
            self.category_id = [NSString stringWithFormat:@"%@",DIC[@"category_id"]];
            NSString * lableString = [NSString stringWithFormat:@"%@",DIC[@"category_name"]];
            if ([[MethodCommon judgeStringIsNull:lableString] isEqualToString:@""]) {
                
            }else{
                CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                CGFloat BtnW = rect.size.width + 20;
                CGFloat BtnH = rect.size.height + 12;
                self.ProductView.TheLabelButton.size = CGSizeMake(BtnW+25, 32);// CGRectMake(94, 9, BtnW+25, BtnH);
                [self.ProductView.TheLabelButton mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.size.mas_offset(CGSizeMake(BtnW+25, BtnH));
                }];
                [self.ProductView.TheLabelButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
                [self.ProductView.TheLabelButton setTitle:[NSString stringWithFormat:@"%@",lableString] forState:UIControlStateNormal];
                [self.ProductView.TheLabelButton setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateSelected];
                [self.ProductView.TheLabelButton setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+15, 0, -10)];
                [self.ProductView.TheLabelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];
                
                self.ProductView.TheLabelButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
                self.ProductView.TheLabelButton.backgroundColor = UIColorFromRGB(0xFCF6DE);
                self.ProductView.TheLabelButton.layer.borderWidth = 1;
                self.ProductView.TheLabelButton.layer.cornerRadius = self.ProductView.TheLabelButton.height/2;
                self.ProductView.TheLabelButton.selected = YES;
                [self.ProductView.TheLabelButton addTarget:self action:@selector(deleteLa) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            
            
            /** 图片数组 */
            self.goods_pic = [NSString stringWithFormat:@"%@",DIC[@"goods_pic"]];
            NSArray *array = [self.goods_pic componentsSeparatedByString:@","];
            
            if (array.count>=3&&array.count<9) {
                NSInteger page = self.UrlimageArr.count / 3;
                self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+125*page+_View_h);
                [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(50+_View_h);
                }];
                self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
            }else{
                self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+_View_h);
                [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(50+_View_h);
                }];
                self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
            }

            for (NSString * pic in array) {
                NSString *url = [NSString stringWithFormat:@"%@",pic];
                [self.UrlimageArr addObject:url];
            }
            [self.collectionView reloadData];

            [self.SaveButton setTitle:@"保存商品" forState:UIControlStateNormal];
            
        }else{
            
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - UI
-(void)createUI{
     [self.view addSubview:self.ProductScrollView];
    [self.ProductScrollView addSubview:self.ProductView];
  
    /** 店铺环境图片列表 */
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 70, self.ProductView.GoodPicImageView .width, 190) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.ProductView.GoodPicImageView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(70);
        make.left.right.bottom.mas_offset(0);
    }];
    
    /*发布保存按钮*/
    UIView *BottomView = [[UIView alloc] init];
    BottomView.frame = CGRectMake(0,ScreenH-159,ScreenW,59);
    BottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:BottomView];
    [BottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_offset(0);
        make.height.mas_offset(59);
    }];
    [BottomView addSubview:self.SaveButton];
    
    
}
#pragma mark - 添加标签
-(void)andTheLabel{
    TheLabelController *VC = [TheLabelController new];
    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:YES];
}
-(void)Addlabel:(NSString *)lableString and:(NSString *)category_id{
    
    if ([[MethodCommon judgeStringIsNull:lableString] isEqualToString:@""]) {
        self.category_id = @"0";
        return;
    }
    
    self.category_id = category_id;
    CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 20;
    CGFloat BtnH = rect.size.height + 12;
    self.ProductView.TheLabelButton.size = CGSizeMake(BtnW+25, 32);// CGRectMake(94, 9, BtnW+25, BtnH);
    [self.ProductView.TheLabelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(BtnW+25, BtnH));
    }];
    [self.ProductView.TheLabelButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setTitle:[NSString stringWithFormat:@"%@",lableString] forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setImage:[UIImage imageNamed:@"icn_order_cancel"] forState:UIControlStateSelected];
    [self.ProductView.TheLabelButton setImageEdgeInsets:UIEdgeInsetsMake(0, rect.size.width+15, 0, -10)];
    [self.ProductView.TheLabelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];
    
    self.ProductView.TheLabelButton.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    self.ProductView.TheLabelButton.backgroundColor = UIColorFromRGB(0xFCF6DE);
    self.ProductView.TheLabelButton.layer.borderWidth = 1;
    self.ProductView.TheLabelButton.layer.cornerRadius = self.ProductView.TheLabelButton.height/2;
    self.ProductView.TheLabelButton.selected = YES;
    [self.ProductView.TheLabelButton addTarget:self action:@selector(deleteLa) forControlEvents:UIControlEventTouchUpInside];
    
    
    
  
    
}
#pragma mark - 删除标签
-(void)deleteLa{
    self.category_id = @"0";

    NSString *lableString  =@"请选择商品标签" ;
    CGRect rect = [lableString boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 20;
    CGFloat BtnH = rect.size.height + 12;
    [self.ProductView.TheLabelButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_offset(CGSizeMake(BtnW+25, BtnH));
    }];
    [self.ProductView.TheLabelButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - 20, 0, 20)];

    [self.ProductView.TheLabelButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
    [self.ProductView.TheLabelButton setTitle:lableString forState:UIControlStateNormal];
    self.ProductView.TheLabelButton.layer.borderWidth = 0;
    self.ProductView.TheLabelButton.selected = NO;
    self.ProductView.TheLabelButton.backgroundColor = [UIColor whiteColor];
    
    
}
#pragma mark - 添加商品属性
-(void)andAttribute{
    YLSCommodityAttriController *VC = [YLSCommodityAttriController new];
    VC.delagate = self;
    VC.Data = self.AttributeArraty;
    [self.navigationController pushViewController:VC animated:YES];
    
}
-(void)AddlAttri:(NSString *)lableString and:(NSString *)category_id and:(NSMutableArray *)Array{
    [self.AttBaseView removeFromSuperview];
    _View_h = 0;
    self.AttBaseView =[[UIView alloc]init];
    [self.ProductView.AttributeView addSubview:self.AttBaseView];
    [self.AttBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(40);
        make.left.right.bottom.mas_offset(0);
    }];
    self.AttributeArraty = Array;
    
    for (int i=0; i<Array.count; i++) {
       UIView *AttView = [[UIView alloc]initWithFrame:CGRectMake(0, _View_h+5, ScreenW-30, 70)];
        
        UIView *xian = [[UIView alloc]initWithFrame:CGRectMake(95, 0, 50, 45)];
        xian.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [AttView addSubview:xian];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(95, 0, 50, 45)];
        label.text = [NSString stringWithFormat:@"%@",Array[i][@"attr_name"]];
        label.textColor = UIColorFromRGB(0x222222);
        label.font = [UIFont systemFontOfSize:18];
        label.numberOfLines = 1;
        [label sizeToFit];
        [AttView addSubview:label];
        [xian mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(label.mas_bottom).offset(0);
            make.height.mas_offset(8);
            make.left.equalTo(label.mas_left).offset(0);
            make.right.equalTo(label.mas_right).offset(0);
        }];
        
        UILabel *label1= [[UILabel alloc] initWithFrame:CGRectMake(95, label.bottom+15, AttView.width-116, 45)];
        label1.text = [NSString stringWithFormat:@"%@",Array[i][@"attr_value"]];
        label1.textColor = UIColorFromRGB(0x222222);
        label1.font = [UIFont systemFontOfSize:15];
        label1.numberOfLines = 0;
        [label1 sizeToFit];
        [AttView addSubview:label1];
        
         AttView.height = label.height +label1.height+15;
        
        _View_h = AttView.bottom;
         [self.AttBaseView addSubview:AttView];
        
    }
    
    
    if (self.UrlimageArr.count>=3&&self.UrlimageArr.count<9) {
        NSInteger page = self.UrlimageArr.count / 3;
        self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+125*page+_View_h);
        [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50+_View_h);
        }];
        self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
    }else{
        self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+_View_h);
        [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50+_View_h);
        }];
        self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
    }
    
    if (Array.count>0) {
        [self.ProductView.AttributelButton setTitle:@"编辑属性" forState:UIControlStateNormal];
        [self.ProductView.AttributelButton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        self.ProductView.AttributelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    }else{
        [self.ProductView.AttributelButton setTitle:@"添加商品属性，如辣味、甜度" forState:UIControlStateNormal];
        [self.ProductView.AttributelButton setTitleColor:UIColorFromRGB(0xCCCCCC) forState:UIControlStateNormal];
        self.ProductView.AttributelButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    
}

#pragma mark - 选择商品照片
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
        if (self.UrlimageArr.count>=3&&self.UrlimageArr.count<9) {
            NSInteger page = self.UrlimageArr.count / 3;
            self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+125*page+_View_h);
            [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(50+_View_h);
            }];
            self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
        }else{
            self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+_View_h);
            [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.height.mas_offset(50+_View_h);
            }];
            self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
        }
        for (UIImage *image in photos) {
            [self image:image andtag:sender.tag];
            
        }
        
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - 删除照片
-(void)moveImageBtnClick:(ZXCollectionCell *)aCell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
    //    NSLog(@"_____%ld",indexPath.row);
    //    [_imageArr removeObjectAtIndex:indexPath.row];
    [self.UrlimageArr removeObjectAtIndex:indexPath.row];
    if (self.UrlimageArr.count>=3&&self.UrlimageArr.count<9) {
        NSInteger page = self.UrlimageArr.count / 3;
        self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+125*page+_View_h);
        [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50+_View_h);
        }];
        self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
    }else{
        self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+_View_h);
        [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.height.mas_offset(50+_View_h);
        }];
        self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
    }
    [self.collectionView reloadData];
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
    return CGSizeMake((self.ProductView.GoodPicImageView.width-20)/3, (self.ProductView.GoodPicImageView.width-20)/3);
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
            
            if (self.UrlimageArr.count>=3&&self.UrlimageArr.count<9) {
                NSInteger page = self.UrlimageArr.count / 3;
                self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+125*page+_View_h);
                [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(50+_View_h);
                }];
                self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
            }else{
                self.ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H+_View_h);
                [self.ProductView.AttributeView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_offset(50+_View_h);
                }];
                self.ProductView.height = self.ProductScrollView.contentSize.height-ScrollJIna_H;
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

#pragma mark - 请求(发布产品)
-(void)merchant_center{
    double price = [self.ProductView.goods_price.text doubleValue];
    if ( price == 0) {
        [SVProgressHUD setMinimumDismissTimeInterval:0.1];
        [SVProgressHUD showErrorWithStatus:@"请输入正确的价格"];
        return;
    }
    [MBProgressHUD MBProgress:@"发布中..."];
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
    /*属性*/
    NSString* text = [NSString new];
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.AttributeArraty
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] && error == nil){
        text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    
    
    if (self.goodId) {
        NSDictionary *Dict = @{
                               @"goods_id":[NSString stringWithFormat:@"%@",self.goodId],
                               @"goods_name":self.ProductView.goods_name.text,
                               @"goods_price":self.ProductView.goods_price.text,
                               @"goods_num":self.ProductView.goods_num.text,
                               @"goods_description":self.ProductView.goods_Miao.text,
                               @"goods_pic":[NSString stringWithFormat:@"%@",self.goods_pic],
                               @"discount_price":[NSString stringWithFormat:@"%@",self.ProductView.discount_price.text],
                               @"category_id":self.category_id,
                               @"goods_attributes":text
                               };
        
        [[FBHAppViewModel shareViewModel]edit_goods:model.merchant_id andstore_id:model.store_id andgood:Dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
        }];
        
    }else{
        
        NSDictionary *Dict = @{
                               @"goods_name":self.ProductView.goods_name.text,
                               @"goods_price":self.ProductView.goods_price.text,
                               @"goods_num":self.ProductView.goods_num.text,
                               @"goods_description":self.ProductView.goods_Miao.text,
                               @"goods_pic":[NSString stringWithFormat:@"%@",self.goods_pic],
                               @"discount_price":[NSString stringWithFormat:@"%@",self.ProductView.discount_price.text],
                               @"category_id":self.category_id,
                               @"goods_attributes":text
                               };
        
        [[FBHAppViewModel shareViewModel]insert_goods:model.merchant_id andstore_id:model.store_id andGoodDict:Dict Success:^(NSDictionary *resDic) {
            
            if ([resDic[@"status"] integerValue]==1) {
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
    
    
}

#pragma mark - 懒加载
-(UIScrollView *)ProductScrollView{
    if (!_ProductScrollView) {
        _ProductScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ProductScrollView.backgroundColor = MainbackgroundColor;
        _ProductScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, ScrollView_H);
    }
    return _ProductScrollView;
}
-(YLSAddProductView *)ProductView{
    if (!_ProductView) {
        _ProductView = [[YLSAddProductView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, self.ProductScrollView.contentSize.height-ScrollJIna_H)];
        _ProductView.delagate = self;
    }
    return _ProductView;
}
-(UIButton *)SaveButton{
    if (!_SaveButton) {
        _SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveButton.frame = CGRectMake(42.5, 9.5, ScreenW-85, 40);
        [_SaveButton setTitle:@"立即发布" forState:UIControlStateNormal];
        _SaveButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_SaveButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
        _SaveButton.layer.cornerRadius = 20;
        _SaveButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
        [_SaveButton addTarget:self action:@selector(merchant_center) forControlEvents:UIControlEventTouchUpInside];
    }
    return _SaveButton;
}
-(NSMutableArray *)AttributeArraty{
    if (!_AttributeArraty) {
        _AttributeArraty = [NSMutableArray array];
    }
    return _AttributeArraty;
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
@end
