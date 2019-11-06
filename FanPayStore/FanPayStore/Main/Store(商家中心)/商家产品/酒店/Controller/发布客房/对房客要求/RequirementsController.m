//
//  RequirementsController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/19.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RequirementsController.h"

@interface RequirementsController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)UIView * BaseView_1;
@property (strong,nonatomic)UIView * BaseView_2;
@property (strong,nonatomic)UIButton * SaveButton;
@property (strong,nonatomic)XMTextView * textv;

@end

@implementation RequirementsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"对房客要求";
    [self createUI];
    
}

#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(-59);
    }];
    [self.SJScrollView addSubview:self.BaseView_1];
    [self.SJScrollView addSubview:self.BaseView_2];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15,20,100,14.5);
    label_1.numberOfLines = 0;
    label_1.text = @"基本要求";
    [self.SJScrollView addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,100,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"其他要求";
    [self.SJScrollView addSubview:label_2];
    
    NSArray *Arr = @[@"允许抽烟",@"允许聚会",@"允许做饭",@"允许携带宠物",@"适合儿童（2-12岁）",@"适合婴幼儿（2岁以下）",@"适合老人（60岁以上）"];
    for (int i =0; i<Arr.count; i++) {
        /*line*/
        UIView *line_1 = [[UIView alloc] init];
        line_1.frame = CGRectMake(10,i*50,self.BaseView_1.width-20,0.5);
        line_1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self.BaseView_1 addSubview:line_1];
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10,i*50,200,50);
        label.numberOfLines = 0;
        label.text = [NSString stringWithFormat:@"%@",Arr[i]];
        [self.BaseView_1 addSubview:label];
        
        
    }
    
    
    
    self.textv = [[XMTextView alloc] initWithFrame:CGRectMake(2, 0, self.BaseView_2.width-4, 180)];
    self.textv.placeholder = @"请输入其他要求";
    self.textv.placeholderColor = UIColorFromRGB(0xCCCCCC);
    self.textv.borderLineColor = [UIColor clearColor];
    self.textv.textColor = UIColorFromRGB(0x222222);
    self.textv.textFont = [UIFont systemFontOfSize:13];
    self.textv.textMaxNum = 100;
    self.textv.maxNumState = XMMaxNumStateNormal;
    [self.BaseView_2 addSubview:self.textv];
    self.textv.textViewListening = ^(NSString *textViewStr) {
        NSLog(@"tv2监听输入的内容：%@",textViewStr);
        
    };
    
    
    
    [self.view addSubview:self.SaveButton];
    [self.SaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.left.mas_offset(15);
    }];
    
    
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 761);
    }
    return _SJScrollView;
}
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 353)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
        _BaseView_1.layer.cornerRadius = 5;
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 180)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
        _BaseView_2.layer.cornerRadius = 5;
    }
    return _BaseView_2;
}
-(UIButton *)SaveButton{
    if (!_SaveButton) {
        _SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveButton.frame = CGRectMake(15,897,ScreenW-30,40);
        _SaveButton.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        [_SaveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_SaveButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_SaveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _SaveButton.layer.cornerRadius = 20;
        
    }
    return _SaveButton;
}

@end
