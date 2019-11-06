//
//  FBHQRCodeController.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/26.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "BaseViewController.h"

@interface FBHQRCodeController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *FenLabl;//分享至
@property (weak, nonatomic) IBOutlet UIButton *weixiButton;
@property (weak, nonatomic) IBOutlet UIButton *weipoButton;
@property (weak, nonatomic) IBOutlet UIButton *qqButton;
@property (weak, nonatomic) IBOutlet UIButton *pengyouButton;
//二维码
@property (weak, nonatomic) IBOutlet UIView *BaseView;
@property (weak, nonatomic) IBOutlet UIImageView *QRimage;
@property (weak, nonatomic) IBOutlet UILabel *QRlabel;
@property (weak, nonatomic) IBOutlet UIButton *SaveButton;
@property (weak, nonatomic) IBOutlet UIImageView *QRimage1;

@end
