//
//  BingpromptView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BingpromptView : UIView
@property (weak, nonatomic) IBOutlet UIButton *QueButton;

@property (nonatomic, copy) void(^QueBlock)(void);

@end
