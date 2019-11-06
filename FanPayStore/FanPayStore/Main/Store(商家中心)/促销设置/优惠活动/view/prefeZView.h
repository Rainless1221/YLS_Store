//
//  prefeZView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/31.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface prefeZView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
/*选择器*/
@property (strong,nonatomic)UIPickerView *yearPicker;
@property (strong,nonatomic)UIPickerView *monthPicker;

@end

NS_ASSUME_NONNULL_END
