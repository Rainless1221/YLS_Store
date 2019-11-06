//
//  SeekTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SeekTableViewCell.h"

@implementation SeekTableViewCell
- (void)setDict:(AMapPOI *)Dict{
    _Dict = Dict;
    
    NSString *addressString = [NSString new];
    
    NSString *province = [NSString stringWithFormat:@"%@",Dict.province];
    NSString *city = [NSString stringWithFormat:@"%@",Dict.city];
    NSString *district = [NSString stringWithFormat:@"%@",Dict.district];
    NSString *address = [NSString stringWithFormat:@"%@",Dict.address];

    
    /**
     1、地址是否和区重复  虎门
     */
    
    if ([address isEqualToString:district]) {
        if ([district isEqualToString:city]) {
            addressString = [NSString stringWithFormat:@"%@%@%@",addressString,province,city];
        }else{
            addressString = [NSString stringWithFormat:@"%@%@%@%@",addressString,province,city,district];
        }
    }else if ([district isEqualToString:city]){
        addressString = [NSString stringWithFormat:@"%@%@%@",addressString,province,city];
    }else{
        addressString = [NSString stringWithFormat:@"%@%@%@%@%@",addressString,province,city,district,address];
    }

    
    self.addressLabel.text = [NSString stringWithFormat:@"%@",addressString];

//    self.addressLabel.text = [NSString stringWithFormat:@"%@%@%@%@",Dict.province,Dict.city,Dict.district,Dict.address];
    self.nameLabel.text = [NSString stringWithFormat:@"%@",Dict.name];
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
