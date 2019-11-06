//
//  EnvironmentView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/9.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "EnvironmentView.h"

@implementation EnvironmentView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
         [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UILabel *Textlable = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
    Textlable.font = [UIFont systemFontOfSize:15];
    Textlable.textColor = UIColorFromRGB(0x222222);
    Textlable.text = @"店铺图片";
    [self addSubview:Textlable];
    
    /*line*/
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, Textlable.bottom, self.width-20, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(10, line.bottom+194, self.width-20, 0.5)];
    line1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line1];
    
    
    
    
    /**/
    UILabel *label_1 = [[UILabel alloc] init];
    label_1.frame = CGRectMake(10,line.bottom+20,200,14);
    label_1.numberOfLines = 0;
    label_1.font = [UIFont systemFontOfSize:15];
    label_1.textColor = UIColorFromRGB(0x222222);
    label_1.text = @"上传门脸照片";
    [self addSubview:label_1];
    
    UILabel *label_2 = [[UILabel alloc] init];
    label_2.frame = CGRectMake(10,label_1.bottom+10,200,12);
    label_2.numberOfLines = 0;
    label_2.font = [UIFont systemFontOfSize:13];
    label_2.textColor = UIColorFromRGB(0xCCCCCC);
    label_2.text = @"必须能看见完整的门匾、门框。";
    [label_2 sizeToFit];
    [self addSubview:label_2];
    
    
    
    
    
    UILabel *label_3 = [[UILabel alloc] init];
    label_3.frame = CGRectMake(10,line1.bottom+20,200,14);
    label_3.numberOfLines = 0;
    label_3.font = [UIFont systemFontOfSize:15];
    label_3.textColor = UIColorFromRGB(0x222222);
    label_3.text = @"上传店内环境照片";
    [self addSubview:label_3];
    
    UILabel *label_4 = [[UILabel alloc] init];
    label_4.frame = CGRectMake(10,label_3.bottom+10,200,12);
    label_4.numberOfLines = 0;
    label_4.font = [UIFont systemFontOfSize:13];
    label_4.textColor = UIColorFromRGB(0xCCCCCC);
    label_4.text = @"需要包含桌椅，收银台等内容。";
    [label_4 sizeToFit];
    [self addSubview:label_4];
    
    
}
#pragma mark - 懒加载

@end
