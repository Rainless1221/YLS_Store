//
//  StoreInformationController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StoreInformationController.h"
#import "StoreInformation.h"

@interface StoreInformationController ()<TZImagePickerControllerDelegate,UICollectionViewDataSource,UICollectionViewDelegate,ZXCollectionCellDelegate,MapControllerDelegate,ReminDelegate>
@property (nonatomic,strong)UICollectionView *collectionView;
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)DXXView * scrollView;
/** 展示的图片数组*/
@property(nonatomic,strong)NSMutableArray * imageArr;
/** 返回的图片地址 */
@property (strong,nonatomic)NSMutableArray * UrlimageArr;
@property (strong,nonatomic)NSString * door_face_pic;
@property (strong,nonatomic)NSString * door_face_picZ;
@property (strong,nonatomic)NSString * door_face_picF;
@property (strong,nonatomic)NSString * storePics;

@property (strong,nonatomic)NSString * addres;
@property (strong,nonatomic)NSString * lon;
@property (strong,nonatomic)NSString * lat;
@property (strong,nonatomic)NSMutableArray * store_tips;
@property (strong,nonatomic)NSMutableArray * reminderArray;

@end

@implementation StoreInformationController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
    
}
-(void)merchant_center{
    //    get_store_tips
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_tips:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            [self.store_tips removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_tips"]) {
                [self.store_tips addObject:dict];
            }
            //            self.scrollView.reminderView.height = self.store_tips.count*50+155;
            NSLog(@"%lf",self.scrollView.reminderView.height);
            for (int i =0; i<self.store_tips.count; i++) {
                
                
                
                NSString *lableString = [NSString stringWithFormat:@"%@",self.store_tips[i][@"info_content"]];
                CGRect rect = [lableString boundingRectWithSize:CGSizeMake(self.scrollView.reminderView.width-20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
                //                CGFloat BtnW = rect.size.width + 10;
                CGFloat BtnH = rect.size.height + 15;
                
                UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(10, i*50+50, self.scrollView.reminderView.width-20, BtnH)];
                baseView.layer.borderWidth = 1;
                baseView.layer.borderColor =UIColorFromRGB(0xEAEAEA).CGColor;
                baseView.layer.cornerRadius = 5;
                //                [self.scrollView.reminderView addSubview:baseView];
                
                
                FL_Button *thirdBtn = [FL_Button buttonWithType:UIButtonTypeCustom];
                thirdBtn.frame = CGRectMake(15, i*50+50, self.scrollView.reminderView.width-25, BtnH);
                [thirdBtn setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
                [thirdBtn setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
                [thirdBtn setTitle:lableString forState:UIControlStateNormal];
                [thirdBtn setTitleColor:UIColorFromRGB(0x555555) forState:UIControlStateNormal];
                //样式
                thirdBtn.status = FLAlignmentStatusImageLeft;
                thirdBtn.fl_padding = 10;
                //                                thirdBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;//居左显示
                //                [thirdBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
                //                [thirdBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 20, 0, -20)];
                
                thirdBtn.titleLabel.font = [UIFont systemFontOfSize:15];
                
                //                [self.scrollView.reminderView addSubview:thirdBtn];
                [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
                //                thirdBtn.tag = i+1;
                
                
                
                
                
                ReminView *ReminV = [[ReminView alloc]initWithFrame:CGRectMake(10, i*50+50, self.scrollView.reminderView.width-20, 50)];
                ReminV.delagate =self;
                ReminV.reminlable.text = lableString;
                [self.scrollView.reminderView addSubview:ReminV];
                ReminV.tag = i;
                
                CGRect Reminrect = [ReminV.reminlable textRectForBounds:ReminV.reminlable.frame limitedToNumberOfLines:0];
                
                CGRect frame = ReminV.frame;
                frame.size.height = Reminrect.size.height+15;
                //                frame = CGRectMake(10, i*(Reminrect.size.height+10)+50, self.scrollView.reminderView.width-20, Reminrect.size.height+10);
                [UIView animateWithDuration:0.25 animations:^{
                    ReminV.frame = frame;
                }];
                
                
                
                
            }
            
            
            
            
        }else{
        }
    } andfailure:^{
        
    }];
    
}
-(void)Remin:(UIView *)ReminV and:(UIButton* )icon{
    
    if (icon.isSelected) {
        [self.reminderArray addObject:self.store_tips[ReminV.tag][@"info_id"]];
    } else {
        [self.reminderArray removeObject:self.store_tips[ReminV.tag][@"info_id"]];
    }
    
    //    NSLog(@"%@",self.reminderArray);
    
    
}
-(void)MerchantButton:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.isSelected) {
        [self.reminderArray addObject:self.store_tips[sender.tag-1][@"info_id"]];
    } else {
        [self.reminderArray removeObject:self.store_tips[sender.tag-1][@"info_id"]];
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺信息";
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
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 28)];
    [leftbutton setTitle:@"下一步" forState:UIControlStateNormal];
    [leftbutton setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    self.navigationItem.rightBarButtonItem = rightitem;
    if (self.Data_dict.count>0) {
        [leftbutton setTitle:@"确定" forState:UIControlStateNormal];
        
    }
}
/** 下一步、保存信息*/
-(void)RighAction{
    [self.view endEditing:YES];
    if (self.door_face_picZ == nil || self.door_face_picZ ==nil) {
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"请添加完成信息"];
        return;
    }else if (self.lon == nil||self.lat == nil){
        [SVProgressHUD setMinimumDismissTimeInterval:1];
        [SVProgressHUD showErrorWithStatus:@"请再次选择详细的定位地址"];
        return;
    }
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    self.door_face_pic = [NSString stringWithFormat:@"%@",self.door_face_picZ];
    
    /** 环境图片 */
    for (int i =1; i<=self.UrlimageArr.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.UrlimageArr[i-1]];
        if (i == self.UrlimageArr.count) {
            self.storePics = [self.storePics stringByAppendingFormat:@"%@",urlstring];
        }else{
            self.storePics = [self.storePics stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    /** 温馨提示 */
    NSString *reminderStr = [NSString new];
    for (int i =1; i<=self.reminderArray.count; i++) {
        
        NSString *urlstring = [NSString stringWithFormat:@"%@",self.reminderArray[i-1]];
        if (i == self.reminderArray.count) {
            reminderStr = [reminderStr stringByAppendingFormat:@"%@",urlstring];
        }else{
            reminderStr = [reminderStr stringByAppendingFormat:@"%@,",urlstring];
        }
        
    }
    
    if (self.Data_dict.count>0) {
        UserModel *model = [UserModel getUseData];
        NSString *addres = [NSString stringWithFormat:@"%@",self.scrollView.store_address.text];
        NSDictionary *dict = @{
                               @"store_address":[NSString stringWithFormat:@"%@",addres],
                               @"lon":[NSString stringWithFormat:@"%@",self.lon],
                               @"lat":[NSString stringWithFormat:@"%@",self.lat],
                               
                               @"specific_location":[NSString stringWithFormat:@"%@",self.scrollView.specific_location.text],
                               @"reminder":[NSString stringWithFormat:@"%@",reminderStr],
                               @"reminder2":[NSString stringWithFormat:@"%@",self.scrollView.reminder.text],
                               @"merchant_name":[NSString stringWithFormat:@"%@",self.scrollView.merchant_name.text],
                               @"merchant_mobile":[NSString stringWithFormat:@"%@",self.scrollView.merchant_mobile.text],
                               @"merchant_telephone":[NSString stringWithFormat:@"%@",self.scrollView.merchant_telephone.text],
                               @"door_face_pic":[NSString stringWithFormat:@"%@",self.door_face_pic],
                               @"store_environment_pics":[NSString stringWithFormat:@"%@",self.storePics],
                               
                               @"business_hours":[NSString stringWithFormat:@"%@",self.scrollView.business_hours.text],
                               @"business_times":[NSString stringWithFormat:@"%@",self.scrollView.business_times.text],
                               };
        
        
        [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:dict Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue] == 1) {
                [SVProgressHUD showSuccessWithStatus:@"等待信息审核中"];

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
        insert_storeM *model1 = [insert_storeM getUseData];
        /** 地址 */
        NSString *addres = [NSString stringWithFormat:@"%@",self.scrollView.store_address.text];
        
        
        
        NSDictionary *dict = @{
                               @"store_name":[NSString stringWithFormat:@"%@",model1.store_name],
                               @"store_logo":[NSString stringWithFormat:@"%@",model1.store_logo],
                               @"category_id":[NSString stringWithFormat:@"%@",model1.category_id],
                               @"sec_category_id":[NSString stringWithFormat:@"%@",model1.sec_category_id],
                               @"category_pic":[NSString stringWithFormat:@"%@",model1.category_pic],
                               @"store_address":[NSString stringWithFormat:@"%@",addres],
                               @"lon":[NSString stringWithFormat:@"%@",self.lon],
                               @"lat":[NSString stringWithFormat:@"%@",self.lat],
                               
                               @"specific_location":[NSString stringWithFormat:@"%@",self.scrollView.specific_location.text],
                               @"reminder":[NSString stringWithFormat:@"%@",reminderStr],
                               @"reminder2":[NSString stringWithFormat:@"%@",self.scrollView.reminder.text],
                               @"merchant_name":[NSString stringWithFormat:@"%@",self.scrollView.merchant_name.text],
                               @"merchant_mobile":[NSString stringWithFormat:@"%@",self.scrollView.merchant_mobile.text],
                               @"merchant_telephone":[NSString stringWithFormat:@"%@",self.scrollView.merchant_telephone.text],
                               @"door_face_pic":[NSString stringWithFormat:@"%@",self.door_face_pic],
                               @"store_environment_pics":[NSString stringWithFormat:@"%@",self.storePics],
                               
                               @"hand_held_ID_card_pic":[NSString stringWithFormat:@"%@",model1.hand_held_ID_card_pic],
                               @"business_license_pic":[NSString stringWithFormat:@"%@",model1.business_license_pic],
                               @"business_permit_pic":[NSString stringWithFormat:@"%@",model1.business_permit_pic],
                               
                               @"business_hours":[NSString stringWithFormat:@"%@",self.scrollView.business_hours.text],
                               @"business_times":[NSString stringWithFormat:@"%@",self.scrollView.business_times.text],
                               };
        /** 保存申请的信息 */
        insert_storeM * model = [insert_storeM mj_objectWithKeyValues:dict];
        [model saveUserData];
        [MBProgressHUD hideHUD];
        
        [self.navigationController pushViewController:[CertificateCardController new] animated:YES];
        
    }
    
}

#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    
    /** 店铺环境图片列表 */
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, self.scrollView.Huanjilabel.bottom+20, ScreenW-20, self.scrollView.iamgeArrView.height-self.scrollView.Huanjilabel.bottom) collectionViewLayout:flowLayout];
    //设置代理
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.scrollView.iamgeArrView addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    //注册cell和ReusableView（相当于头部）
    [self.collectionView registerClass:[ZXCollectionCell class] forCellWithReuseIdentifier:@"cell"];
    
    
    
    
    NSString *ginfo = [PublicMethods readFromUserD:@"get_store_application_info"];
    if ([ginfo isEqualToString:@"1"]) {
        insert_storeM *model = [insert_storeM getUseData];
        
        
        /** 地址 */
        NSString *addres  = [NSString stringWithFormat:@"%@",model.store_address];
        NSString *location = [NSString stringWithFormat:@"%@",model.specific_location];
        if ([[MethodCommon judgeStringIsNull:addres] isEqualToString:@""]){
            
        }else{
            self.scrollView.store_address.text = addres;
            
        }
        
        if ([[MethodCommon judgeStringIsNull:location] isEqualToString:@""]){
            
        }else{
            self.scrollView.specific_location.text = location;
            
        }
        
        self.lon = [NSString stringWithFormat:@"%@",model.lon];
        self.lat = [NSString stringWithFormat:@"%@",model.lat];
        
        
        /** 联系人 */
        if ([[MethodCommon judgeStringIsNull:model.merchant_name] isEqualToString:@""]){
            
        }else{
            self.scrollView.merchant_name.text = [NSString stringWithFormat:@"%@",model.merchant_name];
        }
        /** 手机号 */
        if ([[MethodCommon judgeStringIsNull:model.merchant_mobile] isEqualToString:@""]){
            
        }else{
            self.scrollView.merchant_mobile.text = [NSString stringWithFormat:@"%@",model.merchant_mobile];
        }
        /** 固定电话 */
        if ([[MethodCommon judgeStringIsNull:model.merchant_telephone] isEqualToString:@""]){
            
        }else{
            self.scrollView.merchant_telephone.text = [NSString stringWithFormat:@"%@",model.merchant_telephone];
        }
        /** 营业周期 */
        if ([[MethodCommon judgeStringIsNull:model.business_times] isEqualToString:@""]){
            
        }else{
            self.scrollView.business_times.text = [NSString stringWithFormat:@"%@",model.business_times];
            self.scrollView.business_times.textColor = UIColorFromRGB(0x222222);
            
        }
        /** 营业时间 */
        if ([[MethodCommon judgeStringIsNull:model.business_hours] isEqualToString:@""]){
            
        }else{
            self.scrollView.business_hours.text = [NSString stringWithFormat:@"%@",model.business_hours];
            self.scrollView.business_hours.textColor = UIColorFromRGB(0x222222);
            
        }
        /** 温馨提示 */
        if ([[MethodCommon judgeStringIsNull:model.reminder2] isEqualToString:@""]){
            
        }else{
            self.scrollView.reminder.text = [NSString stringWithFormat:@"%@",model.reminder2];
            self.scrollView.placeholderLabel.hidden = YES;
            
        }
        NSString *reminder = [NSString stringWithFormat:@"%@",model.reminder];
        if ([[MethodCommon judgeStringIsNull:reminder] isEqualToString:@""]){
            
        }else{
            NSArray *faceArray = [reminder componentsSeparatedByString:@","];
            for (int i = 0; i<faceArray.count; i++) {
                
            }
            
        }
        
        /**
         门店图片
         */
        NSString *face_pic = [NSString stringWithFormat:@"%@",model.door_face_pic];
        if ([[MethodCommon judgeStringIsNull:face_pic] isEqualToString:@""]){
            
        }else{
            // 用指定字符串分割字符串，返回一个数组
            NSArray *faceArray = [face_pic componentsSeparatedByString:@","];
            for (int i= 0; i<faceArray.count; i++) {
                
                NSString *pic = [NSString stringWithFormat:@"%@",faceArray[i]];
                self.door_face_picZ = pic;
                self.door_face_picF = pic;
                
                if ([PublicMethods isUrl:pic]) {
                    
                }else{
                    pic = [NSString stringWithFormat:@"%@%@",FBHApi_Url,pic];
                }
                
                if (i==0) {
                    [self.scrollView.Face_picZButton setImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                    
                }else{
                    [self.scrollView.Face_picFButton setImageWithURL:[NSURL URLWithString:pic] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"pic_default_avatar"]];
                    
                }
                
            }
            
            
        }
        
        /** 图片数组 */
        NSString *environment_pics = [NSString stringWithFormat:@"%@",model.store_environment_pics];
        
        if ([[MethodCommon judgeStringIsNull:environment_pics] isEqualToString:@""]){
            
        }else{
            NSMutableArray *URl = [self StringFoin:environment_pics];
            self.UrlimageArr = URl;
            
        }
        
        
        
    }
    
    
    
    
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
#pragma mark -- UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
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
        //        cell.imgView.image = [_imageArr objectAtIndex:indexPath.row];
        NSString *url = [NSString stringWithFormat:@"%@",self.UrlimageArr[indexPath.row]];
        url = [self isurl:url];
        
        [cell.imgView sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
        cell.close.hidden = NO;
        
    }
    
    //    cell.text.text = [NSString stringWithFormat:@"Cell %ld",indexPath.row];
    cell.delegate = self;
    return cell;
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //边距占5*4=20 ，2个
    //图片为正方形，边长：(fDeviceWidth-20)/2-5-5 所以总高(fDeviceWidth-20)/2-5-5 +20+30+5+5 label高20 btn高30 边
    return CGSizeMake((ScreenW-50)/3, (ScreenW-50)/3);
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
    //        UICollectionViewCell * cell = (UICollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    //        cell.backgroundColor = [UIColor redColor];
    [self ImageArr:nil];
    NSLog(@"选择%ld",indexPath.row);
}
/** 删除照片 */
-(void)moveImageBtnClick:(ZXCollectionCell *)aCell{
    NSIndexPath * indexPath = [self.collectionView indexPathForCell:aCell];
    NSLog(@"_____%ld",indexPath.row);
    //    [_imageArr removeObjectAtIndex:indexPath.row];
    [self.UrlimageArr removeObjectAtIndex:indexPath.row];
    [self.collectionView reloadData];
}
#pragma mark - 选择加载各类照片
/**
 *  门店加载图片
 */
- (void)DXXbutton:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [sender setImage:photos[0] forState:UIControlStateNormal];
        [self image:photos[0] andtag:sender.tag];
        
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
/**
 *  环境加载图片
 */
- (void)ImageArr:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:6 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        [sender setImage:photos[0] forState:UIControlStateNormal];
        //        [self image:photos[0] andtag:3];
        for (UIImage *image in photos) {
            [self image:image andtag:3];
            
        }
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
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
    [[FBHAppViewModel shareViewModel]uploadImageWithData:img andtype:@"1"  Success:^(NSDictionary *resDic) {
        NSString *urlstr = [[NSString alloc]init];
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            switch (imatag) {
                case 1:
                    self.door_face_picZ = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
                    
                    break;
                case 2:
                    //                    self.door_face_picF = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
                    
                    break;
                case 3:
                    urlstr = [NSString stringWithFormat:@"%@",DIC[@"img_url"]];
                    [self.UrlimageArr addObject:urlstr];
                    //                    [self.imageArr addObject:img];
                    [self.collectionView reloadData];
                    
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


#pragma mark - 实现协议方法
//-(void)pushViewcontroler:(NSString *)ddres andlot:(NSString *)lon andlat:(NSString *)lat{
//    /** 地址 */
//    self.scrollView.store_address.text = ddres;
//    self.addres = [NSString stringWithFormat:@"%@",ddres];
//    self.lon = [NSString stringWithFormat:@"%@",lon];
//    self.lat = [NSString stringWithFormat:@"%@",lat];
//
//}
-(void)Mapaddres:(NSString *)ddres andlot:(NSString *)lon andlat:(NSString *)lat{
    /** 地址 */
    self.scrollView.store_address.text = ddres;
    self.addres = [NSString stringWithFormat:@"%@",ddres];
    self.lon = [NSString stringWithFormat:@"%@",lon];
    self.lat = [NSString stringWithFormat:@"%@",lat];
    
}
-(void)SLAction{
    
    SampleView *samView = [[SampleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.Sampletext.text = @"门脸照-示例图";
    samView.imagesArr = @[@"店内环境照片-1",@"店内环境照片-2",@"店内环境照片-3"];
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
    
}
-(void)SL1Action{
    SampleView *samView = [[SampleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.Sampletext.text = @"店内环境-示例图";
    samView.imagesArr = @[@"店内环境照片-1",@"店内环境照片-2",@"店内环境照片-3"];
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
    
}
#pragma mark - 选择周期
-(void)periodView{
    PeriodView *periodV = [[PeriodView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    periodV.PeriodBlock = ^(NSString *PeriodString) {
        if ([PeriodString isEqualToString:@""]) {
            return ;
        }
        self.scrollView.business_times.text = PeriodString;
        self.scrollView.business_times.textColor = UIColorFromRGB(0x222222);
    };
    [[UIApplication sharedApplication].keyWindow addSubview:periodV];
    
}
#pragma mark - 选择经营时间
-(void)TimesView{
    hoursView *hoursV = [[hoursView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH)];
    hoursV.HoursBlock = ^(NSString *HoursString) {
        if ([HoursString isEqualToString:@""]) {
            return ;
        }
        self.scrollView.business_hours.text = HoursString;
        self.scrollView.business_hours.textColor = UIColorFromRGB(0x222222);
    };
    [[UIApplication sharedApplication].keyWindow addSubview:hoursV];
}
#pragma mark - Get
-(UIScrollView *)SJScrollView {
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 1700);
    }
    return _SJScrollView;
}
-(DXXView *)scrollView{
    if (!_scrollView) {
        _scrollView =
        [[NSBundle mainBundle] loadNibNamed:@"DXXView" owner:nil options:nil][0];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 1596);
        _scrollView.backgroundColor = MainbackgroundColor;
        YBWeakSelf
        
        /** 地图选择地址 **/
        _scrollView.AddBlock = ^{
            MapViewController * last = [[MapViewController alloc]init];
            //            FBHDWDTViewController * last = [[FBHDWDTViewController alloc]init];
            //设置代理
            last.delagate = weakSelf;
            [weakSelf.navigationController pushViewController:last animated:YES];
            
        };
        /** 门店照片选择 **/
        _scrollView.qhxSelectBlock = ^(BOOL choice, UIButton *btn) {
            [weakSelf DXXbutton:btn];
        };
        [_scrollView.SLbutton addTarget:self action:@selector(SLAction) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView.SLbutton1 addTarget:self action:@selector(SL1Action) forControlEvents:UIControlEventTouchUpInside];
        
        /** 周期选择 **/
        _scrollView.periodBlock = ^(BOOL choice, UIButton *btn) {
            [weakSelf periodView];
        };
        /** 营业时间选择 **/
        _scrollView.TimesBlock = ^(BOOL choice, UIButton *btn) {
            [weakSelf TimesView];
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
-(NSString *)door_face_pic{
    if (!_door_face_pic) {
        _door_face_pic = [[NSString alloc]init];
    }
    return _door_face_pic;
}
-(NSString *)storePics{
    if (!_storePics) {
        _storePics = [[NSString alloc]init];
    }
    return _storePics;
}
-(NSMutableArray *)store_tips{
    if (!_store_tips) {
        _store_tips= [NSMutableArray array];
    }
    return _store_tips;
}
-(NSMutableArray *)reminderArray{
    if (!_reminderArray) {
        _reminderArray= [NSMutableArray array];
    }
    return _reminderArray;
}

@end
