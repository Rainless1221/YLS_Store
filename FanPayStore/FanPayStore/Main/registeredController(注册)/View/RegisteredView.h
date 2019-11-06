//
//  RegisteredView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/5/30.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol RegisteredViewDelegate <NSObject>

-(void)RegisDelegateAction:(NSDictionary *)UserDict;/*注册*/
-(void)MSMDelegateAction:(NSString *)Phone MSMButton:(UIButton *)sender;/*验证*/
-(void)LoginDelegateAction;/*去登陆*/
-(void)XieDelegateAction;/*协议*/

@end

@interface RegisteredView : UIView<UITextFieldDelegate>
/* 欢迎 */
@property (strong,nonatomic)UILabel * RegisLabel;
/* 下划线 */
@property (strong,nonatomic)UIView * line_phone;
@property (strong,nonatomic)UIView * line_msm;
@property (strong,nonatomic)UIView * line_pawss;
/* 输入框 */
@property (strong,nonatomic)UITextField * Field_phone;
@property (strong,nonatomic)UITextField * Field_msm;
@property (strong,nonatomic)UITextField * Field_pawss;
/* 注册按钮 */
@property (strong,nonatomic)UIButton * Button_Regis;
/* 验证按钮 */
@property (strong,nonatomic)UIButton * Button_MSM;
/* 去登录 */
@property (strong,nonatomic)UIButton * Button_Login;
/* icon */
@property (strong,nonatomic)UIImageView * Phoneicon;
/* 密码是否可见 */
@property (strong,nonatomic)UIButton * Pawss_Look;
/* 协议 */
@property(nonatomic,assign)id<RegisteredViewDelegate>delegate;

//
@end
