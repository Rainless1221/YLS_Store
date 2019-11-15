//
//  FSTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/20.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FSTableViewCell.h"

@implementation FSTableViewCell
#pragma mark - 用户
- (void)setData:(NSDictionary *)Data{
/**
 头像
 */
   
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Data[@"head_pic"]]] placeholderImage:photoImage];
/**
 名字
 */
    NSString *name=[NSString stringWithFormat:@"%@",Data[@"user_name"]];
    if ([[MethodCommon judgeStringIsNull:name] isEqualToString:@""]) {
        self.user_name.text  = @"";
    }else{
         self.user_name.text  = name;
    }
/**
 城市
 */
    NSString *city=[NSString stringWithFormat:@"%@",Data[@"city"]];
    if ([[MethodCommon judgeStringIsNull:name] isEqualToString:@""]) {
        self.cityLabel.text  = @"";

    }else{
        self.cityLabel.text  = city;
    }

/**
 性别
 */
    NSString *sex = [NSString stringWithFormat:@"%@",Data[@"sex"]];

    if ([sex  isEqual: @"1"]) {
        self.seximage.image =  [UIImage imageNamed:@"icn_gender_male"];
    }else if ([sex isEqualToString:@"0"]){
         self.seximage.image =  [UIImage imageNamed:@"icn_gender_female"];
    } else{
        self.seximage.image =  [UIImage imageNamed:@""];
    }

    
}

#pragma mark - 商户
-(void)setData1:(NSDictionary *)Data1{
//    _Data1 = Data1;

    /**
     头像
     */
    [self.head_pic sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",Data1[@"head_pic"]]] placeholderImage:photoImage];
    /**
     名字
     */
    NSString *merchant_name=[NSString stringWithFormat:@"%@",Data1[@"merchant_name"]];
    if ([[MethodCommon judgeStringIsNull:merchant_name] isEqualToString:@""]) {
        self.user_name.text  = @"";
    }else{
        self.user_name.text  = merchant_name;
    }
    /**
     城市
     */
    NSString *city=[NSString stringWithFormat:@"%@",Data1[@"city"]];
    if ([[MethodCommon judgeStringIsNull:city] isEqualToString:@""]) {
        self.cityLabel.text  = @"";

    }else{
        self.cityLabel.text  = city;
    }
    
    /**
     性别
     */
    NSString *sex = [NSString stringWithFormat:@"%@",Data1[@"sex"]];
    if ([sex  isEqual: @"1"]) {
        self.seximage.image =  [UIImage imageNamed:@"icn_gender_male"];
    }else if ([sex isEqualToString:@"0"]){
        self.seximage.image =  [UIImage imageNamed:@"icn_gender_female"];
    } else{
        self.seximage.image =  [UIImage imageNamed:@""];
    }
    
}



@end
