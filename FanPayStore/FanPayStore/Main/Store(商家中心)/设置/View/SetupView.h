//
//  SetupView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^accountBlock)(void);
typedef void(^RunBlock)(void);
typedef void(^GuanyuBlock)(void);

@interface SetupView : UIView
@property (nonatomic, copy) accountBlock accountblock;
@property (nonatomic, copy) RunBlock Runblock;
@property (nonatomic, copy) GuanyuBlock Guanyublock;

@property (nonatomic, copy) void(^HelpBlock)(UIButton *btn);
@property (nonatomic, copy) void(^PBlock)(UIButton *btn);
@property (nonatomic, copy) void(^shakeText)(UISwitch *btn);
@property (nonatomic, copy) void(^soundText)(UISwitch *btn);

@property (weak, nonatomic) IBOutlet UISwitch *Sound;
@property (weak, nonatomic) IBOutlet UISwitch *Shake;
//缓存大小
@property (weak, nonatomic) IBOutlet UIButton *cacheButton;


@end
