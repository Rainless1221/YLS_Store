//
//  bondPromptView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "bondPromptView.h"

@implementation bondPromptView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
//    self.promptImage.image = [UIImage imageNamed:@""];

}
- (IBAction)QXAction:(id)sender {
    if (self.bondBlock) {
        self.bondBlock();
    }
    [self removeFromSuperview];
}

@end
