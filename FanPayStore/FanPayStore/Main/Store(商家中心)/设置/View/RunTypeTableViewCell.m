//
//  RunTypeTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "RunTypeTableViewCell.h"

@implementation RunTypeTableViewCell

- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    
    
    if ([[MethodCommon judgeStringIsNull:Data[@"category_pic"]] isEqualToString:@""]) {
        
        self.iconImage.image = photoImage;
    }else
    {
        NSString *url = [NSString stringWithFormat:@"%@",Data[@"category_pic"]];
        NSString * imageUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:photoImage];

        
       
        
    }
    
    if ([[MethodCommon judgeStringIsNull:Data[@"category_name"]] isEqualToString:@""]) {
        
        self.TextLabel.text = @"";
    }else
    {
        self.TextLabel.text = [NSString stringWithFormat:@"%@",Data[@"category_name"]];
    }
    

}


//选择
- (IBAction)SeleAction:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
}


@end
