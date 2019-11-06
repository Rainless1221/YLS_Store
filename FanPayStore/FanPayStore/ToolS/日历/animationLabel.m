//
//  animationLabel.m
//  封装日历
//
//  Created by yurong on 2017/7/20.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "animationLabel.h"
#import "UIView+Frame.h"
#define IPHONEHIGHT(b) [UIScreen mainScreen].bounds.size.height*((b)/1334.0)
#define IPHONEWIDTH(a) [UIScreen mainScreen].bounds.size.width*((a)/750.0)
@interface animationLabel ()


@end
@implementation animationLabel

- (instancetype)initWithFrame:(CGRect)frame labelStr:(NSString *)labelStr
{
    self = [super initWithFrame:frame];
    if (self) {
        _changeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _changeLabel.text = labelStr;
        _changeStr = labelStr;
        _changeLabel.textAlignment = NSTextAlignmentCenter;
        _changeLabel.textColor = [UIColor colorWithHexString:@"6A6A6A"];
        _changeLabel.font = [UIFont systemFontOfSize:IPHONEWIDTH(28)];
        [self addSubview:_changeLabel];
    }
    return self;
}


-(void)setChangeStr:(NSString *)changeStr{
    [UIView animateWithDuration:0.3f animations:^{
        self.changeLabel.x = self.size.width;
        self.changeLabel.alpha = 0;
    }completion:^(BOOL finished) {
        self.changeLabel.alpha = 1;
        self.changeLabel.x = 0;
        self.changeLabel.text = changeStr;
        self.changeStr = changeStr;
    }];
}
@end
