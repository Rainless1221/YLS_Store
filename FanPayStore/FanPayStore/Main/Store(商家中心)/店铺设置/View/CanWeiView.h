//
//  CanWeiView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/1.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol CanViewDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Can_card:(NSString*)Canlabel;

@end
@interface CanWeiView : UIView
@property (strong,nonatomic)UIView * Baseview;

//标题
@property (strong,nonatomic)UILabel * CanLabel;
//输入框
@property (strong,nonatomic)UITextField * CanField;
//确定
@property (strong,nonatomic)UIButton * CanButton;
//取消
@property (strong,nonatomic)UIButton * cancel;
@property(nonatomic,weak)id<CanViewDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
