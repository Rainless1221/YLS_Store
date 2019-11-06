//
//  DDLSView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/1.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DDLSView : UIView
@property (weak, nonatomic) IBOutlet UILabel *TextLbel;
@property (weak, nonatomic) IBOutlet UILabel *Label1;
@property (weak, nonatomic) IBOutlet UILabel *Label2;
@property (weak, nonatomic) IBOutlet UILabel *Label3;
@property (weak, nonatomic) IBOutlet UILabel *Label4;
@property (weak, nonatomic) IBOutlet UILabel *Label5;
@property (weak, nonatomic) IBOutlet UILabel *Label6;

@property (weak, nonatomic) IBOutlet UIButton *Button1;
@property (weak, nonatomic) IBOutlet UIButton *Button2;
@property (weak, nonatomic) IBOutlet UIButton *Button3;
@property (weak, nonatomic) IBOutlet UIButton *Button4;
@property (weak, nonatomic) IBOutlet UIButton *Button5;
@property (weak, nonatomic) IBOutlet UIButton *Button6;

@property (weak, nonatomic) IBOutlet UILabel *adeTime;//开始
@property (weak, nonatomic) IBOutlet UILabel *endTime;//截止

@property (nonatomic, copy) void(^TimeBlock)(UIButton * btn);
@property (nonatomic, copy) void(^KuaiTimeBlock)(UIButton * btn);
@property (nonatomic, copy) void(^DataTimeBlock)(void);

@end
