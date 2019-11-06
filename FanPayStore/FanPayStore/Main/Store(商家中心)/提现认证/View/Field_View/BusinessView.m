//
//  BusinessView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BusinessView.h"

@implementation BusinessView

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
    
    UILabel *faren1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 50)];
    faren1.textColor = UIColorFromRGB(0x222222);
    faren1.font = [UIFont systemFontOfSize:15];
    faren1.text = @"执照号";
    [self.WeiView_6 addSubview:faren1];
    UILabel *faren2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 50)];
    faren2.textColor = UIColorFromRGB(0x222222);
    faren2.font = [UIFont systemFontOfSize:15];
    faren2.text = @"到期日期";
    [self.WeiView_6 addSubview:faren2];
    
    [self addSubview:self.WeiView_7];
    UILabel *xieyi = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.WeiView_7.width-20, 50)];
    xieyi.textColor = UIColorFromRGB(0x222222);
    xieyi.font = [UIFont systemFontOfSize:15];
    xieyi.text = @"请上传营业执照照片";
    [self.WeiView_7 addSubview:xieyi];
    
    
    [self.WeiView_6 addSubview:self.bus_license];
    [self.WeiView_6 addSubview:self.bus_license_expire];
    [self.WeiView_7 addSubview:self.business_license_pic];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(10,50,self.WeiView_6.width-20,0.5);
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_6 addSubview:view];
}
- (void)Action:(UIButton *)sender{
    
    if (self.ImagePicBlock) {
        self.ImagePicBlock(sender);
    }
}
#pragma mark -赋值
- (void)setData:(ysepayModel *)Data{
    
    /*营业号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bus_license]] isEqualToString:@""]) {
        
    }else{
        self.bus_license.text = [NSString stringWithFormat:@"%@",Data.bus_license];

    }
    
    /*营业日期*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.bus_license_expire]] isEqualToString:@""]) {
        
    }else{
        self.bus_license_expire.text = [NSString stringWithFormat:@"%@",Data.bus_license_expire];

    }
    
    
    
    NSString *url = [NSString stringWithFormat:@"%@",Data.business_license_pic];
    if ([[MethodCommon judgeStringIsNull:url] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url]) {
            
        }else{
            url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url];
        }
        [self.business_license_pic setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
    
}
#pragma mark - 懒加载
-(UILabel *)Thetitle_4{
    if (!_Thetitle_4) {
        _Thetitle_4 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
        _Thetitle_4.font = [UIFont systemFontOfSize:15];
        _Thetitle_4.textColor = UIColorFromRGB(0x222222);
        _Thetitle_4.text= @"营业执照";
    }
    return _Thetitle_4;
}
-(UIView *)WeiView_6{
    if (!_WeiView_6) {
        _WeiView_6 = [[UIView alloc]initWithFrame:CGRectMake(15, self.Thetitle_4.bottom, ScreenW-30, 101)];
        _WeiView_6.layer.cornerRadius = 5;
        _WeiView_6.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_6;
}
-(UIView *)WeiView_7{
    if (!_WeiView_7) {
        _WeiView_7 = [[UIView alloc]initWithFrame:CGRectMake(15, self.WeiView_6.bottom+15, ScreenW-30, 148)];
        _WeiView_7.layer.cornerRadius = 5;
        _WeiView_7.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_7;
}
-(UITextField *)bus_license{
    if (!_bus_license) {
        _bus_license = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, ScreenW-130, 50)];
        _bus_license.font = [UIFont systemFontOfSize:14];
        _bus_license.textColor = UIColorFromRGB(0x222222);
        _bus_license.placeholder=@"请输入营业执照号";
        _bus_license.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _bus_license;
}

-(UITextField *)bus_license_expire{
    if (!_bus_license_expire) {
        _bus_license_expire = [[UITextField alloc]initWithFrame:CGRectMake(100, self.bus_license.bottom, ScreenW-130, 50)];
        _bus_license_expire.font = [UIFont systemFontOfSize:14];
        _bus_license_expire.textColor = UIColorFromRGB(0x222222);
        _bus_license_expire.placeholder=@"请输入营业执照到期日期(20190101)";
        _bus_license_expire.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _bus_license_expire;
}
-(UIButton *)business_license_pic{
    if (!_business_license_pic) {
        _business_license_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _business_license_pic.frame = CGRectMake(10, 54, 74, 74);
        [_business_license_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_business_license_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _business_license_pic.tag  =6;
    }
    return _business_license_pic;
}
@end
