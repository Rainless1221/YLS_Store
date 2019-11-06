//
//  RoomsViewImage.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsViewImage.h"

@implementation RoomsViewImage

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    [self addSubview:self.BaseView_1];
    [self addSubview:self.BaseView_2];
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(15,20,100,14.5);
    label_1.numberOfLines = 0;
    label_1.text = @"封面（1/1）";
    [self addSubview:label_1];
    
    UILabel *label_11 = [[UILabel alloc] init];
    label_11.frame = CGRectMake(10,20,self.BaseView_1.width-20,14.5);
    label_11.numberOfLines = 0;
    label_11.text = @"请上传一张照片作为封面，建议横图";
    label_11.font = [UIFont systemFontOfSize:15];
    [self.BaseView_1 addSubview:label_11];
    
    
#pragma mark ----------------------
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(15,self.BaseView_1.bottom+20,200,14.5);
    label_2.numberOfLines = 0;
    label_2.text = @"房间照片（5/10）";
    [self addSubview:label_2];
    
    UILabel *label_22 = [[UILabel alloc] init];
    label_22.frame = CGRectMake(10,20,self.BaseView_2.width-20,14.5);
    label_22.numberOfLines = 0;
    label_22.text = @"请上传房间照片，至少一张";
    label_22.font = [UIFont systemFontOfSize:15];
    [self.BaseView_2 addSubview:label_22];
    
    
    

    
}
#pragma mark - 懒加载
-(UIView *)BaseView_1{
    if (!_BaseView_1) {
        _BaseView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, 49, ScreenW-30, 148)];
        _BaseView_1.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_1;
}
-(UIView *)BaseView_2{
    if (!_BaseView_2) {
        _BaseView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.BaseView_1.bottom+49, ScreenW-30, 204)];
        _BaseView_2.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView_2;
}


@end
