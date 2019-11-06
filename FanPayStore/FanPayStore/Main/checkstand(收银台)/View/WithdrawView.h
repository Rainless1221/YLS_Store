//
//  WithdrawView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WithdrawView : UIView
@property (weak, nonatomic) IBOutlet UIImageView *DangqiImage;
@property (weak, nonatomic) IBOutlet UILabel *dangqiLabel;
@property (weak, nonatomic) IBOutlet UILabel *dangqiM;
@property (weak, nonatomic) IBOutlet UIView *shuruView;//提现模块
@property (weak, nonatomic) IBOutlet UIImageView *tupiao2;
@property (weak, nonatomic) IBOutlet UILabel *lable1;
@property (weak, nonatomic) IBOutlet UIView *henxi;//横线
@property (weak, nonatomic) IBOutlet UIImageView *tupiao1;
@property (weak, nonatomic) IBOutlet UIButton *allButton;//全部
@property (weak, nonatomic) IBOutlet UIButton *tishi;
@property (weak, nonatomic) IBOutlet UIButton *notarizeButton;
@property (weak, nonatomic) IBOutlet UIButton *cardTextButton;//展示/选择银行卡的按钮
@property (weak, nonatomic) IBOutlet UIButton *tupiao3;
@property (weak, nonatomic) IBOutlet UITextField *JEField;/*提现金额*/
@property (weak, nonatomic) IBOutlet UILabel *fuwu;
@property (weak, nonatomic) IBOutlet UILabel *fuwuLabel;


//提示
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel1;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel2;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel3;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel4;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel5;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel6;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel7;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel8;
@property (weak, nonatomic) IBOutlet UILabel *TisiLabel9;


@property (weak, nonatomic) IBOutlet UIImageView *Tisiimag1;
@property (weak, nonatomic) IBOutlet UIImageView *Tisiimag2;
@property (weak, nonatomic) IBOutlet UIImageView *Tisiimag3;
@property (weak, nonatomic) IBOutlet UIImageView *Tisiimag4;

@property (strong,nonatomic)UIButton * NotButton;
/** 选择银行卡 **/
@property (nonatomic, copy) void(^CardBlock)(void);
/** 全部额度 **/
@property (nonatomic, copy) void(^allBlock)(void);
/** 提现 **/
@property (nonatomic, copy) void(^notarizeBlock)(void);

@end
