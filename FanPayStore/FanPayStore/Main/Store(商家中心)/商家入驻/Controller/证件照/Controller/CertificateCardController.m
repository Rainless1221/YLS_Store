//
//  CertificateCardController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CertificateCardController.h"

@interface CertificateCardController ()<UIScrollViewDelegate,TZImagePickerControllerDelegate,sampleDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)CertificateCardView * scrollView;
@property (strong,nonatomic)insert_storeM * model;

/*
 提交按钮
 */
@property (strong,nonatomic)UIButton *leftbutton;

@end

@implementation CertificateCardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"店铺信息";
    self.view.backgroundColor = MainbackgroundColor;
    /**
     * 导航栏
     */
    [self setupNav];
    /**
     * UI
     */
    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIButton *leftbutton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 28)];
    [leftbutton setTitle:@"立刻提交" forState:UIControlStateNormal];
    [leftbutton setTitle:@"确定" forState:UIControlStateSelected];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    self.leftbutton = leftbutton;
    
}
/** UI */
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    self.scrollView.height = self.SJScrollView.contentSize.height - 50;
    
    NSString *ginfo = [PublicMethods readFromUserD:@"get_store_application_info"];
    if ([ginfo isEqualToString:@"1"]) {
        insert_storeM *model = [insert_storeM getUseData];
        NSString *card = [NSString stringWithFormat:@"%@",model.hand_held_ID_card_pic];
        if ([[MethodCommon judgeStringIsNull:card] isEqualToString:@""]){
            
        }else{
            NSMutableArray *URl = [self StringFoin:card];
            self.scrollView.UrlimageArr1 = URl;
            
        }
        
        
        
        NSString *card1 = [NSString stringWithFormat:@"%@",model.business_license_pic];
        if ([[MethodCommon judgeStringIsNull:card1] isEqualToString:@""]){
            
        }else{
            NSMutableArray *URl1 = [self StringFoin:card1];
            self.scrollView.UrlimageArr2 = URl1;
            
        }
        
        
        
        NSString *card2 = [NSString stringWithFormat:@"%@",model.business_permit_pic];
        if ([[MethodCommon judgeStringIsNull:card2] isEqualToString:@""]){
            
        }else{
            NSMutableArray *URl2 = [self StringFoin:card2];
            self.scrollView.UrlimageArr3 = URl2;
            
        }
        
    }else if ([ginfo isEqualToString:@"2"]){
        
    }
    
    
    
}
#pragma mark - RighAction
/** 下一步、保存信息*/
-(void)RighAction{
    
    if (self.scrollView.UrlimageArr1.count==0 ) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请上传身份证照"];
        return;
    }
    if (self.scrollView.UrlimageArr2.count==0) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请上传营业执照"];
        return;
    }
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    NSString *tring = [self ArrayFoin:self.scrollView.UrlimageArr1];
    NSLog(@"传输的值1 ：%@",tring);
    NSString *tring2 = [self ArrayFoin:self.scrollView.UrlimageArr2];
    NSLog(@"传输的值2 ：%@",tring2);
    NSString *tring3 = [self ArrayFoin:self.scrollView.UrlimageArr3];
    NSLog(@"传输的值3 ：%@",tring3);
    

    
    if (self.Data_dict.count>0) {
        NSDictionary *dict = @{
                               @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",tring],
                               @"business_license_pic":[NSString stringWithFormat:@"%@",tring2],
                               @"business_permit_pic":[NSString stringWithFormat:@"%@",tring3],
                               };
        
        [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:dict Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"等待信息审核中"];

                [self.navigationController popViewControllerAnimated:YES];
            }else{

            }
            [MBProgressHUD hideHUD];
        } andfailure:^{
            [MBProgressHUD hideHUD];
            
        }];
    }else{
        insert_storeM *model1 = [insert_storeM getUseData];
        
        NSDictionary *dict = @{
                               @"store_name":model1.store_name,
                               @"store_logo":model1.store_logo,
                               @"category_id":model1.category_id,
                               @"sec_category_id":[NSString stringWithFormat:@"%@",model1.sec_category_id],
                               
                               @"lon":[NSString stringWithFormat:@"%@",model1.lon],
                               @"lat":[NSString stringWithFormat:@"%@",model1.lat],
                               @"store_address":model1.store_address,
                               @"specific_location":model1.specific_location,
                               @"reminder":model1.reminder,
                               @"reminder2":model1.reminder2,
                               @"merchant_name":model1.merchant_name,
                               @"merchant_mobile":model1.merchant_mobile,
                               @"merchant_telephone":model1.merchant_telephone,
                               @"door_face_pic":model1.door_face_pic,
                               @"store_environment_pics":model1.store_environment_pics,
                               
                               @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",tring],
                               @"business_license_pic":[NSString stringWithFormat:@"%@",tring2],
                               @"business_permit_pic":[NSString stringWithFormat:@"%@",tring3],
                               
                               
                               @"business_hours":[NSString stringWithFormat:@"%@",model1.business_hours],
                               @"business_times":[NSString stringWithFormat:@"%@",model1.business_times],
                               };
        
        self.model = [insert_storeM mj_objectWithKeyValues:dict];
        [self.model saveUserData];
        /**
         *  开始申请入驻
         **/
        [self merchant_center:self.model];
    }
    
    
}
#pragma mark - 请求入驻申请
-(void)merchant_center:(insert_storeM *)DataM{
    
    
    UserModel *model = [UserModel getUseData];
    
    NSDictionary *Dict = [NSDictionary dictionary];
    
    if ([DataM.merchant_telephone isEqualToString:@""]) {
        Dict = @{
                 @"store_name":[NSString stringWithFormat:@"%@",DataM.store_name],
                 @"category_id":[NSString stringWithFormat:@"%@",DataM.category_id],//类型
                 @"sec_category_id":[NSString stringWithFormat:@"%@",DataM.sec_category_id],
                 
                 @"store_logo":[NSString stringWithFormat:@"%@",DataM.store_logo],
                 @"store_address":[NSString stringWithFormat:@"%@",DataM.store_address],
                 @"lon":[NSString stringWithFormat:@"%@",DataM.lon],
                 @"lat":[NSString stringWithFormat:@"%@",DataM.lat],
                 @"specific_location":[NSString stringWithFormat:@"%@",DataM.specific_location],
                 @"reminder":[NSString stringWithFormat:@"%@",DataM.reminder],
                 @"reminder2":[NSString stringWithFormat:@"%@",DataM.reminder2],
                 @"merchant_name":[NSString stringWithFormat:@"%@",DataM.merchant_name],
                 @"merchant_mobile":[NSString stringWithFormat:@"%@",DataM.merchant_mobile],
                 //                           @"merchant_telephone":[NSString stringWithFormat:@"%@",DataM.merchant_telephone],
                 @"door_face_pic":[NSString stringWithFormat:@"%@",DataM.door_face_pic],
                 @"store_environment_pics":[NSString stringWithFormat:@"%@",DataM.store_environment_pics],
                 @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",DataM.hand_held_ID_card_pic],
                 @"business_license_pic":[NSString stringWithFormat:@"%@",DataM.business_license_pic],
                 @"business_permit_pic":[NSString stringWithFormat:@"%@",DataM.business_permit_pic],
                 
                 
                 
                 @"business_hours":[NSString stringWithFormat:@"%@",DataM.business_hours],
                 @"business_times":[NSString stringWithFormat:@"%@",DataM.business_times],
                 
                 };
        
    }else{
        Dict = @{
                 @"store_name":[NSString stringWithFormat:@"%@",DataM.store_name],
                 @"category_id":[NSString stringWithFormat:@"%@",DataM.category_id],//类型
                 @"sec_category_id":[NSString stringWithFormat:@"%@",DataM.sec_category_id],
                 
                 @"store_logo":[NSString stringWithFormat:@"%@",DataM.store_logo],
                 @"store_address":[NSString stringWithFormat:@"%@",DataM.store_address],
                 @"lon":[NSString stringWithFormat:@"%@",DataM.lon],
                 @"lat":[NSString stringWithFormat:@"%@",DataM.lat],
                 @"specific_location":[NSString stringWithFormat:@"%@",DataM.specific_location],
                 @"reminder":[NSString stringWithFormat:@"%@",DataM.reminder],
                 @"reminder2":[NSString stringWithFormat:@"%@",DataM.reminder2],
                 @"merchant_name":[NSString stringWithFormat:@"%@",DataM.merchant_name],
                 @"merchant_mobile":[NSString stringWithFormat:@"%@",DataM.merchant_mobile],
                 @"merchant_telephone":[NSString stringWithFormat:@"%@",DataM.merchant_telephone],
                 @"door_face_pic":[NSString stringWithFormat:@"%@",DataM.door_face_pic],
                 @"store_environment_pics":[NSString stringWithFormat:@"%@",DataM.store_environment_pics],
                 @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",DataM.hand_held_ID_card_pic],
                 @"business_license_pic":[NSString stringWithFormat:@"%@",DataM.business_license_pic],
                 @"business_permit_pic":[NSString stringWithFormat:@"%@",DataM.business_permit_pic],
                 
                 
                 
                 @"business_hours":[NSString stringWithFormat:@"%@",DataM.business_hours],
                 @"business_times":[NSString stringWithFormat:@"%@",DataM.business_times],
                 };
    }
    
    NSLog(@"申请参数 %@",Dict);
    
    //添加店铺
    [[FBHAppViewModel shareViewModel] insert_store_application:model.merchant_id andMerchantDict:Dict Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {

            /**
             *  申请入驻成功后等通过（保存填写数据）
             *  1、未通过，可以查看
             *  2、通过后，可以修改
             *  3、到提示界面
             **/
            //步骤 1
            
            
            //步骤 2
            
            
            //步骤 3
            [self.navigationController pushViewController:[ReviewStatusController new] animated:YES];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
}

#pragma mark - 遍历后返回字符串
- (NSString *)ArrayFoin:(NSMutableArray *)arr{
    NSString *ArrayString = [NSString new];
    
    for (int i = 1; i<=arr.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",arr[i-1]];
        if (i == arr.count) {
            ArrayString = [ArrayString stringByAppendingFormat:@"%@",urlstring];
        }else{
            ArrayString = [ArrayString stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    
    
    return ArrayString;
}
#pragma mark - 遍历后返回数组字符串
-(NSMutableArray *)StringFoin:(NSString *)String{
    
    NSMutableArray *stringArr = [NSMutableArray array];
    NSArray * Arr = [String componentsSeparatedByString:@","];
    for (int i = 0; i<Arr.count; i++) {
        
        NSString *pic = [NSString stringWithFormat:@"%@",Arr[i]];
        
        [stringArr addObject:pic];
    }
    
    return stringArr;
}

/**
 *  环境加载图片
 */
- (void)ImageArr:(NSInteger)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        //        [self image:photos[0] andtag:sender];
        for (UIImage *image in photos) {
            [self image:image andtag:sender];
            
        }
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}

#pragma mark - 上传图片
-(void)image:(UIImage *)img andtag:(NSInteger)imatag {
    [[FBHAppViewModel shareViewModel]uploadImageWithData:img andtype:@"1" Success:^(NSDictionary *resDic) {
        NSString *urlstr = [[NSString alloc]init];
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            urlstr = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
            
            switch (imatag) {
                case 1:
                    [self.scrollView.UrlimageArr1 addObject:urlstr];
                    [self.scrollView.collectionView1 reloadData];
                    break;
                    
                case 2:
                    [self.scrollView.UrlimageArr2 addObject:urlstr];
                    if (self.scrollView.UrlimageArr2.count>=3) {
                        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.SJScrollView.contentSize.height +140);
                    }else{
                        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.SJScrollView.contentSize.height );
                    }
                    [self.scrollView.collectionView2 reloadData];
                    break;
                case 3:
                    [self.scrollView.UrlimageArr3 addObject:urlstr];
                    if (self.scrollView.UrlimageArr3.count>=3) {
                        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.SJScrollView.contentSize.height +140);
                    }else{
                        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.SJScrollView.contentSize.height );
                    }
                    [self.scrollView.collectionView3 reloadData];
                    break;
                default:
                    break;
            }
            
            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
}
-(void)sampleAction:(NSInteger)sampTag{
    SampleView *samView = [[SampleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if (sampTag == 1) {
        samView.Sampletext.text = @"门脸照-示例图";
        samView.imagesArr = @[@"身份证-正面",@"身份证-反面"];
    }else if(sampTag == 2){
        samView.Sampletext.text = @"营业执照-示例图";
        samView.imagesArr = @[@"营业执照"];
    }else{
        samView.Sampletext.text = @"许可证-示例图";
        samView.imagesArr = @[@"许可证"];
    }
    
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
}
#pragma mark - GET
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 935);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(CertificateCardView *)scrollView{
    if (!_scrollView) {
        _scrollView =[[ CertificateCardView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, ScreenH-20)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.layer.cornerRadius = 5;
        _scrollView.delagate = self;
        _scrollView.didSelectBlock = ^(NSInteger collviewInt) {
            [self ImageArr:collviewInt];
        };
    }
    return _scrollView;
}

@end
