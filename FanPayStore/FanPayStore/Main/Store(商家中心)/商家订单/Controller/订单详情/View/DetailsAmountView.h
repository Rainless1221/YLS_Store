//
//  DetailsAmountView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/24.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol AmountDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)AmountConfirm;


@end
NS_ASSUME_NONNULL_BEGIN

@interface DetailsAmountView : UIView<UITextFieldDelegate>
@property (strong,nonatomic)UIView * backView;
@property (strong,nonatomic)UITextField * AmountTF;//金额

@property (strong,nonatomic)UITextField * BeiZhu;//备注
/** 键盘的高度 */
@property (nonatomic,assign) CGFloat keyBoardHeight;
/** 表示在弹出键盘的时候只设置bottomView的高度一次 */
@property (nonatomic,assign) BOOL isFirst;
/*代理*/
@property(nonatomic,weak)id<AmountDelegate>delagate;
@end

NS_ASSUME_NONNULL_END
