//
//  PickerPCView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PickerPCView : UIView<UIPickerViewDataSource, UIPickerViewDelegate>
@property (strong,nonatomic)UIView * Baseview;
@property (strong,nonatomic)UIButton * XButton;
@property (strong,nonatomic)UILabel * Navlabel;
@property (strong,nonatomic)UIButton * Button;

@property (nonatomic, strong) UIPickerView *pickerView;
@property (strong,nonatomic)NSArray * Data;
@property (nonatomic, strong) NSMutableArray *pickerDic;
/** 以后扩展功能会用到(记住选中的地址...待完善) */
@property (nonatomic, strong) NSArray *selectedArray;

/** 省份数组 */
@property (nonatomic, strong) NSMutableArray *provinceArray;
/** 城市数组 */
@property (nonatomic, strong) NSArray *cityArray;

/** 省 */
@property (nonatomic,copy) NSString *province;
/** 市 */
@property (nonatomic,copy) NSString *city;
@property (nonatomic, copy) void(^AddressBlcok)(NSString *province,NSString *city);

@end

NS_ASSUME_NONNULL_END
