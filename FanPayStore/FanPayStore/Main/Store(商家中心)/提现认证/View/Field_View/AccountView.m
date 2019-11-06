//
//  AccountView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/2.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  开户许可证或印签卡信息

#import "AccountView.h"

@implementation AccountView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    [self addSubview:self.Thetitle_4];
    [self addSubview:self.WeiView_6];
    [self.WeiView_6 addSubview:self.opening_permit_pic];
    //客户协议书信息
    UILabel *xieyi = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.WeiView_6.width-20, 50)];
    xieyi.textColor = UIColorFromRGB(0x222222);
    xieyi.font = [UIFont systemFontOfSize:15];
    xieyi.text = @"请上传开户许可证或印鉴卡";
    [self.WeiView_6 addSubview:xieyi];
    
}
- (void)Action:(UIButton *)sender{
    
    if (self.ImagePicBlock) {
        self.ImagePicBlock(sender);
    }
}
#pragma mark -赋值
- (void)setData:(ysepayModel *)Data{
    
    NSString *url = [NSString stringWithFormat:@"%@",Data.opening_permit_pic];
    if ([[MethodCommon judgeStringIsNull:url] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url]) {
            
        }else{
            url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url];
        }
        [self.opening_permit_pic setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
    
}
#pragma mark - 懒加载

-(UILabel *)Thetitle_4{
    if (!_Thetitle_4) {
        _Thetitle_4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
        _Thetitle_4.font = [UIFont systemFontOfSize:15];
        _Thetitle_4.textColor = UIColorFromRGB(0x222222);
        _Thetitle_4.text= @"开户许可证或印鉴卡";
    }
    return _Thetitle_4;
}
-(UIView *)WeiView_6{
    if (!_WeiView_6) {
        _WeiView_6 = [[UIView alloc]initWithFrame:CGRectMake(15, self.Thetitle_4.bottom, ScreenW-30, 148)];
        _WeiView_6.layer.cornerRadius = 5;
        _WeiView_6.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_6;
}
-(UIButton *)opening_permit_pic{
    if (!_opening_permit_pic) {
        _opening_permit_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _opening_permit_pic.frame = CGRectMake(10, 54, 74, 74);
        [_opening_permit_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_opening_permit_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _opening_permit_pic.tag  = 7;
    }
    return _opening_permit_pic;
}
@end
