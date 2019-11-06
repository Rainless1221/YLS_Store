//
//  CardWinView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CardWinView.h"

@implementation CardWinView

//我知道了
- (IBAction)WinAction:(id)sender {
    if (self.RemoveBlock) {
        self.RemoveBlock();
    }
    [self removeFromSuperview];
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
