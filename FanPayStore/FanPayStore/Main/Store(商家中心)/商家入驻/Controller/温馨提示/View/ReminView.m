//
//  ReminView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ReminView.h"

@implementation ReminView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self  = [super initWithFrame:frame]) {
        [self createUI];
        /** 视图点击 */
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesturRecognizer];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height-10)];
    baseView.layer.borderWidth = 1;
    baseView.layer.borderColor =UIColorFromRGB(0xEAEAEA).CGColor;
    baseView.layer.cornerRadius = 5;
    [self addSubview:baseView];
    
    /* icon */
    
    self.icon = [UIButton buttonWithType:UIButtonTypeCustom];
    self.icon.frame = CGRectMake(10, 10, 22, 22);
    [self.icon setImage:[UIImage imageNamed:@"icn_order_complete"] forState:UIControlStateSelected];
    [self.icon setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
    [self.icon addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.icon];
    
    /* reminlable */
    self.reminlable = [[UILabel alloc]initWithFrame:CGRectMake(self.icon.right+10, 0, self.width-38, self.height-10)];
    self.reminlable.numberOfLines = 0;
    self.reminlable.text = @"";
    self.reminlable.font = [UIFont systemFontOfSize:autoScaleW(15)];
    [self addSubview:self.reminlable];
    
    
    
}
- (void)setData:(NSArray *)Data{
    
    for (int i =0; i<Data.count; i++) {
        
        NSString *lableString = [NSString stringWithFormat:@"%@",Data[i][@"info_content"]];
        CGRect rect = [lableString boundingRectWithSize:CGSizeMake(self.width-20, 30) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]} context:nil];
        //                CGFloat BtnW = rect.size.width + 10;
        CGFloat BtnH = rect.size.height +15;
        
        UIView *baseView = [[UIView alloc]initWithFrame:CGRectMake(0, i*(BtnH+10), self.width, BtnH)];
        baseView.layer.borderWidth = 1;
        baseView.layer.borderColor =UIColorFromRGB(0xEAEAEA).CGColor;
        baseView.layer.cornerRadius = 5;
        [self addSubview:baseView];
        
        /* icon */
//        self.icon = [[UIImageView alloc]initWithFrame:CGRectMake(10,  10, 16, 16)];
//        self.icon.image = [UIImage imageNamed:@"btn_check_box_normal"];
//        [baseView addSubview:self.icon];
        
        /* reminlable */
        self.reminlable = [[UILabel alloc]initWithFrame:CGRectMake(self.icon.right+10, 0, self.width-36, baseView.height)];
        self.reminlable.numberOfLines = 0;
        self.reminlable.text = lableString;
        [baseView addSubview:self.reminlable];
        
        
        UIButton *thirdBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        thirdBtn.frame = CGRectMake(0, i*(BtnH+10), baseView.width, baseView.height);

        [self addSubview:thirdBtn];
        [thirdBtn addTarget:self action:@selector(MerchantButton:) forControlEvents:UIControlEventTouchUpInside];
        thirdBtn.tag = i+1;
    }
    
}
-(void)MerchantButton:(UIButton *)sender{
    
    sender.selected = !sender.selected;
    if (self.delagate && [self.delagate respondsToSelector:@selector(Remin: and:)]) {
        [self.delagate Remin:self and:sender];
    }

}
-(void)tapAction:(id)tap{
    
    self.icon.selected = !self.icon.selected;
    
    if (self.delagate && [self.delagate respondsToSelector:@selector(Remin: and:)]) {
        [self.delagate Remin:self and:self.icon];
    }
 
}


@end
