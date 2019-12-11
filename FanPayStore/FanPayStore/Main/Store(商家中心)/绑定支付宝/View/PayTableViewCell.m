//
//  PayTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PayTableViewCell.h"

@implementation PayTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UIView *BaseView = [[UIView alloc] init];
    BaseView.frame = CGRectMake(15,0,ScreenW-30,90);
    BaseView.backgroundColor = [UIColor colorWithRed:0/255.0 green:160/255.0 blue:233/255.0 alpha:1.0];
    BaseView.layer.cornerRadius = 5;
    [self addSubview:BaseView];
    
    UIImageView *BaseImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BaseView.width, 90)];
    BaseImage.image = [UIImage imageNamed:@"bg_zhifubao_account"];
    BaseImage.layer.cornerRadius = 5;
    BaseImage.layer.masksToBounds = YES;
    [BaseView addSubview:BaseImage];
    
    [BaseView addSubview:self.PayName];
    [BaseView addSubview:self.Account];
    [BaseView addSubview:self.Status];
    [self.PayName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(150));
        make.height.mas_offset(13);
         make.top.mas_offset(24);
        make.width.mas_offset(104);
    }];
    [self.Account mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(IPHONEWIDTH(140));
        make.height.mas_offset(20);
        make.top.mas_offset(45.5);
    }];
    [self.Status mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.height.mas_offset(18);
        make.top.mas_offset(0);
        make.width.mas_offset(72);
    }];
    
    UIImageView *BaseImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BaseView.width, 90)];
    BaseImage1.image = [UIImage imageNamed:@"icn_account_arrow_white"];
    BaseImage1.layer.cornerRadius = 5;
    BaseImage1.layer.masksToBounds = YES;
    [BaseView addSubview:BaseImage1];
    [BaseImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.height.mas_offset(12.5);
        make.width.mas_offset(7.5);
        make.centerY.mas_offset(0);
    }];
    
}
-(void)setData:(NSDictionary *)Data{
    //名字
    NSString *alipay_name  = [NSString stringWithFormat:@"%@",Data[@"alipay_name"]];
    if ([[MethodCommon judgeStringIsNull:alipay_name] isEqualToString:@""]) {
        alipay_name =@"";
    }
    self.PayName.text = alipay_name;
    
    //账号 alipay_account
    NSString *alipay_account = [NSString stringWithFormat:@"%@",Data[@"alipay_account"]];
    if ([[MethodCommon judgeStringIsNull:alipay_account] isEqualToString:@""]) {
        alipay_account =@"";
    }
    self.Account.text = alipay_account;
    CGRect rect = [alipay_account boundingRectWithSize:CGSizeMake(ScreenW - 40, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
    CGFloat BtnW = rect.size.width + 15;
    [self.Account mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_offset(BtnW);
    }];
    
    NSString *status = [NSString stringWithFormat:@"%@",Data[@"status"]];
    if ([[MethodCommon judgeStringIsNull:status] isEqualToString:@""]) {
        status =@"1";
    }
    if ([status isEqualToString:@"2"]) {
        self.Status.selected = YES;
    }else{
        self.Status.selected = NO;
    }
    
}
#pragma mark - 懒加载
-(UILabel *)PayName{
    if (!_PayName) {
        _PayName = [[UILabel alloc]initWithFrame:CGRectMake(0, 24, 120, 13.5)];
        _PayName.font = [UIFont systemFontOfSize:15];
        _PayName.textColor = UIColorFromRGB(0xFFFFFF);
//        _PayName.textAlignment = 1;
    }
    return _PayName;
}
-(UILabel *)Account{
    if (!_Account) {
        _Account = [[UILabel alloc]initWithFrame:CGRectMake(0, 45.5, 120, 20)];
        _Account.font = [UIFont systemFontOfSize:15];
        _Account.textColor = UIColorFromRGB(0xFFFFFF);
        _Account.backgroundColor = UIColorFromRGBA(0xFFFFFF, 0.2);
        _Account.layer.masksToBounds = YES;
        _Account.layer.cornerRadius = 10;
        _Account.textAlignment = 1;
    }
    return _Account;
}
-(UIButton *)Status{
    if (!_Status) {
        _Status = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Status setTitle:@"  审核中" forState:UIControlStateNormal];
        [_Status setTitle:@"  审核通过" forState:UIControlStateSelected];
        [_Status setImage:[UIImage imageNamed:@"icn_account_reviewing_white"] forState:UIControlStateNormal];
        [_Status setImage:[UIImage imageNamed:@"icn_account_review_done_white"] forState:UIControlStateSelected];
        _Status.titleLabel.font = [UIFont systemFontOfSize:12];
        [_Status setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_Status setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        _Status.backgroundColor = UIColorFromRGBA(0xffffff, 0.2);
        _Status.layer.cornerRadius = 2;
    }
    return _Status;
}
@end
