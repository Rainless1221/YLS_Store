//
//  StoreRemin.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/8.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "StoreRemin.h"

@implementation StoreRemin

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
    Textlable.text = @"温馨提示";
    [self addSubview:Textlable];
    
    /*line*/
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, Textlable.bottom, self.width-20, 0.5)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self addSubview:line];
    

    
    
    
    
    /*输入框*/
    
}
#pragma mark - 赋值
-(void)setData:(NSMutableArray *)Data{

    for (int i = 0;i<Data.count ; i++) {
        
        NSString *lableString = [NSString stringWithFormat:@"%@",Data[i][@"info_content"]];
        
        
        ReminView *ReminV = [[ReminView alloc]initWithFrame:CGRectMake(10, i*50+50, self.width-20, 50)];
        ReminV.delagate = self;
        ReminV.reminlable.text = lableString;
        [self addSubview:ReminV];
        ReminV.tag = i;
        
        CGRect Reminrect = [ReminV.reminlable textRectForBounds:ReminV.reminlable.frame limitedToNumberOfLines:0];
        
        CGRect frame = ReminV.frame;
        frame.size.height = Reminrect.size.height+15;
    //                frame = CGRectMake(10, i*(Reminrect.size.height+10)+50, self.scrollView.reminderView.width-20, Reminrect.size.height+10);
        [UIView animateWithDuration:0.25 animations:^{
            ReminV.frame = frame;
        }];
    }
    
    [self.Data1 removeAllObjects];
    for (NSString *str in Data) {
        [self.Data1 addObject:str];
    }
    
}
-(void)Remin:(UIView *)ReminV and:(UIButton* )icon{
    
    if (icon.isSelected) {
        [self.reminderArray addObject:self.Data1[ReminV.tag][@"info_id"]];
    } else {
        [self.reminderArray removeObject:self.Data1[ReminV.tag][@"info_id"]];
    }
    
    NSLog(@"%@",self.reminderArray);
    
    
}
#pragma mark - 懒加载
-(NSMutableArray *)reminderArray{
    if (!_reminderArray) {
        _reminderArray= [NSMutableArray array];
    }
    return _reminderArray;
}
-(NSMutableArray *)Data1{
    if (!_Data1) {
        _Data1= [NSMutableArray array];
    }
    return _Data1;
}
@end
