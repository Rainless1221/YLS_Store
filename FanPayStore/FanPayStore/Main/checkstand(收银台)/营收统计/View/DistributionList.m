//
//  DistributionList.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "DistributionList.h"

@implementation DistributionList

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(10,20,200,14.5);
    label_1.numberOfLines = 0;
    label_1.font = [UIFont systemFontOfSize:15];
    label_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label_1.text = @"营收分布列表";
    [self addSubview:label_1];
    
    
    
}
#pragma mark - 懒加载
-(UITableView *)DistriTableView{
    if (!_DistriTableView) {
        _DistriTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _DistriTableView.delegate = self;
        _DistriTableView.dataSource = self;
        _DistriTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        
//        [_DistriTableView registerClass:[WordTableViewCell class] forCellReuseIdentifier:@"WordTableViewCell"];
        
        _DistriTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _DistriTableView;
}
@end
