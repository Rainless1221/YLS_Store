//
//  ReviewStatusController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/28.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ReviewStatusController.h"

@interface ReviewStatusController ()
@property (strong,nonatomic)UIScrollView * ScrollView;

@end

@implementation ReviewStatusController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"提交审核";
    [self.view addSubview:self.ScrollView];

    /**/
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(autoScaleW(15),autoScaleW(15),ScreenW - autoScaleW(30),autoScaleW(350));
    view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    view.layer.cornerRadius = 5;
    [self.ScrollView addSubview:view];
/*图片*/
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(72.5,autoScaleW(25),autoScaleW(230),autoScaleW(222.5));
    imageView.image = [UIImage imageNamed:@"examine_submit_complete"];
    [view addSubview: imageView];
    imageView.centerX = view.centerX;

    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,autoScaleW(350)-67,ScreenW - autoScaleW(30),36.5);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    [view addSubview:label];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"提交成功，我们会在1个工作日内 \n反馈审核结果" attributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)],NSForegroundColorAttributeName: [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0]}];
                                         
                                         [string addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)]} range:NSMakeRange(0, 23)];
                                         
                                         [string addAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:autoScaleW(15)]} range:NSMakeRange(0, 23)];
    
    
    
    
    label.attributedText = string;

    
    
    UIButton *StepsButton = [UIButton buttonWithType:UIButtonTypeCustom];
    StepsButton.frame = CGRectMake(autoScaleW(15), view.bottom + autoScaleW(40), ScreenW - autoScaleW(30), 44);
    
    StepsButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    StepsButton.layer.shadowOffset = CGSizeMake(0,4);
    StepsButton.layer.shadowOpacity = 1;
    StepsButton.layer.shadowRadius = 9;
    
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,ScreenW - autoScaleW(30),44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    
    [StepsButton.layer addSublayer:gl];
    
    
    
    [StepsButton setTitle:@"返回" forState:UIControlStateNormal];
    [StepsButton.titleLabel setFont:[UIFont systemFontOfSize:autoScaleW(18)]];
    [StepsButton addTarget:self action:@selector(StepsAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ScrollView addSubview:StepsButton];
    
}

#pragma mark - 返回
-(void)StepsAction{
    [self.navigationController popToRootViewControllerAnimated:YES];

}
#pragma mark ---    懒加载  ---
-(UIScrollView *)ScrollView{
    if (!_ScrollView) {
        _ScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _ScrollView.backgroundColor = MainbackgroundColor;
        _ScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, autoScaleW(667));
    }
    return _ScrollView;
}

@end
