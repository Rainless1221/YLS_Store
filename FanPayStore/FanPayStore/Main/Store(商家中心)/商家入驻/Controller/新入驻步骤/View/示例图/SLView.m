//
//  SLView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "SLView.h"

@implementation SLView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        
        [self createUI];
    }
    return self;
}
#pragma mark -  UI
-(void)createUI{
    
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,2,40,12);
    label.numberOfLines = 0;
    label.textColor = UIColorFromRGB(0x3D8AFF);
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"示例图";
    label.userInteractionEnabled = YES;

    [self addSubview:label];
//    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
//    [label addGestureRecognizer:tapGesturRecognizer];
    
    UIView *view = [[UIView alloc] init];
    view.frame = CGRectMake(0,label.bottom+1,38,0.5);
    view.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [self addSubview:view];
    
    
    UIImageView *Simage = [[UIImageView alloc]initWithFrame:CGRectMake(label.right+5, 0, 15, 15)];
    Simage.image = [UIImage imageNamed:@"icn_message_hint"];
    Simage.userInteractionEnabled = YES;

    [self addSubview:Simage];
    
    
//    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
//    button.backgroundColor = UIColorFromRGBA(0x222222, 0.1);
//    button.frame = CGRectMake(0, 0, 60, 18);
//    [button addTarget:self action:@selector(ButtonAtion) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button];
}
//-(void)tapAction:(UITapGestureRecognizer *)tap{
//    SampleView *samView = [[SampleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    samView.Sampletext.text = @"门脸照-示例图";
//    samView.imagesArr = @[@"店内环境照片-1",@"店内环境照片-2",@"店内环境照片-3"];
//    [[UIApplication sharedApplication].keyWindow addSubview:samView];
//}
//-(void)ButtonAtion{
//    SampleView *samView = [[SampleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    samView.Sampletext.text = @"门脸照-示例图";
//    samView.imagesArr = @[@"店内环境照片-1",@"店内环境照片-2",@"店内环境照片-3"];
//    [[UIApplication sharedApplication].keyWindow addSubview:samView];
//}
@end
