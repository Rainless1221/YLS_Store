//
//  Distribution.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Distribution.h"

@implementation Distribution

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(10,20,150,14.5);
    label_1.numberOfLines = 0;
    label_1.font = [UIFont systemFontOfSize:15];
    label_1.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label_1.text = @"分布预览";
    [self addSubview:label_1];
    
    
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(0,198,self.width,12);
    label_2.numberOfLines = 0;
    label_2.font = [UIFont systemFontOfSize:15];
    label_2.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1.0];
    label_2.textAlignment = 1;
    label_2.text = @"总营收";
    [self addSubview:label_2];
    
    [self addSubview:self.Distri];
    self.Distri.text = @"164652.00";
    
    NSArray *colorArr = @[@"3D8AFF",@"F7AE2A",@"38A94D",@"EC4F3C",@"8E7DFF",@"FF4891"];
    NSArray *Arr = @[@"订单营收",@"跨界收益",@"推荐收益",@"优惠让利",@"用户退款",@"提现金额"];
    
    for (int i =0; i<Arr.count; i++) {
    
        int x = i%2;
        int y = i/2;
        
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(x*autoScaleW(175)+31,y*25+282,60,11.5);
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:12];
        label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0];
        label.text = [NSString stringWithFormat:@"%@",Arr[i]];
        [self addSubview:label];
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(x*autoScaleW(175)+11,y*25+285,6,6);
        NSString *colorStr = [NSString stringWithFormat:@"%@",colorArr[i]];
        view.backgroundColor = [UIColor colorWithHexString:colorStr];
        view.layer.cornerRadius = 3;
        [self addSubview:view];

        
    }
    
}

#pragma mark - 懒加载
-(UILabel *)Distri{
    if (!_Distri) {
        _Distri = [[UILabel alloc]initWithFrame:CGRectMake(0, 225, self.width, 24)];
        _Distri.textColor = UIColorFromRGB(0x222222);
        _Distri.font = [UIFont systemFontOfSize:24];
        _Distri.numberOfLines = 0;
        _Distri.textAlignment = 1;
        
    }
    return _Distri;
}
@end
