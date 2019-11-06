//
//  FBHAllpubliccardController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/29.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHAllpubliccardController.h"

@interface FBHAllpubliccardController ()<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)publiccardView * scrollView;

@end

@implementation FBHAllpubliccardController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加对公银行卡";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    

    
}

#pragma mark - Get
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 800);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(publiccardView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[publiccardView alloc]init];
        _scrollView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 800);
    }
    return _scrollView;
}
@end
