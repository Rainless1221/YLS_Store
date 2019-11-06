//
//  FBHDWViewController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/21.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHDWViewController : BaseViewController
@property (copy, nonatomic) NSString *store_address;
@property (weak, nonatomic) IBOutlet UIView *backgrounView;
@property (weak, nonatomic) IBOutlet UILabel *DPlabel;//店铺地址
@property (weak, nonatomic) IBOutlet UILabel *MPlabel;//门牌号
@property (weak, nonatomic) IBOutlet UIButton *XButton;//选择地点
@property (weak, nonatomic) IBOutlet UITextField *DZField;//输入的地址

@end
