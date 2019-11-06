//
//  HelpDetailsViewController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/27.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "HelpDetailsViewController.h"
#import "CustomLabel.h"

@interface HelpDetailsViewController ()
@property (strong,nonatomic)UIScrollView * ScrollView;
@property (strong,nonatomic)UIButton * Detailsbutton;
@property (strong,nonatomic)UILabel * DetailsTEXT;
@end

@implementation HelpDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"常见问题";

    [self createUI];
    
}

#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.ScrollView];
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,0,ScreenW,self.ScrollView.contentSize.height);
    view.backgroundColor = [UIColor clearColor];
    [self.ScrollView addSubview:view];

#pragma mark - 标题
    UIView *view_TEXT = [[UIView alloc] init];
    view_TEXT.backgroundColor = UIColorFromRGB(0xF7AE2B);
    view_TEXT.layer.cornerRadius = 5;
    [view addSubview:view_TEXT];
    [view_TEXT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
    }];
    
    [view_TEXT addSubview:self.Detailsbutton];
    [self.Detailsbutton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.width.mas_offset(35);
        make.bottom.mas_offset(0);
    }];
    
    [view_TEXT addSubview:self.DetailsTEXT];
    [self.DetailsTEXT mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(50);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(0);
    }];
    //在线客服
    UIView *view_QY = [[UIView alloc] init];
    view_QY.frame = CGRectMake(0,608,375,59);
    view_QY.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    [self.view addSubview:view_QY];
    [view_QY mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(60);
    }];
    //在线按钮
    UIButton *KF_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [KF_Button setTitle:@"在线客服" forState:UIControlStateNormal];
    [KF_Button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    KF_Button.titleLabel.font = [UIFont systemFontOfSize:16];
    KF_Button.layer.cornerRadius = 20;
    KF_Button.backgroundColor= UIColorFromRGB(0xEEEEEE);
    [KF_Button addTarget:self action:@selector(onlineAction:) forControlEvents:UIControlEventTouchUpInside];
    [view_QY addSubview:KF_Button];
    [KF_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.left.mas_offset(43);
        make.size.mas_offset(CGSizeMake(128, 40));
    }];
    
    UIButton *ZD_Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [ZD_Button setTitle:@"我知道了" forState:UIControlStateNormal];
    [ZD_Button setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    ZD_Button.titleLabel.font = [UIFont systemFontOfSize:16];
    ZD_Button.layer.cornerRadius = 20;
    ZD_Button.backgroundColor= UIColorFromRGB(0xF7AE2B);
    [ZD_Button addTarget:self action:@selector(ZDAction:) forControlEvents:UIControlEventTouchUpInside];
    [view_QY addSubview:ZD_Button];
    [ZD_Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(10);
        make.right.mas_offset(-43);
        make.size.mas_offset(CGSizeMake(128, 40));
    }];
    
    
    
#pragma mark -  赋值
//    [self.Detailsbutton setTitle:[NSString stringWithFormat:@"%@",self.Data[@"question"]] forState:UIControlStateNormal];
    self.DetailsTEXT.text = [NSString stringWithFormat:@"%@",self.Data[@"question"]];
    
     NSString *labelText=[NSString stringWithFormat:@"%@ ",self.Data[@"answer"]];
    
    CustomLabel *label = [[CustomLabel alloc] initWithFrame:CGRectMake(15,74,ScreenW-30,100)];
    label.numberOfLines = 0;
    label.backgroundColor = [UIColor whiteColor];
    label.layer.cornerRadius = 5;
    label.font = [UIFont systemFontOfSize:13];
    label.edgeInsets    = UIEdgeInsetsMake(10.f, 10.f, 10.f, 10.f); // 设置内边距

     NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[labelText dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    [view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(74);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];

    label.attributedText = attrStr;
    self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, view.bottom+150);

    
//    NSString * htmlString =@"<html><body> Some html string \n <font size=\"13\" color=\"red\">This is some text!</font> </body></html>";
//    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType } documentAttributes:nil error:nil];
//    UILabel * myLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)]; // 这里可以结合 自动布局(Masary),让label 自动扩充
//    myLabel.attributedText = attrStr;
//    [view addSubview:myLabel];
    
    
//    NSString *store_pic = [NSString stringWithFormat:@"%@",self.Data[@"pics"]];
//    // 用指定字符串分割字符串，返回一个数组
//    NSArray *array = [store_pic componentsSeparatedByString:@","];
//    for (int i = 0; i<array.count; i++) {
//
//        NSString *picRrl = [NSString stringWithFormat:@"%@",array[i]];
//        if ([PublicMethods isUrl:picRrl]) {
//
//        }else{
//            picRrl = [NSString stringWithFormat:@"%@%@",FBHApi_Url,picRrl];
//        }
//
//            UIImageView *pics = [[UIImageView alloc]init];
//            pics.layer.cornerRadius = 10;
//            pics.frame = CGRectMake(15, label.bottom+10+i*autoScaleW(150), ScreenW-30,  autoScaleW(430)*(i+1));
//            pics.layer.masksToBounds = YES;
//            [view addSubview:pics];
//            [pics mas_makeConstraints:^(MASConstraintMaker *make) {
//                make.top.equalTo(label.mas_bottom).offset(10+i*autoScaleW(430));
//                make.left.mas_offset(15);
//                make.right.mas_offset(-15);
//                make.height.mas_offset(autoScaleW(430));
//            }];
//
//            [pics setImageWithURL:[NSURL URLWithString:picRrl] placeholder:[UIImage imageNamed:@""]];
//            self.ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, pics.bottom+300);
//
//    }

    
}
#pragma mark -/** 在线客服 **/
- (void)onlineAction:(UIButton *)sender{
    QYSource *source = [[QYSource alloc] init];
    source.title = @"一鹿省客服";
    source.urlString = @"https://qiyukf.com/";
    storeBaseModel *model = [storeBaseModel getUseData];
    [QYCustomUIConfig sharedInstance].customerHeadImageUrl =  [NSString stringWithFormat:@"%@",model.store_logo];
    
    QYSessionViewController *sessionViewController = [[QYSDK sharedSDK] sessionViewController];
    sessionViewController.sessionTitle = @"一鹿省客服";
    sessionViewController.source = source;
    sessionViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:sessionViewController animated:YES];
}
#pragma mark -/** 我知道了 **/
- (void)ZDAction:(UIButton *)sender{
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 懒加载
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-60)];
        _ScrollView.backgroundColor = MainbackgroundColor;
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(2083));
    }
    return _ScrollView;
}
-(UIButton *)Detailsbutton{
    if (!_Detailsbutton) {
        _Detailsbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        _Detailsbutton.frame = CGRectMake(15, 10, ScreenW-30, 44);
        [_Detailsbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _Detailsbutton.titleLabel.font = [UIFont systemFontOfSize:15];
        _Detailsbutton.layer.cornerRadius = 5;
        [_Detailsbutton setImage:[UIImage imageNamed:@"icn_faq_title"] forState:UIControlStateNormal];
//        [_Detailsbutton setImageEdgeInsets:UIEdgeInsetsMake(0, -(ScreenW-12)/2, 0, 0)];
//        [_Detailsbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, -(ScreenW-50)/2, 0, 0)];
    }
    return _Detailsbutton;
}
-(UILabel *)DetailsTEXT{
    if (!_DetailsTEXT) {
        _DetailsTEXT = [[UILabel alloc]init];
        _DetailsTEXT.font = [UIFont systemFontOfSize:15];
        _DetailsTEXT.textColor = [UIColor whiteColor];
        _DetailsTEXT.numberOfLines=2;
    }
    return _DetailsTEXT;
}
@end
