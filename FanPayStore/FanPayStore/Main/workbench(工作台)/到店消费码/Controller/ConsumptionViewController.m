//
//  ConsumptionViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ConsumptionViewController.h"

@interface ConsumptionViewController ()
@property (strong,nonatomic)UIView * baseView;
@property (strong,nonatomic)UIImageView * ERweiImage;
/*头像*/
@property (strong,nonatomic)UIImageView * logImage;
/**/
@property (strong,nonatomic)UILabel *  storeName;
@property (strong,nonatomic)UILabel *  store;
@end

@implementation ConsumptionViewController
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_into_store_qrcode:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            NSString *url =  [NSString stringWithFormat:@"%@",DIC[@"into_store_qrcode"]];
           
            
            [self.ERweiImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];

            
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
}
-(void)merchant_center_discount{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_merchant_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];

            self.store.text = [NSString stringWithFormat:@"一鹿省号：%@",DIC[@"discount_account"]];
            
            
        }else{

        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
        
    }];
    
    //上半部分
    [[FBHAppViewModel shareViewModel] get_workbench_upper_part_info:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            NSString *url =  [NSString stringWithFormat:@"%@",DIC[@"store_logo"]];
            
            
            [self.logImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            self.storeName.text = DIC[@"store_name"];
            
        }else{
            
        }
        [MBProgressHUD hideHUD];
        
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"到店消费码";
    
    [self merchant_center];
    [self merchant_center_discount];
    
    [self setupNav];
    
    [self createUI];
}
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 28)];
    [leftbutton setTitle:@"保存" forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:15]];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];self.navigationItem.rightBarButtonItem = rightitem;
    
}

-(void)RighAction{
    
    UIImage *newImage = [[UIImage alloc]init];
    newImage = [self convertViewToImage:self.baseView];
    
    [self loadImageFinished:newImage];

}
- (void)loadImageFinished:(UIImage *)image {
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    
}
#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        [SVProgressHUD setMinimumDismissTimeInterval:2];
        [SVProgressHUD showErrorWithStatus:@"保存图片失败"];
        
        msg = @"保存图片失败" ;
    }else{
        [SVProgressHUD showSuccessWithStatus:@"保存图片成功"];
        
        msg = @"保存图片成功" ;
    }
}

#pragma mark - UI
-(void)createUI{
//    storeBaseModel *model = [storeBaseModel getUseData];

    self.baseView = [[UIView alloc] init];
    self.baseView.frame = CGRectMake(15,20,ScreenW-30,IPHONEHIGHT(420));
    self.baseView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.baseView.layer.cornerRadius = 5;
    [self.view addSubview:self.baseView];
    
    UIImageView *BaseImage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,self.baseView.width,self.baseView.height)];
    BaseImage.image = [UIImage imageNamed:@"shop_code_bg"];
    [self.baseView addSubview:BaseImage];
    
//    UIView *view_line = [[UIView alloc] init];
//    view_line.frame = CGRectMake(0,0,self.baseView.width,140);
//    view_line.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
//
//    [self.baseView addSubview:view_line];
    
    /* 头像*/
//    [self.baseView addSubview:self.logImage];
//    [self.logImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",model.store_pic]] placeholderImage:[UIImage imageNamed:@""]];
//
//    [self.logImage mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_offset(15);
//        make.centerX.mas_offset(0);
//        make.size.mas_offset(CGSizeMake(autoScaleW(57), autoScaleW(57)));
//    }];
    /*店名*/
//    [self.baseView addSubview:self.storeName];
//    self.storeName.text = [NSString stringWithFormat:@"%@",model.store_name];
//
//    [self.storeName mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.logImage.mas_bottom).offset(18);
//        make.left.right.mas_offset(0);
//    }];
//
//    [self.baseView addSubview:self.store];
//    [self.store mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self.storeName.mas_bottom).offset(5);
//        make.left.right.mas_offset(0);
//    }];
    
    
    
    /*二维码*/
    [self.baseView addSubview:self.ERweiImage];
    [self.ERweiImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(IPHONEHIGHT(220));
        make.centerX.mas_offset(-100);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(73), IPHONEWIDTH(73)));
    }];
    UILabel *label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.text = @"扫一扫，即可省钱";
    label.textColor = UIColorFromRGB(0x1D1D1D);
    label.font = [UIFont systemFontOfSize:8];
    [self.baseView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.ERweiImage.mas_bottom).offset(5);
        make.left.equalTo(self.ERweiImage.mas_left).offset(0);
        make.size.mas_offset(CGSizeMake(IPHONEWIDTH(73), IPHONEWIDTH(10)));
    }];
//    UILabel *label = [[UILabel alloc] init];
//    label.frame = CGRectMake(0,self.baseView.height - 80,self.baseView.width,80);
//    label.numberOfLines = 0;
//    label.textAlignment = 1;
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"打开一鹿省或微信的「扫描二维码」\n可快速访问店铺进行点单或扫码支付" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:12],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
//
//    label.attributedText = string;
//
//    [self.baseView addSubview:label];
    
    
    
    UILabel *label_fenxiang = [[UILabel alloc] init];
    label_fenxiang.frame = CGRectMake(0,ScreenH - 120 -(kIs_iPhoneX ? 88:64),ScreenW,11.5);
    label_fenxiang.numberOfLines = 0;
    label_fenxiang.text = @"分享至";
    label_fenxiang.textAlignment = 1;
    label_fenxiang.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:label_fenxiang];
    
    /*分享*/
    CGFloat btn_w = ScreenW/4;
    NSArray *iconarr = @[@"btn_share_wechat_normal",@"btn_share_weibo_normal",@"btn_share_qq_normal",@"btn_share_moments_normal"];
    for (int i =0; i<iconarr.count; i++) {
        
        UIButton *Btn = [UIButton buttonWithType:UIButtonTypeCustom];
        Btn.frame= CGRectMake(btn_w*i, label_fenxiang.bottom + 20, btn_w, 60);
        [Btn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@",iconarr[i]]] forState:UIControlStateNormal];
        [Btn addTarget:self action:@selector(stveAction:) forControlEvents:UIControlEventTouchUpInside];
        Btn.tag = i;
        [self.view addSubview:Btn];
        
    }
    
    
    
}

-(UIImage*)convertViewToImage:(UIView*)v{
    CGSize s = v.bounds.size;
    // 下面方法，第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [v.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

#pragma mark - 分享
-(void)stveAction:(UIButton *)Btn{
    UIImage *weixinimage = [[UIImage alloc]init];

    
    weixinimage = [self convertViewToImage:self.baseView];
    
    
    switch (Btn.tag) {
        case 0:
            //微信

            [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_WechatSession andtThumbImage:weixinimage];
            break;
            
            
        case 1:
            //微博
            
            [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_Sina andtThumbImage:weixinimage];

            break;
            
        case 2:
            //qq
            
            [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_QQ andtThumbImage:weixinimage];

            break;
            
        case 3:
            //朋友圈
            
            [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_WechatTimeLine andtThumbImage:weixinimage];

            break;
            
            
        default:
            break;
    }
    
    
}




#pragma mark - 懒加载
-(UIImageView *)ERweiImage{
    if (!_ERweiImage) {
        _ERweiImage = [[UIImageView alloc]initWithFrame:CGRectMake(77, 105, autoScaleW(191), autoScaleW(191))];
        _ERweiImage.layer.borderColor = UIColorFromRGB(0xCDCDCD).CGColor;
        _ERweiImage.layer.borderWidth = 1;
        _ERweiImage.layer.cornerRadius = 5;
    }
    return _ERweiImage;
}

-(UIImageView *)logImage{
    if (!_logImage) {
        _logImage = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, autoScaleW(34), autoScaleW(34))];
        _logImage.layer.cornerRadius = autoScaleW(57)/2;
        _logImage.layer.masksToBounds = YES;

    }
    return _logImage;
}
-(UILabel *)storeName{
    if (!_storeName) {
        _storeName = [[UILabel alloc]initWithFrame:CGRectMake(59, 16, 150, 15)];
        _storeName.textColor = [UIColor whiteColor];
        _storeName.font  = [UIFont systemFontOfSize:15];
        _storeName.textAlignment = 1;
//        _storeName.text = @"大房子创意菜";
    }
    return _storeName;
}
-(UILabel *)store{
    if (!_store) {
        _store = [[UILabel alloc]initWithFrame:CGRectMake(59, 16, 150, 15)];
        _store.textColor = [UIColor whiteColor];
        _store.font  = [UIFont systemFontOfSize:12];
        _store.textAlignment = 1;

//        _store.text = @"一鹿省号：FBH112345678";
    }
    return _store;
}
@end
