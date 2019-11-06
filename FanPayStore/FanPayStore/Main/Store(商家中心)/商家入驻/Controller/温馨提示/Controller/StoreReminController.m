//
//  StoreReminController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/8.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StoreReminController.h"
#import "ReminView.h"
#import "StoreRemin.h"

@interface StoreReminController ()
@property (strong,nonatomic)UIScrollView * SJScrollView;

@property (strong,nonatomic)StoreRemin * StoreView;
@property (strong,nonatomic)NSMutableArray * store_tips;
@end

@implementation StoreReminController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.StoreView];
    [self get_store_tips];
    
}
-(void)get_store_tips{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_tips:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"];
            [self.store_tips removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_tips"]) {
                [self.store_tips addObject:dict];
            }
            self.StoreView.Data = self.store_tips;
           
            
            
        }else{
        }
    } andfailure:^{
        
    }];
}

#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 603);
    }
    return _SJScrollView;
}
-(StoreRemin *)StoreView{
    if (!_StoreView) {
        _StoreView = [[StoreRemin alloc]initWithFrame:CGRectMake(15, 75, ScreenW-30, 500)];
        _StoreView.backgroundColor = [UIColor whiteColor];
        _StoreView.layer.cornerRadius = 5;
//        _StoreView.delagate = self;
    }
    return _StoreView;
}
-(NSMutableArray *)store_tips{
    if (!_store_tips) {
        _store_tips = [NSMutableArray array];
    }
    return _store_tips;
}

@end
