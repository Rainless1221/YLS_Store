//
//  FBHTabBar.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/12.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHTabBar.h"

@implementation FBHTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

#pragma mark自定义按钮点击事件处理器
- (void)plusClick
{
    // 通知代理
    if ([self.tabBarDelegate respondsToSelector:@selector(tabBarDidClickPlusButton:)]) {
        [self.tabBarDelegate tabBarDidClickPlusButton:self];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.设置加号按钮的位置
    //    CGPoint temp = self.plusBtn.center;
    //    temp.x = self.frame.size.width/2;
    //    temp.y = self.frame.size.height/2;
    //    self.plusBtn.center = temp;
    
    // 2.设置其它UITabBarButton的位置和尺寸
    //    CGFloat tabbarButtonW = self.frame.size.width / 3;
    CGFloat tabbarButtonW = self.frame.size.width / 3;
    CGFloat tabbarButtonH = 50;
    CGFloat tabbarButtonIndex = 0;
    for (UIView *child in self.subviews) {
        Class class = NSClassFromString(@"UITabBarButton");
        if ([child isKindOfClass:class]) {
            // 设置宽度
            CGRect temp1 = child.frame;
            temp1.size.width = tabbarButtonW;
            temp1.size.height = tabbarButtonH;
            temp1.origin.x = tabbarButtonIndex * tabbarButtonW;
            temp1.origin.y =  0;
            child.frame = temp1;
            // 增加索引
            tabbarButtonIndex++;
            //            if (tabbarButtonIndex == 2) {
            //                tabbarButtonIndex++;
            //            }
        }
    }
}
@end
