//
//  JoinInViewT.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "JoinInViewT.h"

@implementation JoinInViewT

- (IBAction)typeAction:(id)sender {
    if (self.joinblock) {
        self.joinblock();
    }
}
//确定提交
- (IBAction)QDAction:(UIButton *)sender {
    WithdrawWinView *tipView = [[NSBundle mainBundle] loadNibNamed:@"WithdrawWinView" owner:self options:nil].lastObject;
    tipView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    tipView.Winlabel.text = @"提交成功";
    tipView.wintext.text = @"信息提交成功，我们会在2个工作日回复您。请您保持联系方式畅通。";
    [self.window addSubview:tipView];
}



@end
