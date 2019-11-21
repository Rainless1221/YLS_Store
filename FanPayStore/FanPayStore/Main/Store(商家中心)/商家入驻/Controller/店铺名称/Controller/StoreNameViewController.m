//
//  StoreNameViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StoreNameViewController.h"

@interface StoreNameViewController ()<TZImagePickerControllerDelegate,NameOfShopDelegate>

@end

@implementation StoreNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺介绍";
    /*UI*/
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.StoreView];
    /**
     * 导航栏
     */
    [self setupNav];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(storeAction:) name:@"store_category" object:nil];

}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton= [UIButton buttonWithType:UIButtonTypeCustom];
    leftbutton.frame = CGRectMake(0, 0, 60, 40);
    [leftbutton setTitle:@"马上开店" forState:UIControlStateNormal];
    [leftbutton setTitle:@"确定" forState:UIControlStateSelected];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];self.navigationItem.rightBarButtonItem=rightitem;
    
    insert_storeM *model = [insert_storeM getUseData];
    NSString *ginfo = [PublicMethods readFromUserD:@"get_store_application_info"];
    if (self.Data_dict.count>0) {
        leftbutton.selected = YES;
    }
    if ([ginfo isEqualToString:@"1"]){
        /** logo */
        self.store_logo = [NSString stringWithFormat:@"%@",model.store_logo];
        NSString *url = [NSString stringWithFormat:@"%@",self.store_logo];
        if ([[MethodCommon judgeStringIsNull:self.store_logo] isEqualToString:@""]){
            
        }else{
            if ([PublicMethods isUrl:self.store_logo]) {
                
            }else{
                url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,self.store_logo];
            }
            [self.StoreView.logoButton setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"icn_shop_type_cycle_blue"]];

        }
        /**
         店铺名称
         */
        if ([[MethodCommon judgeStringIsNull:model.store_name] isEqualToString:@""]){
            
        }else{
            self.StoreView.store_name.text = [NSString stringWithFormat:@"%@",model.store_name];
        }
        /**
         经营类型
         */
        self.category_id = [NSString stringWithFormat:@"%@",model.category_id];
        self.sec_category_id = [NSString stringWithFormat:@"%@",model.sec_category_id];
        if ([[MethodCommon judgeStringIsNull:self.category_id] isEqualToString:@""]){
            
        }else{
            NSString *category_name  = [NSString stringWithFormat:@"%@",model.category_name];
            if ([[MethodCommon judgeStringIsNull:category_name] isEqualToString:@""]){
            }else{
                [self.StoreView.store_category setTitle:[NSString stringWithFormat:@" %@",category_name] forState:UIControlStateNormal];
                self.StoreView.store_category.selected = YES;
            }
            
            
            NSString *pic = [NSString stringWithFormat:@"%@",model.category_pic];
            if ([[MethodCommon judgeStringIsNull:category_name] isEqualToString:@""]) {
                
            }else{
                if ([PublicMethods isUrl:pic]) {
                    
                }else{
                    pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,pic];
                }
                
                
                NSString *imageUrl = [pic stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                
                [self.StoreView.store_category sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icn_shop_type_cycle_blue"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

                    UIImage *refined = [UIImage imageWithCGImage:image.CGImage scale:4 orientation:image.imageOrientation];

                    
                    [self.StoreView.store_category setImage:refined forState:UIControlStateNormal];
                }];

            }
            
        }
        
        
    }else if ([ginfo isEqualToString:@"2"]){
        
        
    }
    
    
}
/** 开店、保存店铺基本信息 */
-(void)RighAction{
//    [self.view endEditing:YES];
    NSLog(@"%@",self.StoreView.store_name.text);
    if (self.StoreView.store_name.text==nil||self.StoreView.store_name.text.length==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请填写店铺名称"];
        return;
    }else if (self.category_id == nil || self.category_id.length == 0){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请选择经营类型"];
        return;
    }
    
    /**
     *  判断店铺名称
     */
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]is_exist_store_name:model.merchant_id andstore_name:self.StoreView.store_name.text Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            //is_exist_store_name   1表示店铺名称已存在 0表示店铺名称不存在
            NSDictionary *DIC=resDic[@"data"];
            
            NSString *is_store_name = [NSString stringWithFormat:@"%@",DIC[@"is_exist_store_name"]];
            
            if ([is_store_name isEqualToString:@"1"]) {
                
                if (self.Data_dict.count>0) {
                    [self Get_store_name];
                    
                }else{
                    [SVProgressHUD setMinimumDismissTimeInterval:2];
                    [SVProgressHUD showErrorWithStatus:@"店铺名称已存在,请更换名称"];
                }
            }else{
                [self Get_store_name];
            }
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
    
}
-(void)Get_store_name{
    
    if (self.Data_dict.count>0) {
        UserModel *model = [UserModel getUseData];
        NSDictionary *dict = @{
                               @"store_name":[NSString stringWithFormat:@"%@",self.StoreView.store_name.text],
                               @"store_logo":[NSString stringWithFormat:@"%@",self.store_logo],
                               @"category_id":[NSString stringWithFormat:@"%@",self.category_id],
                               @"sec_category_id":[NSString stringWithFormat:@"%@",self.sec_category_id],
                               };
        [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:dict Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"等待信息审核中"];

                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
        } andfailure:^{
            
        }];
        
    }else{
        insert_storeM *model1 = [insert_storeM getUseData];
        
        NSDictionary *dict = @{
                               @"store_name":[NSString stringWithFormat:@"%@",self.StoreView.store_name.text],
                               @"store_logo":[NSString stringWithFormat:@"%@",self.store_logo],
                               @"category_id":[NSString stringWithFormat:@"%@",self.category_id],
                               @"sec_category_id":[NSString stringWithFormat:@"%@",self.sec_category_id],
                               @"category_name":[NSString stringWithFormat:@"%@",self.StoreView.store_category.titleLabel.text],
                               
                               @"store_address":[NSString stringWithFormat:@"%@",model1.store_address],
                               @"lon":[NSString stringWithFormat:@"%@",model1.lon],
                               @"lat":[NSString stringWithFormat:@"%@",model1.lat],
                               @"specific_location":[NSString stringWithFormat:@"%@",model1.specific_location],
                               @"reminder":[NSString stringWithFormat:@"%@",model1.reminder],
                               @"reminder2":[NSString stringWithFormat:@"%@",model1.reminder2],
                               @"merchant_name":[NSString stringWithFormat:@"%@",model1.merchant_name],
                               @"merchant_mobile":[NSString stringWithFormat:@"%@",model1.merchant_mobile],
                               @"merchant_telephone":[NSString stringWithFormat:@"%@",model1.merchant_telephone],
                               @"door_face_pic":[NSString stringWithFormat:@"%@",model1.door_face_pic],
                               @"store_environment_pics":[NSString stringWithFormat:@"%@",model1.store_environment_pics],
                               
                               @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",model1.hand_held_ID_card_pic],
                               @"business_license_pic":[NSString stringWithFormat:@"%@",model1.business_license_pic],
                               @"business_permit_pic":[NSString stringWithFormat:@"%@",model1.business_permit_pic],
                               
                               @"business_hours":[NSString stringWithFormat:@"%@",model1.business_hours],
                               @"business_times":[NSString stringWithFormat:@"%@",model1.business_times],
                               };
        
        /** 入驻填写的信息保存起来 */
        insert_storeM * model = [insert_storeM mj_objectWithKeyValues:dict];
        [model saveUserData];
        [self.navigationController pushViewController:[StoreInformationController new] animated:YES];
        
    }
}
#pragma mark - 选logo图
-(void)logoAction:(UIButton *)sender{
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
//    TZImagePickerController *imagePickerVc = [TZImagePickerController alloc]initCropTypeWithAsset:<#(PHAsset *)#> photo:<#(UIImage *)#> completion:<#^(UIImage *cropImage, PHAsset *asset)completion#>;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = NO;
    imagePickerVc.notScaleImage = YES;
    
    // 设置竖屏下的裁剪尺寸
    NSInteger left = 15;
    NSInteger widthHeight = ScreenW - 2 * left;
    NSInteger top = (ScreenH - widthHeight) / 2;
    imagePickerVc.cropRect = CGRectMake(left, top, widthHeight, widthHeight);
    imagePickerVc.scaleAspectFillCrop = NO;
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        [self.StoreView.logoButton setImage:photos[0] forState:UIControlStateNormal];
//        [self.StoreView.logoButton setBackgroundImage:photos[0] forState:UIControlStateNormal];
        [self image:photos[0]];
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
#pragma mark - 传图片
-(void)image:(UIImage *)img{
    
    [[FBHAppViewModel shareViewModel]uploadImageWithData:img andtype:@"1" Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            self.store_logo = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
}




#pragma mark - 选择经营类型
-(void)store_category:(UIButton *)sender{
    [self.navigationController pushViewController:[ManagementTypesController new] animated:NO];
}
-(void)storeAction:(NSNotification *) notification{

    NSDictionary *dict = [NSDictionary dictionary];
    dict = [notification object];

    NSString *title = [NSString stringWithFormat:@" %@",dict[@"category_name"]];

    [self.StoreView.store_category setTitle:title forState:UIControlStateNormal];
    self.StoreView.store_category.selected = YES;
    
    NSString *imag = [NSString stringWithFormat:@"%@",dict[@"category_pic"]];
    NSString *imageUrl = [imag stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [self.StoreView.store_category sd_setImageWithURL:[NSURL URLWithString:imageUrl] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"icn_shop_type_cycle_blue"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
        UIImage *refined = [UIImage imageWithCGImage:image.CGImage scale:4 orientation:image.imageOrientation];
        
        
        [self.StoreView.store_category setImage:refined forState:UIControlStateNormal];
    }];

    self.category_id = [NSString stringWithFormat:@"%@",dict[@"categoryId"]];
    self.sec_category_id = [NSString stringWithFormat:@"%@",dict[@"sec_category_id"]];
    
}
#pragma mark -移除观察者
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"store_category" object:nil];
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 603);
    }
    return _SJScrollView;
}
-(NameOfShop *)StoreView{
    if (!_StoreView) {
        _StoreView = [[NameOfShop alloc]initWithFrame:CGRectMake(autoScaleW(15), autoScaleW(15), ScreenW-autoScaleW(30), autoScaleW(500))];
        _StoreView.backgroundColor = [UIColor whiteColor];
        _StoreView.layer.cornerRadius = 5;
        _StoreView.delagate = self;
    }
    return _StoreView;
}
@end
