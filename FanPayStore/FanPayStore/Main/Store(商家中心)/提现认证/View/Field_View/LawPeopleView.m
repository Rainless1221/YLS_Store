//
//  LawPeopleView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "LawPeopleView.h"

@implementation LawPeopleView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.Thetitle_1];
    [self addSubview:self.WeiView_1];
    
    //法人信息
    UILabel *faren1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 90, 50)];
    faren1.textColor = UIColorFromRGB(0x222222);
    faren1.font = [UIFont systemFontOfSize:15];
    faren1.text = @"法人名字";
    [self.WeiView_1 addSubview:faren1];
    UILabel *faren2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 50, 90, 50)];
    faren2.textColor = UIColorFromRGB(0x222222);
    faren2.font = [UIFont systemFontOfSize:15];
    faren2.text = @"法人手机";
    [self.WeiView_1 addSubview:faren2];
    
    
    [self.WeiView_1 addSubview:self.legal_name];
    [self.WeiView_1 addSubview:self.legal_tel];
    
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(10,50,self.WeiView_1.width-20,0.5);
    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.WeiView_1 addSubview:view];
}
#pragma mark - 赋值
-(void)setData:(ysepayModel *)Data{
    //
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.legal_name]] isEqualToString:@""]) {
        
    }else{
        _legal_name.text = [NSString stringWithFormat:@"%@",Data.legal_name];

    }
    
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",Data.legal_tel]] isEqualToString:@""]) {
        
    }else{
        _legal_tel.text = [NSString stringWithFormat:@"%@",Data.legal_tel];

    }

}
#pragma mark - 懒加载
-(UILabel *)Thetitle_1{
    if (!_Thetitle_1) {
        _Thetitle_1 = [[UILabel alloc]initWithFrame:CGRectMake(15, 0, 200, 44)];
        _Thetitle_1.font = [UIFont systemFontOfSize:15];
        _Thetitle_1.textColor = UIColorFromRGB(0x222222);
        _Thetitle_1.text = @"法人信息";
    }
    return _Thetitle_1;
}
/*View*/
-(UIView *)WeiView_1{
    if (!_WeiView_1) {
        _WeiView_1 = [[UIView alloc]initWithFrame:CGRectMake(15, self.Thetitle_1.bottom, ScreenW-30, 101)];
        _WeiView_1.layer.cornerRadius = 5;
        _WeiView_1.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    }
    return _WeiView_1;
}
/*输入文本*/
-(UITextField *)legal_name{
    if (!_legal_name) {
        _legal_name = [[UITextField alloc]initWithFrame:CGRectMake(100, 0, ScreenW-130, 50)];
        _legal_name.font = [UIFont systemFontOfSize:14];
        _legal_name.textColor = UIColorFromRGB(0x222222);
        _legal_name.placeholder=@"请输入法人姓名";
        _legal_name.clearButtonMode = UITextFieldViewModeWhileEditing;
        
    }
    return _legal_name;
}

-(UITextField *)legal_tel{
    if (!_legal_tel) {
        _legal_tel = [[UITextField alloc]initWithFrame:CGRectMake(100, self.legal_name.bottom, ScreenW-130, 50)];
        _legal_tel.font = [UIFont systemFontOfSize:14];
        _legal_tel.textColor = UIColorFromRGB(0x222222);
        _legal_tel.placeholder=@"请输入法人手机号码";
        _legal_tel.clearButtonMode=UITextFieldViewModeWhileEditing;
        
    }
    return _legal_tel;
}
@end
