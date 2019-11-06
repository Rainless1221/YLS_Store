//
//  StepsViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "StepsViewController.h"

@interface StepsViewController ()
@property (strong,nonatomic)UIScrollView * StepsScrollView;
@property (strong,nonatomic)UIButton * checkButton;
@end

@implementation StepsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商家入驻";
    [self.view addSubview:self.StepsScrollView];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(autoScaleW(15),autoScaleW(15),ScreenW - autoScaleW(30),autoScaleW(200));
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,autoScaleW(11),view.width,12.5);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    [view addSubview:label];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"开店前请准备以下" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label.attributedText = string;
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(0,label.bottom+10,view.width,16.5);
    label1.numberOfLines = 0;    label1.textAlignment = 1;
    [view addSubview:label1];
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"5种图片资料" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
    
    label1.attributedText = string1;
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(0,view.bottom - 35,view.width ,12.5);
    label2.textColor = UIColorFromRGB(0x999999);
    label2.numberOfLines = 0;    label2.textAlignment = 1;
    [view addSubview:label2];   label2.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label2.text = @"( 建议您在证件齐全的店铺内完成 )";
    
    
    /* 图片 */
    UIImageView *imageView1 = [[UIImageView alloc] init];
    imageView1.frame = CGRectMake(0,label1.bottom+5,autoScaleW(200),autoScaleW(90));
    imageView1.centerX = view.centerX;
    imageView1.image = [UIImage imageNamed:@"bg_merchant_entry_tips"];
    [view addSubview:imageView1];
    
    
    
    
    
#pragma mark ----------------------------------
    UIView *view1 = [[UIView alloc] init];
    view1.frame = CGRectMake(autoScaleW(15),view.bottom + autoScaleW(10),ScreenW - autoScaleW(30),autoScaleW(120));
    view1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view1.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view1];

    UILabel *label_one = [[UILabel alloc] init];
    label_one.frame = CGRectMake(autoScaleW(10),autoScaleW(15),autoScaleW(18),autoScaleW(18));
    label_one.textColor = [UIColor whiteColor];
    label_one.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_one.numberOfLines = 0;
    label_one.textAlignment = 1;
    label_one.layer.cornerRadius = autoScaleW(18)/2;
    label_one.layer.masksToBounds = YES;
    [view1 addSubview:label_one];
    label_one.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label_one.text = @"1";
    
    UILabel *label3 = [[UILabel alloc] init];
    label3.frame = CGRectMake(label_one.right+autoScaleW(12),autoScaleW(16),autoScaleW(120),17);
    label3.numberOfLines = 0;
    [view1 addSubview:label3];
    
    NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"门店照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]}];
    
    label3.attributedText = string3;
    
    
    
    /* 图片 */
    UIImageView *imageView2 = [[UIImageView alloc] init];
    imageView2.frame = CGRectMake(view1.width -autoScaleW(120)-11 ,autoScaleW(15),autoScaleW(120),autoScaleW(90));
    imageView2.image = [UIImage imageNamed:@"店内环境照片-2"];
    [view1 addSubview:imageView2];
    
    UIImageView *imageView2_icon = [[UIImageView alloc] init];
    imageView2_icon.frame = CGRectMake(0 ,0,autoScaleW(16),autoScaleW(16));
    imageView2_icon.image = [UIImage imageNamed:@"tag_image_example"];
    [imageView2 addSubview:imageView2_icon];
    
    
    
    UILabel *label_text1 = [[UILabel alloc] init];
    label_text1.frame = CGRectMake(label_one.right+autoScaleW(12),label3.bottom+16,autoScaleW(155.5),autoScaleW(50));
    label_text1.numberOfLines = 0;
    [view1 addSubview:label_text1];
    
    NSMutableAttributedString *string_text1 = [[NSMutableAttributedString alloc] initWithString:@"需拍出完整门匾，门框（建议正对门店2米处拍摄）" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label_text1.attributedText = string_text1;
    
#pragma mark ----------------------------------

    UIView *view2 = [[UIView alloc] init];
    view2.frame = CGRectMake(autoScaleW(15),view1.bottom + autoScaleW(10),ScreenW - autoScaleW(30),autoScaleW(120));
    view2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view2.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view2];
    UILabel *label_two = [[UILabel alloc] init];
    label_two.frame = CGRectMake(autoScaleW(10),autoScaleW(15),autoScaleW(18),autoScaleW(18));
    label_two.textColor = [UIColor whiteColor];
    label_two.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_two.numberOfLines = 0;
    label_two.textAlignment = 1;
    label_two.layer.cornerRadius = autoScaleW(18)/2;
    label_two.layer.masksToBounds = YES;
    [view2 addSubview:label_two];
    label_two.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label_two.text = @"2";
    
    UILabel *label4 = [[UILabel alloc] init];
    label4.frame = CGRectMake(label_two.right+autoScaleW(12),autoScaleW(16),autoScaleW(120),17);
    label4.numberOfLines = 0;
    [view2 addSubview:label4];
    
    NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@"店内环境照片" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]}];
    
    label4.attributedText = string4;
    
    
    
    /* 图片 */
    UIImageView *imageView3 = [[UIImageView alloc] init];
    imageView3.frame = CGRectMake(view2.width -autoScaleW(120)-11 ,autoScaleW(15),autoScaleW(120),autoScaleW(90));
    imageView3.image = [UIImage imageNamed:@"店内环境照片-1"];
    [view2 addSubview:imageView3];
    
    UIImageView *imageView3_icon = [[UIImageView alloc] init];
    imageView3_icon.frame = CGRectMake(0 ,0,autoScaleW(16),autoScaleW(16));
    imageView3_icon.image = [UIImage imageNamed:@"tag_image_example"];
    [imageView3 addSubview:imageView3_icon];
    
    UILabel *label_text2 = [[UILabel alloc] init];
    label_text2.frame = CGRectMake(label_two.right+autoScaleW(12),label4.bottom+16,155,32.5);
    label_text2.numberOfLines = 0;
    [view2 addSubview:label_text2];
    
    NSMutableAttributedString *string_text2 = [[NSMutableAttributedString alloc] initWithString:@"需真是反应用餐情况（收银台、用餐桌椅）" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:13],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
    
    label_text2.attributedText = string_text2;
    
    
#pragma mark ----------------------------------

    UIView *view3 = [[UIView alloc] init];
    view3.frame = CGRectMake(autoScaleW(15),view2.bottom + autoScaleW(10),ScreenW - autoScaleW(30),autoScaleW(176.5));
    view3.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view3.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view3];
    UILabel *label_Three = [[UILabel alloc] init];
    label_Three.frame = CGRectMake(autoScaleW(10),autoScaleW(15),autoScaleW(18),autoScaleW(18));
    label_Three.textColor = [UIColor whiteColor];
    label_Three.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_Three.numberOfLines = 0;
    label_Three.textAlignment = 1;
    label_Three.layer.cornerRadius = autoScaleW(18)/2;
    label_Three.layer.masksToBounds = YES;
    [view3 addSubview:label_Three];
    label_Three.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label_Three.text = @"3";
    
    UILabel *label5 = [[UILabel alloc] init];
    label5.frame = CGRectMake(label_Three.right+autoScaleW(12),autoScaleW(16),autoScaleW(150),50);
    label5.numberOfLines = 0;
    [view3 addSubview:label5];
    
    NSMutableAttributedString *string5 = [[NSMutableAttributedString alloc] initWithString:@"法定代表人身 份证照" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]}];
    
    label5.attributedText = string5;
    
    
    
    
    /* 图片 */
    UIImageView *imageView4 = [[UIImageView alloc] init];
    imageView4.frame = CGRectMake(view3.width -autoScaleW(120)-11 ,autoScaleW(15),autoScaleW(120),autoScaleW(90));
    imageView4.image = [UIImage imageNamed:@"身份证-正面"];
    [view3 addSubview:imageView4];
    
    UIImageView *imageView4_icon = [[UIImageView alloc] init];
    imageView4_icon.frame = CGRectMake(0 ,0,autoScaleW(16),autoScaleW(16));
    imageView4_icon.image = [UIImage imageNamed:@"tag_image_example"];
    [imageView4 addSubview:imageView4_icon];
    
    UILabel *label_text3 = [[UILabel alloc] init];
    label_text3.frame = CGRectMake(label_Three.right+autoScaleW(12),label5.bottom,autoScaleW(155.5),95);
    label_text3.numberOfLines = 0;
    [view3 addSubview:label_text3];
    /*
     需清晰展示身份证信息 需拍摄身份证正、反面两张图片 不可自拍
     */
    NSMutableAttributedString *string_text3 = [[NSMutableAttributedString alloc] initWithString:@"需清晰展示身份证信息 \n需拍摄身份证正、反面两张图片 \n不可自拍" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                                         
                                         [string_text3 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 10)];
                                         
                                         [string_text3 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 10)];
                                         
                                         [string_text3 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 10)];
    
    label_text3.attributedText = string_text3;

#pragma mark ----------------------------------

    UIView *view4 = [[UIView alloc] init];
    view4.frame = CGRectMake(autoScaleW(15),view3.bottom + autoScaleW(10),ScreenW - autoScaleW(30),autoScaleW(136.5));
    view4.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view4.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view4];
    UILabel *label_four = [[UILabel alloc] init];
    label_four.frame = CGRectMake(autoScaleW(10),autoScaleW(15),autoScaleW(18),autoScaleW(18));
    label_four.textColor = [UIColor whiteColor];
    label_four.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_four.numberOfLines = 0;
    label_four.textAlignment = 1;
    label_four.layer.cornerRadius = autoScaleW(18)/2;
    label_four.layer.masksToBounds = YES;
    [view4 addSubview:label_four];
    label_four.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label_four.text = @"4";
    
    
    UILabel *label6 = [[UILabel alloc] init];
    label6.frame = CGRectMake(label_Three.right+autoScaleW(12),autoScaleW(16),autoScaleW(120),17);
    label6.numberOfLines = 0;
    [view4 addSubview:label6];
    
    NSMutableAttributedString *string6 = [[NSMutableAttributedString alloc] initWithString:@"营业执照" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]}];
    
    label6.attributedText = string6;
    
    
    
    
    
    
    /* 图片 */
    UIImageView *imageView5 = [[UIImageView alloc] init];
    imageView5.frame = CGRectMake(view4.width -autoScaleW(120)-11 ,autoScaleW(15),autoScaleW(120),autoScaleW(90));
    imageView5.image = [UIImage imageNamed:@"营业执照"];
    [view4 addSubview:imageView5];
    
    UIImageView *imageView5_icon = [[UIImageView alloc] init];
    imageView5_icon.frame = CGRectMake(0 ,0,autoScaleW(16),autoScaleW(16));
    imageView5_icon.image = [UIImage imageNamed:@"tag_image_example"];
    [imageView5 addSubview:imageView5_icon];
    
    UILabel *label_text4 = [[UILabel alloc] init];
    label_text4.frame = CGRectMake(label_four.right+autoScaleW(12),label6.bottom+16,autoScaleW(155.5),72);
    label_text4.numberOfLines = 0;
    [view4 addSubview:label_text4];
    
    NSMutableAttributedString *string_text4 = [[NSMutableAttributedString alloc] initWithString:@"需文字清晰、边框完整、露出国徽 \n拍复印件需加盖印章，可用有效特许证件代替" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                                         
                                         [string_text4 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 37)];
                                         
                                         [string_text4 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 37)];
    
    label_text4.attributedText = string_text4;

    
    
#pragma mark ----------------------------------

    UIView *view5 = [[UIView alloc] init];
    view5.frame = CGRectMake(autoScaleW(15),view4.bottom + autoScaleW(10),ScreenW - autoScaleW(30),autoScaleW(136.5));
    view5.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view5.layer.cornerRadius = 5;
    [self.StepsScrollView addSubview:view5];
    UILabel *label_five = [[UILabel alloc] init];
    label_five.frame = CGRectMake(autoScaleW(10),autoScaleW(15),autoScaleW(18),autoScaleW(18));
    label_five.textColor = [UIColor whiteColor];
    label_five.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    label_five.numberOfLines = 0;
    label_five.textAlignment = 1;
    label_five.layer.cornerRadius = autoScaleW(18)/2;
    label_five.layer.masksToBounds = YES;
    [view5 addSubview:label_five];
    label_five.font = [UIFont systemFontOfSize:autoScaleW(13)];
    label_five.text = @"5";
    
    UILabel *label7 = [[UILabel alloc] init];
    label7.frame = CGRectMake(label_Three.right+autoScaleW(12),autoScaleW(16),autoScaleW(120),17);
    label6.numberOfLines = 0;
    [view5 addSubview:label7];
    
    NSMutableAttributedString *string7 = [[NSMutableAttributedString alloc] initWithString:@"许可证" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(18)],NSForegroundColorAttributeName: [UIColor colorWithRed:40/255.0 green:40/255.0 blue:40/255.0 alpha:1.0]}];
    
    label7.attributedText = string7;
    
    
    
    
    /* 图片 */
    UIImageView *imageView6 = [[UIImageView alloc] init];
    imageView6.frame = CGRectMake(view5.width -autoScaleW(120)-11 ,autoScaleW(15),autoScaleW(120),autoScaleW(90));
    imageView6.image = [UIImage imageNamed:@"许可证"];
    [view5 addSubview:imageView6];
    
    UIImageView *imageView6_icon = [[UIImageView alloc] init];
    imageView6_icon.frame = CGRectMake(0 ,0,autoScaleW(16),autoScaleW(16));
    imageView6_icon.image = [UIImage imageNamed:@"tag_image_example"];
    [imageView6 addSubview:imageView6_icon];
    
    UILabel *label_text5 = [[UILabel alloc] init];
    label_text5.frame = CGRectMake(label_five.right+autoScaleW(12),label7.bottom+16,autoScaleW(155.5),72);
    label_text5.numberOfLines = 0;
    [view5 addSubview:label_text5];
    
    NSMutableAttributedString *string_text5 = [[NSMutableAttributedString alloc] initWithString:@"需文字清晰、边框完整 \n可用餐饮服务许可证、食品流通证等市场监督管理局下发证件代替" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)],NSForegroundColorAttributeName: [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0]}];
                                         
                                         [string_text5 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 41)];
                                         
                                         [string_text5 addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(13)]} range:NSMakeRange(0, 41)];
                                         
                                         
    label_text5.attributedText = string_text5;

    
    
    UIButton *StepsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StepsButton.frame = CGRectMake(autoScaleW(15), view5.bottom + autoScaleW(57), ScreenW - autoScaleW(30), 44);
    
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW - autoScaleW(30),44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;

    [StepsButton.layer addSublayer:gl];

    [StepsButton setTitle:@"马上申请入驻" forState:UIControlStateNormal];
    [StepsButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(18)]];
    [StepsButton addTarget:self action:@selector(StepsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.StepsScrollView addSubview:StepsButton];

    
    
    
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.frame = CGRectMake(autoScaleW(15), view5.bottom, 30, autoScaleW(57));
    [Button setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
    [Button setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
    [Button addTarget:self action:@selector(ButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.StepsScrollView addSubview:Button];
    self.checkButton = Button;
    NSString * IsXieyi = [PublicMethods readFromUserD:@"IsXieyi"];
    if ([IsXieyi isEqualToString:@"1"]) {
        Button.selected = YES;
    }
    /*阅读并同意《翻呗花商家入驻协议》*/
    UILabel *label_xieyi = [[UILabel alloc] init];
    label_xieyi.frame = CGRectMake(Button.right+5,view5.bottom,186.5,57);
    label_xieyi.numberOfLines = 0;
    label_xieyi.text = @"阅读并同意";
    label_xieyi.font = [UIFont systemFontOfSize:autoScaleW(12)];
    [self.StepsScrollView addSubview:label_xieyi];
    [label_xieyi sizeToFit];
    label_xieyi.centerY = Button.centerY;
    
    UIButton *Button_xieyi = [UIButton buttonWithType:UIButtonTypeCustom];
    Button_xieyi.frame = CGRectMake(label_xieyi.right+5, view5.bottom, 186, 57);
    [Button_xieyi setTitle:@"《翻呗花商家入驻协议》" forState:UIControlStateNormal];
    [Button_xieyi.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(12)]];
    [Button_xieyi setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
    [Button_xieyi addTarget:self action:@selector(Button_xieyiAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.StepsScrollView addSubview:Button_xieyi];
    [Button_xieyi sizeToFit];
    Button_xieyi.centerY = Button.centerY;

    
}
#pragma mark - 申请入驻
-(void)StepsAction{
    if (self.checkButton.selected == NO) {
        //阅读并同意
        [SVProgressHUD setMinimumDismissTimeInterval:0.5];
        [SVProgressHUD showErrorWithStatus:@"阅读并同意协议"];
        return;
    }
    [self.navigationController pushViewController:[StoreNameViewController new] animated:YES];

}
-(void)ButtonAction:(UIButton *)sender{
//    sender.selected = !sender.selected;
    if (sender.selected == NO) {
        sender.selected = YES;
        [PublicMethods writeToUserD:@"1" andKey:@"IsXieyi"];
    }else{
        sender.selected = NO;
        [PublicMethods writeToUserD:@"0" andKey:@"IsXieyi"];
    }
}
#pragma mark - 协议
-(void)Button_xieyiAction:(UIButton *)sender{

    FBHinformationViewController *VC = [FBHinformationViewController new];
    VC.Navtitle = @"入驻协议";
    VC.agreeUrl = FBHApi_HTML_Ruzhu;
    [self.navigationController pushViewController:VC animated:NO];
}
#pragma mark ---    懒加载  ---
-(UIScrollView *)StepsScrollView{
    if (!_StepsScrollView) {
        _StepsScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _StepsScrollView.backgroundColor = MainbackgroundColor;
        _StepsScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(1150));
    }
    return _StepsScrollView;
}

@end
