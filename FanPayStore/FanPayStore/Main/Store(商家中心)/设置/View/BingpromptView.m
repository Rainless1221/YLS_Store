//
//  BingpromptView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BingpromptView.h"

@implementation BingpromptView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    self.QueButton.layer.borderColor = UIColorFromRGB(0xEAEAEA).CGColor;
    
}

#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    
}
- (IBAction)quxiaoAction:(UIButton *)sender {
    [self removeFromSuperview];
}
- (IBAction)noAction:(UIButton *)sender {
     [self removeFromSuperview];
    if (self.QueBlock) {
        self.QueBlock();
    }
}
- (IBAction)yesAction:(UIButton *)sender {
     [self removeFromSuperview];
}


@end
