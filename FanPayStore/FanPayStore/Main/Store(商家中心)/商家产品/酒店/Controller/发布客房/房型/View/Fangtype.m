//
//  Fangtype.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/16.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Fangtype.h"

@implementation Fangtype

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    
    NSArray *bedArr = @[@"双人大床",@"双人床",@"单人床",@"上下铺",@"上下铺",@"沙发床",@"榻榻米",@"其他"];
    NSArray *bedArr1 = @[@"宽1.8米及以上",@"宽1.3-1.8米",@"宽1.3米以下",@"",@"",@"",@"",@""];
    for (int i=0; i<bedArr.count; i++) {
    
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15,15+i*79,ScreenW-30,64);
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.cornerRadius = 5;
        [self addSubview:view];
        
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(10,15,150,14.5);
        label.numberOfLines = 0;
        label.text= [NSString stringWithFormat:@"%@",bedArr[i]];
        [view addSubview:label];
        
        UILabel *label1 = [[UILabel alloc] init];
        label1.frame = CGRectMake(11,38,150,12);
        label1.numberOfLines = 0;
        label1.font = [UIFont systemFontOfSize:12];
        label1.textColor=  [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0];
        label1.text= [NSString stringWithFormat:@"%@",bedArr1[i]];
        [view addSubview:label1];
        
        self.numberButton = [PPNumberButton numberButtonWithFrame:CGRectMake(view.width - 125, 0, 115, 64)];
        self.numberButton.delegate = self;
        // 初始化时隐藏减按钮
        self.numberButton.decreaseHide = NO;
        self.numberButton.increaseImage = [UIImage imageNamed:@"increase_eleme"];
        self.numberButton.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
        
        self.numberButton.resultBlock = ^(PPNumberButton *ppBtn, CGFloat number, BOOL increaseStatus) {
            NSLog(@"%f",number);
        };
        [view addSubview:self.numberButton];
        
    }
    
    
}
#pragma mark - PPNumberButtonDelegate
- (void)pp_numberButton:(PPNumberButton *)numberButton number:(NSInteger)number increaseStatus:(BOOL)increaseStatus
{
    if (number == 0) {
        numberButton.decreaseImage = [UIImage imageNamed:@"decrease_meituan"];
    }else{
        numberButton.decreaseImage = [UIImage imageNamed:@"btn_delete_shop_info_image_normal"];
    }
    
}
#pragma mark - 懒加载

@end
