//
//  publiccardView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/29.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface publiccardView : UIView
/** 银行卡信息  **/
@property (strong,nonatomic)UIView * BaseView1;
@property (strong,nonatomic)UITextField * card;
@property (strong,nonatomic)UILabel * cardtype;
@property (strong,nonatomic)UITextField * cardPhone;
@property (strong,nonatomic)UITextField * carduser;

/** 证件信息 **/
@property (strong,nonatomic)UIView * BaseView2;
@property (strong,nonatomic)UIButton * cardButton;

/** 确定绑定 **/
@property (strong,nonatomic)UIButton * determineButton;

@end
