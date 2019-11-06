//
//  DXXView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/12.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DXXView : UIView  <UITextViewDelegate>

/** 填写店铺信息*/
@property (weak, nonatomic) IBOutlet UITextField *store_address;//店铺地址
@property (weak, nonatomic) IBOutlet UITextField *specific_location;//门牌号
/** 联系人信息*/
@property (weak, nonatomic) IBOutlet UITextField *merchant_name;
@property (weak, nonatomic) IBOutlet UITextField *merchant_mobile;
@property (weak, nonatomic) IBOutlet UITextField *merchant_telephone;
//@property (strong,nonatomic)UITextView * reminder;

/**
 * 温馨提示
 */
@property (weak, nonatomic) IBOutlet UIView *reminderView;
@property (strong,nonatomic)UIView * TEXTView;
@property (strong, nonatomic) UITextView *reminder;//温馨提示内容
@property (strong, nonatomic) UILabel *placeholderLabel;

@property (weak, nonatomic) IBOutlet UIView *iamgeArrView;//图片集合视图
@property (weak, nonatomic) IBOutlet UIButton *Face_picZButton;
@property (weak, nonatomic) IBOutlet UIButton *Face_picFButton;

@property (weak, nonatomic) IBOutlet UILabel *Huanjilabel;
/** 示例图 */
@property (weak, nonatomic) IBOutlet UIButton *SLbutton;
@property (weak, nonatomic) IBOutlet UIButton *SLbutton1;

/* 经营时间and周期 */
@property (weak, nonatomic) IBOutlet UILabel *business_times;
@property (weak, nonatomic) IBOutlet UILabel *business_hours;

@property (nonatomic, copy) void(^qhxSelectBlock)(BOOL choice,UIButton * btn);
@property (nonatomic, copy) void(^AddBlock)(void);
@property (nonatomic, copy) void(^ImageArrBlock)(BOOL choice,UIButton * btn);
@property (nonatomic, copy) void(^periodBlock)(BOOL choice,UIButton * btn);
@property (nonatomic, copy) void(^TimesBlock)(BOOL choice,UIButton * btn);


@end
