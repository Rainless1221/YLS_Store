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
@property (strong,nonatomic)NSDictionary * Data;
@end

NS_ASSUME_NONNULL_END
