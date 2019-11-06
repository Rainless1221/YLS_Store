//
//  ServiceFacilityController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ServiceFacilityController.h"
#import "ServiceFacility.h"


@interface ServiceFacilityController ()<ServiceDelegate>
@property (strong,nonatomic)UIScrollView * SJScrollView;

@property (strong,nonatomic)ServiceFacility * StoreView;
@end

@implementation ServiceFacilityController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.StoreView];
    
}
-(void)Facility:(UIView *)ReminV and:(UIButton* )icon{
    
    if (icon.isSelected) {
//        [self.reminderArray addObject:self.Data1[ReminV.tag][@"info_id"]];
    } else {
//        [self.reminderArray removeObject:self.Data1[ReminV.tag][@"info_id"]];
    }
    
    
    
}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 850);
    }
    return _SJScrollView;
}
-(ServiceFacility *)StoreView{
    if (!_StoreView) {
        _StoreView = [[ServiceFacility alloc]initWithFrame:CGRectMake(15, 75, ScreenW-30, 500)];
        _StoreView.backgroundColor = [UIColor clearColor];
        _StoreView.layer.cornerRadius = 5;
        _StoreView.delagate = self;
    }
    return _StoreView;
}
@end
