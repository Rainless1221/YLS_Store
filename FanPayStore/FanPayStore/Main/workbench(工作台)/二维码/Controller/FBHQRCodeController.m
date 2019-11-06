//
//  FBHQRCodeController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHQRCodeController.h"

@interface FBHQRCodeController ()
{
    NSString *Url;
}
/**  */
@property (assign,nonatomic)BOOL isUser;
@property (strong,nonatomic)UILabel  * TextLabel;
@property (strong,nonatomic)UIView  * TextView;
@property (strong,nonatomic) UISegmentedControl *segmentedControl;
@end

@implementation FBHQRCodeController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];

    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]generate_store_qrcode:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            self->Url = [NSString stringWithFormat:@"%@",DIC[@"user_qrcode"]];
            [self.QRimage sd_setImageWithURL:[NSURL URLWithString:self->Url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
            NSString *url1 = [NSString stringWithFormat:@"%@",DIC[@"merchant_qrcode"]];
            [self.QRimage1 sd_setImageWithURL:[NSURL URLWithString:url1] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
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
    self.navigationItem.title = @"邀请注册码";
    [self createUI];
    [self menuView];
}
#pragma mark - 菜单栏
- (void)menuView{
    UIView *menuV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 50)];
    menuV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuV];
    NSArray *segmentedArray = [NSArray arrayWithObjects:@"给用户",@"给商户",nil];
    
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:segmentedArray];
    segmentedControl.frame = CGRectMake(0, 0, 180, 30);
    segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.tintColor = UIColorFromRGB(0xF5F7FA);//[UIColor colorWithRed:252/255.0 green:245/255.0 blue:248/255.0 alpha:1];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x222222),UITextAttributeTextColor,nil];
    [segmentedControl setTitleTextAttributes:dic forState:UIControlStateSelected];
    NSDictionary *dics = [NSDictionary dictionaryWithObjectsAndKeys:UIColorFromRGB(0x222222),UITextAttributeTextColor,nil];
    [segmentedControl setTitleTextAttributes:dics forState:UIControlStateNormal];
    
    [segmentedControl addTarget:self action:@selector(indexDidChangeForSegmentedControl:) forControlEvents:UIControlEventValueChanged];
    
    segmentedControl.layer.masksToBounds = YES;
    segmentedControl.layer.cornerRadius = 15;
    self.segmentedControl =segmentedControl;
    [menuV addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_offset(0);
        make.size.mas_offset(CGSizeMake(300, 30));
    }];
    
}
-(void)indexDidChangeForSegmentedControl:(UISegmentedControl *)sender{
    if (sender.selectedSegmentIndex == 0) {
//        NSLog(@"给用户");
        self.QRimage1.hidden = YES;
        self.QRimage.hidden = NO;
        self.isUser = YES;

        [self.SaveButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
        self.TextLabel.text = @"用户";
        self.SaveButton.layer.borderWidth= 1;
        self.SaveButton.layer.borderColor= UIColorFromRGB(0x3D8AFF).CGColor;

         self.QRlabel.text = @"保存上方二维码图片发送给好友，好友使用一鹿省用户端“扫 描二维码”功能扫描此图片，就可以关注您的店铺";
        
        CAGradientLayer *layer = [CAGradientLayer new];
        //colors存放渐变的颜色的数组
        layer.colors=@[(__bridge id)UIColorFromRGB(0x4EC3FF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor];
        /**
         * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
         */
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 0);
        layer.cornerRadius = 40;
        layer.masksToBounds = YES;
        layer.frame = self.TextView.bounds;
        [self.TextView.layer addSublayer:layer];
        
//        self.segmentedControl.tintColor = UIColorFromRGB(0x3D8AFF);
    } else {
//        NSLog(@"给商户");
        self.QRimage1.hidden = NO;
        self.QRimage.hidden = YES;
        self.isUser = NO;
        self.TextLabel.text = @"商户";
        [self.SaveButton setBackgroundColor:UIColorFromRGB(0xF7AE2A)];
        self.SaveButton.layer.borderWidth= 1;
        self.SaveButton.layer.borderColor= UIColorFromRGB(0xF78A2A).CGColor;

        self.QRlabel.text = @"保存上方二维码图片发送给好友，好友使用一鹿省商户端“扫描二维码”功能扫描此图片，就可以下载并申请入驻";
        CAGradientLayer *layer = [CAGradientLayer new];
        //colors存放渐变的颜色的数组
        layer.colors=@[(__bridge id)UIColorFromRGB(0xFFE346).CGColor,(__bridge id)UIColorFromRGB(0xF7AE2A).CGColor,(__bridge id)UIColorFromRGB(0xF7AE2A).CGColor];
        /**
         * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
         */
        layer.startPoint = CGPointMake(0, 0);
        layer.endPoint = CGPointMake(1, 0);
        layer.cornerRadius = 40;
        layer.masksToBounds = YES;
        layer.frame = self.TextView.bounds;
        [self.TextView.layer addSublayer:layer];
//        self.segmentedControl.tintColor = UIColorFromRGB(0xF7AE2A);
    }
}
#pragma mark - UI
-(void)createUI{
    
    /** 二维码 **/
    self.BaseView.frame = CGRectMake(15, 65, ScreenW-30, autoScaleH(251));
    CGFloat image_W = 191;
    CGFloat image_Y = (self.BaseView.width-image_W)/2;
    /** 新用户图片 **/
    self.QRimage.frame = CGRectMake(image_Y, 30, image_W, image_W);
    /** 新商家 **/
    self.QRimage1.frame = CGRectMake(image_Y, 30, image_W, image_W);
    self.QRimage1.hidden = YES;
    
    self.QRlabel.frame = CGRectMake(24, self.BaseView.bottom+10, ScreenW-48, 45);
    self.SaveButton.frame = CGRectMake(15, self.QRlabel.bottom+15, ScreenW-30, 44);
    //底部
    self.FenLabl.frame = CGRectMake(0, ScreenH - (kIs_iPhoneX ? 220:170), ScreenW, 18);
    self.weixiButton.frame = CGRectMake(0, self.FenLabl.bottom + 10, ScreenW/4, 40);
    self.weipoButton.frame = CGRectMake(self.weixiButton.right, self.FenLabl.bottom + 15, ScreenW/4, 40);
    self.qqButton.frame = CGRectMake(self.weipoButton.right, self.FenLabl.bottom + 15, ScreenW/4, 40);
    self.pengyouButton.frame = CGRectMake(self.qqButton.right, self.FenLabl.bottom + 15, ScreenW/4, 40);

    [self.SaveButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];

    self.isUser = YES;
    
    /*分享至*/
    self.FenLabl.textColor = UIColorFromRGB(0x999999);
    /**
     提示
     */
    self.TextView = [[UIView alloc]initWithFrame:CGRectMake(self.BaseView.width-48, -48 ,2*48, 2*48)];
    /**
     *  1.通过CAGradientLayer 设置渐变的背景。
     */
    CAGradientLayer *layer = [CAGradientLayer new];
    //colors存放渐变的颜色的数组
    layer.colors=@[(__bridge id)UIColorFromRGB(0x4EC3FF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor,(__bridge id)UIColorFromRGB(0x3D8AFF).CGColor];
    /**
     * 起点和终点表示的坐标系位置，(0,0)表示左上角，(1,1)表示右下角
     */
    layer.startPoint = CGPointMake(0, 0);
    layer.endPoint = CGPointMake(1, 0);
    layer.cornerRadius = 40;
    layer.masksToBounds = YES;
    layer.frame = self.TextView.bounds;
    [self.TextView.layer addSublayer:layer];
    
    [self.BaseView addSubview:self.TextView];
    
    self.TextLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.BaseView.width-45, -5 ,48, 48)];
    self.TextLabel.text = @"用户";
    self.TextLabel.textAlignment = 1;
    self.TextLabel.textColor = [UIColor whiteColor];
    self.TextLabel.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:self.TextLabel];
    
    
    
}
#pragma mark - 绘制的新图形
// 添加logo
- (UIImage *)drawImage:(UIImage *)newImage inImage:(UIImage *)sourceImage {
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    // 注意logo的尺寸不要太大,否则可能无法识别
    CGRect rect = CGRectMake( kIs_iPhoneX ? IPHONEWIDTH(299)/2 : IPHONEWIDTH(269)/2, kIs_iPhoneX ? IPHONEHIGHT(553)/2: IPHONEHIGHT(603)/2, kIs_iPhoneX ? IPHONEWIDTH(232)/2: IPHONEWIDTH(212)/2, kIs_iPhoneX ? IPHONEWIDTH(232)/2: IPHONEWIDTH(212)/2);
    //    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [newImage drawInRect:rect];
    
    //返回绘制的新图形
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


//保存图片
- (IBAction)SaveImgAction:(id)sender {
    
    UIImage* newImage = [[UIImage alloc]init];
    
    UIImage *image = [[UIImage alloc]init];
    NSString *BG_iamge = [NSString new];
    
    if (self.isUser == YES) {
        image = self.QRimage.image;
        BG_iamge = @"bg_share_code_customer";
        
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
        
        
        NSData* imageData =  UIImageJPEGRepresentation(imageView.image,0.5);
        
        newImage = [UIImage imageWithData:imageData];
        
    }else{
        image = self.QRimage1.image;
        BG_iamge = @"bg_share_code";
        
       
        
        UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
        
        
        NSData* imageData =  UIImageJPEGRepresentation(imageView.image,0.5);
        
        newImage = [UIImage imageWithData:imageData];
    }
    
    
    
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

#pragma mark - 分享
- (IBAction)weixiAction:(id)sender {
    
    UIImage *image = [[UIImage alloc]init];
    NSString *BG_iamge = [NSString new];
    if (self.isUser == YES) {
        image = self.QRimage.image;
        BG_iamge = @"bg_share_code_customer";

    }else{
        image = self.QRimage1.image;
        BG_iamge = @"bg_share_code";


    }
    
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
    UIImage *weixinimage = imageView.image;

    [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_WechatSession andtThumbImage:weixinimage];

}

- (IBAction)weipoAction:(id)sender {

    
    UIImage *image = [[UIImage alloc]init];
    NSString *BG_iamge = [NSString new];

    if (self.isUser == YES) {
        image = self.QRimage.image;
        BG_iamge = @"bg_share_code_customer";

    }else{
        image = self.QRimage1.image;
        BG_iamge = @"bg_share_code";

    }
    
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
    UIImage *weixinimage = imageView.image;
    
    [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_Sina andtThumbImage:weixinimage];

}

- (IBAction)qqAction:(id)sender {
    UIImage *image = [[UIImage alloc]init];
    NSString *BG_iamge = [NSString new];

    if (self.isUser == YES) {
        image = self.QRimage.image;
        BG_iamge = @"bg_share_code_customer";
 
    }else{
        image = self.QRimage1.image;
        BG_iamge = @"bg_share_code";

    }
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
    UIImage *weixinimage = imageView.image;
    
    [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_QQ andtThumbImage:weixinimage];

}

- (IBAction)pengAction:(id)sender {
    UIImage *image = [[UIImage alloc]init];
    NSString *BG_iamge = [NSString new];

    if (self.isUser == YES) {
        image = self.QRimage.image;
        BG_iamge = @"bg_share_code_customer";

    }else{
        image = self.QRimage1.image;
        BG_iamge = @"bg_share_code";

    }
    UIImageView  *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    imageView.image = [self drawImage:image inImage:[UIImage imageNamed:BG_iamge]];
    UIImage *weixinimage = imageView.image;
    [ [ShareManager sharedShareManager] showShare:UMSocialPlatformType_WechatTimeLine andtThumbImage:weixinimage];

}

@end
