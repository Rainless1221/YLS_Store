//
//  CPFBView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CPFBView : UIView <UITextViewDelegate,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *TianxieView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *jiageLabel;
@property (weak, nonatomic) IBOutlet UILabel *kucunLabel;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *ImageButton;
/*平台价*/
@property (weak, nonatomic) IBOutlet UILabel *Pingtai;

/** 填写信息*/
@property (weak, nonatomic) IBOutlet UITextField *goods_name;
@property (weak, nonatomic) IBOutlet UITextField *goods_price;
@property (weak, nonatomic) IBOutlet UITextField *goods_num;
@property (weak, nonatomic) IBOutlet UITextField *goods_description;
@property (weak, nonatomic) IBOutlet UITextView *goods_description1;
@property (weak, nonatomic) IBOutlet UILabel *placeholderLabel;
@property (weak, nonatomic) IBOutlet UITextField *discount_price;
/*标签*/
@property (weak, nonatomic) IBOutlet UIButton *LabelBtn;
@property (weak, nonatomic) IBOutlet UIView *TheLabelView;

/*立即发布按钮*/
@property (weak, nonatomic) IBOutlet UIButton *FBButton;

@property (weak, nonatomic) IBOutlet UIView *Imageview;

@property (nonatomic, copy) void(^imageBlock)(BOOL choice,UIButton * btn);

@property (nonatomic, copy) void(^insertBlock)(void);
@property (nonatomic, copy) void(^selectBlock)(void);

//赋值
@property(nonatomic,strong)NSDictionary * Data;


@end
