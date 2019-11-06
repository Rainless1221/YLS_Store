//
//  FdetailsHead.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/5.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FdetailsHead.h"

@implementation FdetailsHead
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    
}

- (void)setData:(NSDictionary *)Data{
    _Data = Data;
    self.discount_amount.text = [NSString stringWithFormat:@"%@",Data[@"discount_amount"]];
    
    
    NSString *time = [NSString stringWithFormat:@"%@",Data[@"new_begin_datetime"]];
    NSString *time1 = [NSString stringWithFormat:@"%@",Data[@"new_end_datetime"]];
    NSString *datetime = [time substringToIndex:10];
    NSString *end_datetime = [time1 substringToIndex:10];
    
    self.datetime.text = [NSString stringWithFormat:@"%@ - %@",datetime,end_datetime];


}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = MainbackgroundColor;
    self.XButton.layer.borderColor = [UIColorFromRGB(0xFFFFFF) CGColor];
}
#pragma mark - 去修改

- (IBAction)ModifyAction:(UIButton *)sender {
    if (self.ModifyBlock) {
        self.ModifyBlock(sender);
    }
}

@end
