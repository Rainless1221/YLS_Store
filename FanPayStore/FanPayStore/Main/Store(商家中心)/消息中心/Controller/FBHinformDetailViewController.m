//
//  FBHinformDetailViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHinformDetailViewController.h"

@interface FBHinformDetailViewController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)UIView * BaseView;
@end

@implementation FBHinformDetailViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.navigationItemText;
    /**
     * UI
     */
    [self createUI];
    [self detail:self.news_id];
    
    /*
     "add_time" = "07-08 10:34";
     "has_detail" = 1;
     "is_read" = 1;
     "news_content" = "\U9884\U8ba1\U660e\U5929\U5230\U8d26\U3002\U5982\U679c\U63d0\U73b0\U5931\U8d25\Uff0c\U4f59\U989d\U5c06\U8fd4\U8fd8\Uff0c\U5230\U65f6\U9ebb\U70e6\U60a8\U91cd\U65b0\U63d0\U4ea4\U63d0\U73b0\U7533\U8bf7\U3002";
     "news_id" = 15640;
     "news_pic" = "";
     "news_title" = "\U63d0\U73b0\U7533\U8bf7\U63d0\U4ea4\U6210\U529f";
     "read_id" = 16388;
     
     */
}
#pragma mark - 详情
-(void)detail:(NSString *)news_id{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]detail_news_info:model.merchant_id andnews_id:news_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            
            NSDictionary *DIC=resDic[@"data"][@"news_info"];

//            [SVProgressHUD showSuccessWithStatus:resDic[@"message"]];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
    } andfailure:^{
        
    }];
    
}

#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.BaseView];
    
    [self.BaseView addSubview:self.news_title];
    [self.BaseView addSubview:self.add_time];
    [self.BaseView addSubview:self.news_pic];
    [self.BaseView addSubview:self.news_content];

    
}

-(void)setData:(NSDictionary *)Data{
    
    self.news_title.text = [NSString stringWithFormat:@"%@",Data[@"news_title"]];
    [self.news_title sizeToFit];
    
    self.add_time.text = [NSString stringWithFormat:@"%@",Data[@"add_time"]];
    
    

    if (kStringIsEmpty(Data[@"news_pic"])) {
        self.news_pic.height = 0;
        self.news_content.mj_y = self.news_pic.bottom;
        self.BaseView.height = 362.5- 170;
    }else{
        NSString *url = [NSString stringWithFormat:@"%@",Data[@"news_pic"]];
        [self.news_pic sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@""]];
        self.BaseView.height = 362.5;

    }
    
    self.news_content.text = [NSString stringWithFormat:@"%@",Data[@"news_content"]];
    [self.news_content sizeToFit];
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 670);
    }
    return _SJScrollView;
}
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc] init];
        _BaseView.frame = CGRectMake(0,0,ScreenW,362.5);
        _BaseView.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _BaseView;
}
-(UILabel *)news_title{
    if (!_news_title) {
        _news_title = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 45)];
        _news_title.numberOfLines = 0;
        _news_title.font = [UIFont systemFontOfSize:20];
        _news_title.textColor = UIColorFromRGB(0x222222);
    }
    return _news_title;
}
-(UILabel *)add_time{
    if (!_add_time) {
        _add_time = [[UILabel alloc]initWithFrame:CGRectMake(15, self.news_title.bottom, ScreenW-30, 15)];
        _add_time.font = [UIFont systemFontOfSize:15];
        _add_time.textColor = UIColorFromRGB(0x999999);
    }
    return _add_time;
}

-(UIImageView *)news_pic{
    if (!_news_pic) {
        _news_pic = [[UIImageView alloc]initWithFrame:CGRectMake(15, self.add_time.bottom+21, ScreenW-30, 150)];
    }
    return _news_pic;
}
-(UILabel *)news_content{
    if (!_news_content) {
        _news_content = [[UILabel alloc]initWithFrame:CGRectMake(15, self.news_pic.bottom+2, ScreenW-30, 15)];
        _news_content.font = [UIFont systemFontOfSize:15];
        _news_content.textColor = UIColorFromRGB(0x222222);
        _news_content.numberOfLines= 0;
    }
    return _news_content;
}
@end
