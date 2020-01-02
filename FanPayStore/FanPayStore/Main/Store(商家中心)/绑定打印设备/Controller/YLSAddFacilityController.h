//
//  YLSAddFacilityController.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface YLSAddFacilityController : BaseViewController
@property (strong,nonatomic)UITextField * NameTF;
@property (strong,nonatomic)UITextField * FacilityTF;
@property (strong,nonatomic)UITextField * TheKeyTF;
@property (strong,nonatomic)NSString * PrinType;
@property (strong,nonatomic)UIButton * TypeButton1;
@property (strong,nonatomic)UIButton * TypeButton2;
@property (strong,nonatomic)NSString * LianType;
@property (strong,nonatomic)UIButton * LianButton1;
@property (strong,nonatomic)UIButton * LianButton2;
@property (strong,nonatomic)UIButton * LianButton3;
@property (strong,nonatomic)UIView * AddVoiceView;
@property (strong,nonatomic)UIView * view_Voice;
@property (strong,nonatomic)NSString * setsound;
@property (strong,nonatomic)UIImageView * setsoundImage;
@property (strong,nonatomic)StarSliderView * star;
@property (assign,nonatomic)BOOL IsMute;
@property (assign,nonatomic)float  PT;
/*编辑还是添加*/
@property (assign,nonatomic)BOOL IsSwitch;
@property (strong,nonatomic)NSString * printer_id;

@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
