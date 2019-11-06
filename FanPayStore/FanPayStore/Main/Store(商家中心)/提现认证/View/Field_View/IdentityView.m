//
//  IdentityView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "IdentityView.h"

@implementation IdentityView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    [self addSubview:self.Thetitle_2];
    [self addSubview:self.WeiView_2];
    [self addSubview:self.WeiView_3];
    
    //身份证信息
    UILabel *shenfen1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 50)];
    shenfen1.textColor = UIColorFromRGB(0x222222);
    shenfen1.font = [UIFont systemFontOfSize:15];
    shenfen1.text = @"身份证号";
    [self.WeiView_2 addSubview:shenfen1];
    UILabel *shenfen2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, self.WeiView_3.width-20, 50)];
    shenfen2.textColor = UIColorFromRGB(0x222222);
    shenfen2.font = [UIFont systemFontOfSize:15];
    shenfen2.text = @"请上传法人身份证正面、反面照片，建议横图";
    [self.WeiView_3 addSubview:shenfen2];
    
    [self.WeiView_2 addSubview:self.cert_no];
    
    [self.WeiView_3 addSubview:self.ID_card_front_pic];
    [self.WeiView_3 addSubview:self.ID_card_back_pic];

}
- (void)Action:(UIButton *)sender{
    
    if (self.ImagePicBlock) {
        self.ImagePicBlock(sender);
    }
}
#pragma mark -赋值
- (void)setData:(ysepayModel *)Data{
    /*身份证号*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.cert_no]] isEqualToString:@""]) {
        
    }else{
        _cert_no.text= [NSString stringWithFormat:@"%@",Data.cert_no];

    }
    /*图片*/
    NSString *url = [NSString stringWithFormat:@"%@",Data.ID_card_front_pic];
    if ([[MethodCommon judgeStringIsNull:url] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url]) {
            
        }else{
            url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url];
        }
        [self.ID_card_front_pic setImageWithURL:[NSURL URLWithString:url] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
    

    NSString *url1 = [NSString stringWithFormat:@"%@",Data.ID_card_back_pic];
    if ([[MethodCommon judgeStringIsNull:url1] isEqualToString:@""]) {
    }else{
        if ([PublicMethods isUrl:url1]) {
            
        }else{
            url1 = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url1];
        }
        [self.ID_card_back_pic setImageWithURL:[NSURL URLWithString:url1] forState:UIControlStateNormal placeholder:[UIImage imageNamed:@"btn_add_authentication_data_normal"]];
    }
    

    
}
#pragma mark - 懒加载
-(UILabel *)Thetitle_2{
    if (!_Thetitle_2) {
        _Thetitle_2 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
        _Thetitle_2.font = [UIFont systemFontOfSize:15];
        _Thetitle_2.textColor = UIColorFromRGB(0x222222);
        _Thetitle_2.text = @"身份证信息";
    }
    return _Thetitle_2;
}
-(UIView *)WeiView_2{
    if (!_WeiView_2) {
        _WeiView_2 = [[UIView alloc]initWithFrame:CGRectMake(15, self.Thetitle_2.bottom, ScreenW-30, 50)];
        _WeiView_2.layer.cornerRadius = 5;
        _WeiView_2.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_2;
}
-(UIView *)WeiView_3{
    if (!_WeiView_3) {
        _WeiView_3 = [[UIView alloc]initWithFrame:CGRectMake(15, self.WeiView_2.bottom+15, ScreenW-30, 148)];
        _WeiView_3.layer.cornerRadius = 5;
        _WeiView_3.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_3;
}
-(UITextField *)cert_no{
    if (!_cert_no) {
        _cert_no = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, ScreenW-130, 50)];
        _cert_no.font = [UIFont systemFontOfSize:14];
        _cert_no.textColor = UIColorFromRGB(0x222222);
        _cert_no.placeholder=@"请输入法人身份证号码";
        _cert_no.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _cert_no;
}
-(UIButton *)ID_card_front_pic{
    if (!_ID_card_front_pic) {
        _ID_card_front_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _ID_card_front_pic.frame = CGRectMake(10, 54, 74, 74);
        [_ID_card_front_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_ID_card_front_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _ID_card_front_pic.tag  = 1;

    }
    return _ID_card_front_pic;
}
-(UIButton *)ID_card_back_pic{
    if (!_ID_card_back_pic) {
        _ID_card_back_pic = [UIButton buttonWithType:UIButtonTypeCustom];
        _ID_card_back_pic.frame = CGRectMake(self.ID_card_front_pic.right+10, 54, 74, 74);
        [_ID_card_back_pic setImage:[UIImage imageNamed:@"btn_add_authentication_data_normal"] forState:UIControlStateNormal];
        [_ID_card_back_pic addTarget:self action:@selector(Action:) forControlEvents:UIControlEventTouchUpInside];
        _ID_card_back_pic.tag  = 2;

    }
    return _ID_card_back_pic;
}
@end
