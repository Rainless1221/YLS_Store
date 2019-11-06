//
//  FBHcardSaoViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHcardSaoViewController.h"

@interface FBHcardSaoViewController ()

@end

@implementation FBHcardSaoViewController
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    [view stopCamera];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    [flashButton setImage:[UIImage imageNamed:@"iconfont-llalbumflashon"] forState:UIControlStateNormal];
    //    [view startCamera];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"扫描银行卡";
    [self createUI];
}
#pragma mark - UI
-(void)createUI{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
