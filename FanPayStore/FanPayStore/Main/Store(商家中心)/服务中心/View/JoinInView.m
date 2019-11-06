//
//  JoinInView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "JoinInView.h"

@implementation JoinInView

//立即提交
- (IBAction)ButtonAction:(UIButton *)sender {
    if (self.joinblock) {
        self.joinblock();
    }
}

/** 加盟规则 */
- (IBAction)jiamengAction:(UIButton *)sender {
    
    
}

@end
