//
//  FBHSZTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/4.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHSZTableViewCell.h"

@implementation FBHSZTableViewCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
//    self.typeLabel.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
//
//    self.typeLabel.backgroundColor = UIColorFromRGB(0xEBF3FF);
    
}
- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    
//    if ([[MethodCommon judgeStringIsNull:Data[@"discount_amount"]] isEqualToString:@""]) {
//
//        self.discount_amount.text = @"";
//    }else
//    {
        self.discount_amount.text = [NSString stringWithFormat:@"¥%@",Data[@"discount_amount"]];
//    }
    
//状态
//    if ([[MethodCommon judgeStringIsNull:Data[@"desc"]] isEqualToString:@""]) {
//
//        [self.statusLabel setTitle:@"" forState:UIControlStateNormal];
//    }else
//    {
        NSString *desc = [NSString stringWithFormat:@"%@",Data[@"desc"]];
        
        if ([desc isEqualToString:@"进行中"]) {
            [self.statusLabel setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_progress"] forState:UIControlStateNormal];
        }else{
            [self.statusLabel setBackgroundImage:[UIImage imageNamed:@"tag_fanbei_end"] forState:UIControlStateNormal];
        }
        [self.statusLabel setTitle:desc forState:UIControlStateNormal]; 
//    }
//时间
//    if ([[MethodCommon judgeStringIsNull:Data[@"new_begin_datetime"]] isEqualToString:@""]) {
//
//        self.datetime.text = @"";
//    }else
//    {
        /** 处理限时or全天 */
        NSString *time = [NSString stringWithFormat:@"%@",Data[@"new_begin_datetime"]];
        NSString *time1 = [NSString stringWithFormat:@"%@",Data[@"new_end_datetime"]];
        
        NSString *typeTime = [time substringFromIndex:11];
        NSString *typeTime1 = [time1 substringFromIndex:11];

        NSLog(@"begin  %@ end %@",typeTime,typeTime1);
        
        NSString *datetime =[[NSString alloc]init];
        NSString *end_datetime =[[NSString alloc]init];
        
        if ([typeTime isEqualToString:@"00:00"] || [typeTime1 isEqualToString:@"23:59"]) {
            /** 全天时间 */
            datetime = [time substringToIndex:10];
            end_datetime = [time1 substringToIndex:10];
            self.typeLabel .text = @"全天";
            self.typeLabel.textColor = UIColorFromRGB(0x3D8AFF);
            self.typeLabel.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
            
            self.typeLabel.backgroundColor = UIColorFromRGB(0xEBF3FF);
        }else{
            /** 限时时间 */
            datetime = time;
            end_datetime = time1;
            self.typeLabel .text = @"限时";
            self.typeLabel.textColor = UIColorFromRGB(0xD03B34);
            self.typeLabel.layer.borderColor = [UIColorFromRGB(0xD03B34) CGColor];
            
            self.typeLabel.backgroundColor = UIColorFromRGB(0xFFE7E4);
        }
        
        
        
        
        self.datetime.text = [NSString stringWithFormat:@"%@ - %@",datetime,end_datetime];
//    }
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
