//
//  WithdrawWinView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawWinView : UIView
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (weak, nonatomic) IBOutlet UILabel *Winlabel;
@property (weak, nonatomic) IBOutlet UILabel *wintext;
@property (weak, nonatomic) IBOutlet UIButton *WinButton;

@property (nonatomic, copy) void(^WinActionBlock)(void);

@end
