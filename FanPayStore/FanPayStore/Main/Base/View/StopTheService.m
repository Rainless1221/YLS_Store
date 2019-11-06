//
//  StopTheService.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/17.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StopTheService.h"

@implementation StopTheService

-(instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        UIView *bgView = [UIApplication sharedApplication].delegate.window;
//        [bgView addSubview:self];
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];

        [self addSubview:self.Baseview];
        [self.Baseview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ScreenW-50, 450));
            make.center.mas_offset(0);
        }];
        
        
        UIImageView *image = [[UIImageView alloc]init];
//        image.backgroundColor = [UIColor redColor];
        image.image = [UIImage imageNamed:@"system_upgrade_suspension"];
        [self.Baseview addSubview:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(7);
            make.centerX.mas_offset(0);
            make.height.mas_offset(272);
            make.right.mas_offset(-40);
            make.left.mas_offset(40);
        }];
        
        UILabel *label_1 = [[UILabel alloc] init];
        label_1.numberOfLines = 0;
        label_1.textAlignment =1;
        label_1.textColor = [UIColor blackColor];
        label_1.font = [UIFont systemFontOfSize:15];
        label_1.text = @"服务器升级中";
        [self.Baseview addSubview:label_1];
        [label_1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.equalTo(image.mas_bottom).offset(24);
            make.height.mas_offset(15);
        }];
        
        UILabel *label_11 = [[UILabel alloc] init];
        label_11.numberOfLines = 0;
        label_11.textAlignment =1;
        label_11.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        label_11.font = [UIFont systemFontOfSize:13];
        label_11.text = @"- 请耐心等待";
        [self.Baseview addSubview:label_11];
        [label_11 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.equalTo(label_1.mas_bottom).offset(20);
            make.height.mas_offset(13);
        }];
        
        
        self.label_111 = [[UILabel alloc] init];
        self.label_111.numberOfLines = 0;
        self.label_111.textAlignment =1;
        self.label_111.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        self.label_111.font = [UIFont systemFontOfSize:13];
//        self.label_111.text = @"- 预计 2019-07-02 18:00  恢复使用";
        [self.Baseview addSubview:self.label_111];
        [self.label_111 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.top.equalTo(label_11.mas_bottom).offset(9);
            make.height.mas_offset(13);
        }];
        
        
        /*line*/
        UIView *line = [[UIView alloc] init];
        line.backgroundColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
        [self.Baseview addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_offset(0);
            make.bottom.mas_offset(-50);
            make.height.mas_offset(0.8);
        }];
        
        
        /*按钮*/
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:@"暂时退出" forState:UIControlStateNormal];
        [button setTitleColor:UIColorFromRGB(0x3D8AFF) forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [button addTarget:self action:@selector(BtnAction) forControlEvents:UIControlEventTouchUpInside];
        [self.Baseview addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_offset(0);
            make.height.mas_offset(50);
        }];
        
    }
    return self;
}
-(void)BtnAction{
    [self removeFromSuperview];
}
#pragma mark - 懒加载
-(UIView *)Baseview{
    if (!_Baseview) {
        _Baseview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW-50, 450)];
        _Baseview.backgroundColor = [UIColor whiteColor];
        _Baseview.layer.cornerRadius = 6;
    }
    return _Baseview;
}
@end
