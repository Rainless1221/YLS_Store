//
//  ZhuoImageViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/13.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ZhuoImageViewController.h"

@interface ZhuoImageViewController ()
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)UIImageView * qrcodeImage;
@end

@implementation ZhuoImageViewController
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"店铺桌码生成";
    [self setupNav];
    /**
     *  UI
     */
    [self createUI];
    
}
#pragma mark - 导航栏
-(void)setupNav{
    UIView *NavView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 44+STATUS_BAR_HEIGHT)];
    NavView.backgroundColor = UIColorFromRGB(0xFFFFFF);
    
    //标题
    UILabel *navLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 160, 44)];
    navLabel.text = @"店铺桌码生成";
    navLabel.textColor = UIColorFromRGB(0x222222);
    navLabel.textAlignment = NSTextAlignmentCenter;
    navLabel.font = NavTitleFont;
    navLabel.centerX = NavView.centerX;
    [NavView addSubview:navLabel];
    
    
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(ScreenW-85, STATUS_BAR_HEIGHT, 80, 44)];
    [leftbutton setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    [leftbutton setTitle:@"保存" forState:UIControlStateNormal];

//    [leftbutton setImage:[UIImage imageNamed:@"icn_calendar_black"] forState:UIControlStateNormal];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(RighAction) forControlEvents:UIControlEventTouchUpInside];
    
    //    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:leftbutton];
    //    self.navigationItem.rightBarButtonItem=rightitem;
    
    UIButton *righbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, 60, 44)];
    [righbutton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
    [righbutton setImage:[UIImage imageNamed:@"icn_nav_back_black_normal"] forState:UIControlStateNormal];
    righbutton.layer.cornerRadius = 14;
    [righbutton addTarget:self action:@selector(leftAction) forControlEvents:UIControlEventTouchUpInside];
    
    [NavView addSubview:righbutton];
    [NavView addSubview:leftbutton];
    
    
    [self.view addSubview:NavView];
}
/**
 * 保存
 */
-(void)RighAction{
    UIImage *newImage = [[UIImage alloc]init];
    newImage = [self convertViewToImage:self.BaseView];
    
    [self loadImageFinished:newImage];

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
#pragma amrk - 返回
-(void)leftAction{
    
    ZhuoCodeViewController *homeVC = [[ZhuoCodeViewController alloc] init];
    UIViewController *target = nil;
    for (UIViewController * controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[homeVC class]]) {
            target = controller;
        }
    }
    if (target) {
        [self.navigationController popToViewController:target animated:YES];
    }
}
-(void)AddAction{
    
    //    [self leftAction];
    if (self.navigationController.viewControllers.count >= 2) {
        UIViewController *vc = [self.navigationController.viewControllers objectOrNilAtIndex:1];
        [self.navigationController popToViewController:vc animated:YES];
    }
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.BaseView];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.BaseView.width, self.BaseView.height)];
    image.image = [UIImage imageNamed:@"table_code_bg_type_02"];
    [self.BaseView addSubview:image];
    
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    CAGradientLayer *gl = [CAGradientLayer layer];
//    gl.frame = CGRectMake(0,0,ScreenW-30,44);
//    gl.startPoint = CGPointMake(0, 0);
//    gl.endPoint = CGPointMake(1, 1);
//    gl.colors = @[(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor];
//    gl.locations = @[@(0.0),@(0.5),@(1.0)];
//    gl.cornerRadius = 10;
//    [AddButton.layer addSublayer:gl];
//
//    AddButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//    AddButton.layer.shadowOffset = CGSizeMake(0,4);
//    AddButton.layer.shadowOpacity = 1;
//    AddButton.layer.shadowRadius = 9;
    
    [AddButton setTitle:@"返回" forState:UIControlStateNormal];
    [AddButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [AddButton addTarget:self action:@selector(AddAction) forControlEvents:UIControlEventTouchUpInside];
    [AddButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
    AddButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    AddButton.layer.cornerRadius = 10;
    [self.view addSubview:AddButton];
    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.BaseView.mas_bottom).offset(80);
        make.left.mas_offset(15);
        make.size.mas_offset(CGSizeMake(ScreenW-30, 44));
    }];
    
    /*图片的元素*/
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(12,14,150,11.5);
    label.numberOfLines = 0;
    label.text = @"一鹿省APP";
    label.textColor = [UIColor colorWithRed:185/255.0 green:225/255.0 blue:253/255.0 alpha:1.0];
    label.font = [UIFont systemFontOfSize:12];
//    [self.BaseView addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(13,30,150,11.5);
    label1.numberOfLines = 0;
    label1.text = @"技术支持";
    label1.textColor = [UIColor colorWithRed:120/255.0 green:201/255.0 blue:252/255.0 alpha:1.0];
    label1.font = [UIFont systemFontOfSize:8];
//    [self.BaseView addSubview:label1];
    
    UILabel *label11 = [[UILabel alloc] init];
    label11.frame = CGRectMake(0,270, ScreenW-30,11.5);
    label11.numberOfLines = 0;
    label11.textAlignment =1;
    label11.text = @"扫描二维码，小程序或APP下单";
    label11.textColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    label11.font = [UIFont systemFontOfSize:12];
//    [self.BaseView addSubview:label11];
    
    [self.BaseView addSubview:self.zhuohao];
    [self.zhuohao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(autoScaleW(-42));
        make.left.right.mas_offset(0);
        make.height.mas_offset(60);
    }];
    
    [self.BaseView addSubview:self.qrcodeImage];
    [self.qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.centerY.mas_offset(3);
        make.size.mas_offset(CGSizeMake(120, 120));
    }];
    
    [self.qrcodeImage sd_setImageWithURL:[NSURL URLWithString:self.table_number_qrcode]];
    
}

#pragma mark - 懒加载
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 75, ScreenW-30, ScreenW-30)];
//        _BaseView.backgroundColor = [UIColor colorWithRed:13/255.0 green:175/255.0 blue:250/255.0 alpha:1.0];
    }
    return _BaseView;
}
-(UILabel *)zhuohao{
    if (!_zhuohao) {
        _zhuohao = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, ScreenW-30, 35)];
        _zhuohao.font = [UIFont systemFontOfSize:IPHONEWIDTH(32)];
        _zhuohao.textAlignment = 1;
        _zhuohao.numberOfLines = 0;
        _zhuohao.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _zhuohao;
}
-(UIImageView *)qrcodeImage{
    if (!_qrcodeImage) {
        _qrcodeImage = [[UIImageView alloc]init];
        _qrcodeImage.layer.borderColor = UIColorFromRGB(0xCDCDCD).CGColor;
        _qrcodeImage.layer.borderWidth = 1;
        _qrcodeImage.layer.cornerRadius = 5;
    }
    return _qrcodeImage;
}
@end
