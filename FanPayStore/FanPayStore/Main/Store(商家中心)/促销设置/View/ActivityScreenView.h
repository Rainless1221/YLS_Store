//
//  ActivityScreenView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/29.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivityScreenView : UIView
@property (strong,nonatomic)UIButton * Screenbutton;
@property (strong,nonatomic)UIButton * ActivityButton;
/* 弹出窗口 */
@property (strong,nonatomic)UIView * Activity_Pop;


@property (nonatomic, copy) void(^ActivityBlock)(UIButton * btn,NSString *btnTitle);

- (void)ButtonAction:(UIButton *)sender;
@end
