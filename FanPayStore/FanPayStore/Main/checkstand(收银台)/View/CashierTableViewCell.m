//
//  CashierTableViewCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CashierTableViewCell.h"

@implementation CashierTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        

    }
    return self;
}
-(void)setData:(NSDictionary *)Data{
    _Data =Data;
    /** 时间  **/
    NSString *timeString =  [NSString stringWithFormat:@"%@",Data[@"consumption_time"]];
    NSString *Time = [timeString substringToIndex:5];
    
    self.Timelabel.text = Time;
    /** 金额 **/
    self.Mlabel.text = [NSString stringWithFormat:@"+%@",Data[@"consumption_amount"]];
    /** 状态 **/
    NSString *status = [NSString stringWithFormat:@"%@",Data[@"consumption_status"]];
    self.Zhuanglabel.text = status;
    /** 描述 **/
    self.Textlabel.text = [NSString stringWithFormat:@"%@",Data[@"consumption_desc"]];
    
    if ([status isEqualToString:@"已到账"]) {
        self.Zhuanglabel.textColor = UIColorFromRGB(0x3D8AFF);
        self.Mlabel.textColor = UIColorFromRGB(0x3D8AFF);
        self.shuxian.image = [UIImage imageNamed:@"icn_cashier_record_side_bar_blue"];
    }
    
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
//    self.cellView.frame = CGRectMake(10, 0, self.width-20, 36);
//    self.shuxian.frame = CGRectMake(10, 5, 1, 16);
//    self.Timelabel.frame = CGRectMake(self.shuxian.right + 10, 0, 40, 36);
//    self.Textlabel.frame = CGRectMake(self.Timelabel.right, 0, 120, 36);
//    self.Mlabel.frame = CGRectMake(self.Textlabel.right, 0, 50, 36);
//    self.Zhuanglabel.frame = CGRectMake(self.cellView.width - 40, 0, 40, 36);
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
