//
//  RoomsController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/15.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsController.h"
#import "RoomsViewone.h"
#import "RoomsViewtwo.h"
#import "RoomsViewImage.h"
#import "RoomsPricing.h"

@interface RoomsController ()<RoomsOneDelegate,RoomsPricingDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)RoomsViewone * scrollView;
@property (strong,nonatomic)RoomsViewtwo * scrollView_2;
@property (strong,nonatomic)RoomsViewImage * scrollView_3;
@property (strong,nonatomic)RoomsPricing * scrollView_4;
@property (strong,nonatomic)RoomsRules * scrollView_5;
@property (strong,nonatomic)preferential * scrollView_6;

@property (strong,nonatomic)UIButton * SaveBtn;
@property (strong,nonatomic)UIButton * nextStepBtn;
@property (strong,nonatomic)UIButton * SaveButton;
@end

@implementation RoomsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.NavSting;

     [self createUI];
}
#pragma mark - UI
-(void)createUI{

    
    
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_offset(0);
        make.bottom.mas_offset(-59);
    }];
    [self.view addSubview:self.SaveBtn];
    [self.view addSubview:self.nextStepBtn];
    [self.view addSubview:self.SaveButton];
    self.SaveButton.hidden = YES;
    [self.SaveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.left.mas_offset(15);
        make.height.mas_offset(40);
        make.width.mas_offset((ScreenW-40)/2);
    }];
    [self.nextStepBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.width.mas_offset((ScreenW-40)/2);
    }];
    
    [self.SaveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.SJScrollView.mas_bottom).offset(10);
        make.right.mas_offset(-15);
        make.height.mas_offset(40);
        make.left.mas_offset(15);
    }];
    
    if ([self.NavSting isEqualToString:@"房间信息"]) {
        [self.SJScrollView addSubview:self.scrollView];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView.height);

    }else if ([self.NavSting isEqualToString:@"房间设施"]){
        [self.SJScrollView addSubview:self.scrollView_2];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView_2.height);

    }else if ([self.NavSting isEqualToString:@"房间照片"]){
        [self.SJScrollView addSubview:self.scrollView_3];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView_3.height);
    }else if ([self.NavSting isEqualToString:@"房间定价"]){
        [self.SJScrollView addSubview:self.scrollView_4];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView_4.height);
    }else if ([self.NavSting isEqualToString:@"房间预定规则"]){
        [self.SJScrollView addSubview:self.scrollView_5];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView_5.height);
    }else{
        [self.SJScrollView addSubview:self.scrollView_6];
        self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.scrollView_6.height);
        
        self.SaveBtn.hidden = YES;
        self.nextStepBtn.hidden = YES;
        self.SaveButton.hidden = NO;

    }
    
    

}
#pragma mark - 选择床型
-(void)BedAtion:(UIButton *)sender{
    
    TypeViewController *VC = [TypeViewController new];
    [self.navigationController pushViewController:VC animated:NO];
    
}

#pragma mark - 退款政策
-(void)TuiAtion:(UIButton *)sender{
    TuiViewController *VC = [TuiViewController new];
    [self.navigationController pushViewController:VC animated:NO];
}

#pragma mark - 要求/留言
-(void)rulesAtion:(UIButton *)sender{
    if (sender.tag == 1) {
        RequirementsController *VC = [RequirementsController new];
        [self.navigationController pushViewController:VC animated:NO];
    }else{
        LeaveAmessageController *VC = [LeaveAmessageController new];
        [self.navigationController pushViewController:VC animated:NO];
    }
    
}

#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 761);
    }
    return _SJScrollView;
}
-(RoomsViewone *)scrollView{
    if (!_scrollView) {
        _scrollView = [[RoomsViewone alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 761)];
        _scrollView.backgroundColor = MainbackgroundColor;
        _scrollView.delagate = self;
        
    }
    return _scrollView;
}
-(RoomsViewtwo *)scrollView_2{
    if (!_scrollView_2) {
        _scrollView_2 = [[RoomsViewtwo alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 947)];
        _scrollView_2.backgroundColor = MainbackgroundColor;
        
    }
    return _scrollView_2;
}
-(RoomsViewImage *)scrollView_3{
    if (!_scrollView_3) {
        _scrollView_3 = [[RoomsViewImage alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 667)];
        _scrollView_3.backgroundColor = MainbackgroundColor;
        
    }
    return _scrollView_3;
}
-(RoomsPricing *)scrollView_4{
    if (!_scrollView_4) {
        _scrollView_4 = [[RoomsPricing alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 667)];
        _scrollView_4.backgroundColor = MainbackgroundColor;
        _scrollView_4.delagate = self;
        
    }
    return _scrollView_4;
}
-(RoomsRules *)scrollView_5{
    if (!_scrollView_5) {
        _scrollView_5 = [[RoomsRules alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 742)];
        _scrollView_5.backgroundColor = MainbackgroundColor;
        _scrollView_5.delagate = self;

    }
    return _scrollView_5;
}
-(preferential *)scrollView_6{
    if (!_scrollView_6) {
        _scrollView_6 = [[preferential alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 667)];
        _scrollView_6.backgroundColor = MainbackgroundColor;
        
    }
    return _scrollView_6;
}
-(UIButton *)SaveBtn{
    if (!_SaveBtn) {
        _SaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveBtn.frame = CGRectMake(15,897,167.5,40);
        _SaveBtn.layer.borderWidth = 1;
        _SaveBtn.layer.borderColor = UIColorFromRGB(0x3D8AFF).CGColor;
        [_SaveBtn setTitle:@"保存" forState:UIControlStateNormal];
        [_SaveBtn setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [_SaveBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _SaveBtn.layer.cornerRadius = 20;
        
    }
    return _SaveBtn;
}
-(UIButton *)nextStepBtn{
    if (!_nextStepBtn) {
        _nextStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextStepBtn.frame = CGRectMake(15,897,167.5,40);
        _nextStepBtn.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        [_nextStepBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextStepBtn setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_nextStepBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _nextStepBtn.layer.cornerRadius = 20;
        
    }
    return _nextStepBtn;
}
-(UIButton *)SaveButton{
    if (!_SaveButton) {
        _SaveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _SaveButton.frame = CGRectMake(15,897,ScreenW-30,40);
        _SaveButton.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        [_SaveButton setTitle:@"保存" forState:UIControlStateNormal];
        [_SaveButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_SaveButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _SaveButton.layer.cornerRadius = 10;
        
    }
    return _SaveButton;
}
@end
