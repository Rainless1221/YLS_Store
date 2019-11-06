//
//  ThelabelCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ThelabelCell.h"

@implementation ThelabelCell
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.Thelabel.layer.borderWidth = 1;
    self.Thelabel.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
    self.Thelabel.layer.masksToBounds = YES;
    
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect frame_W = [self.Thelabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    
    self.Thelabel.width = frame_W.size.width+20;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    self.Thelabel.text = Data[@"category_name"];
    NSDictionary *fontDict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect frame_W = [self.Thelabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:fontDict context:nil];
    self.Thelabel.width = frame_W.size.width+20;
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
