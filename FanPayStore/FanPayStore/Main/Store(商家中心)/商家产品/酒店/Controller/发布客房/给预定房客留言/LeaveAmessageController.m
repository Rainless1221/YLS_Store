//
//  LeaveAmessageController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/19.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "LeaveAmessageController.h"

@interface LeaveAmessageController ()
@property (strong,nonatomic)UIButton * SaveButton;
@property (strong,nonatomic)XMTextView * textv;

@end

@implementation LeaveAmessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"给预定房客留言";
    [self createUI];
    
}

#pragma mark - UI
-(void)createUI{
    
    self.textv = [[XMTextView alloc] initWithFrame:CGRectMake(15, 15, ScreenW-30, 180)];
    self.textv.placeholder = @"客房预定成功后会收到您的留言";
    self.textv.placeholderColor = UIColorFromRGB(0xCCCCCC);
    self.textv.borderLineColor = [UIColor clearColor];
    self.textv.textColor = UIColorFromRGB(0x222222);
    self.textv.textFont = [UIFont systemFontOfSize:13];
    self.textv.textMaxNum = 100;
    self.textv.maxNumState = XMMaxNumStateNormal;
    [self.view addSubview:self.textv];
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
