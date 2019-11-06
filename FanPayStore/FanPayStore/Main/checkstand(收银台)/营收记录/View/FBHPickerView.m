//
//  FBHPickerView.m
//  app
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHPickerView.h"
#import <Masonry.h>

// 屏幕高度
#define SCREENHEIGHT            CGRectGetHeight([UIScreen mainScreen].bounds)
// 屏幕宽度
#define SCREENWIDTH             CGRectGetWidth([UIScreen mainScreen].bounds)

@interface FBHPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (strong,nonatomic)UIView * picView;
/*选择器*/
@property (strong,nonatomic)UIPickerView *yearPicker;/**<年>*/
@property (strong,nonatomic)UIPickerView *monthPicker;/**<月份>*/
@property (strong,nonatomic)UIPickerView *dayPicker;/**<天>*/

/**
 * 数组装年份
 */
@property (nonatomic, strong) NSMutableArray *yearArray;

@end

@implementation FBHPickerView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setViews];
        
        NSDate *date = [NSDate date];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        [dateFormatter setDateFormat:@"yyyy"];
        NSInteger currentYear = [[dateFormatter stringFromDate:date] integerValue];
        for (NSInteger i = 0; i < 100; i++) {
            [self.yearArray addObject:[NSString stringWithFormat:@"%ld",currentYear - i]];
        }
    }
    return self;
}
#pragma mark - 确定按钮点击方法
- (void)sureAction{
    NSInteger yearRow = [self.yearPicker selectedRowInComponent:0]  % self.yearArray.count;
    NSInteger monthRow = [self.monthPicker selectedRowInComponent:0] % 12;
    /*年*/
    NSString *yearStr = self.yearArray[yearRow];
    /*月*/
    NSString *monthStr = [NSString stringWithFormat:@"%.2ld",monthRow+1];
    
//    NSLog(@"年%@ 月： %@",yearStr,monthStr);
    [self.delegate DatePickerView:yearStr withMonth:monthStr withDay:nil withDate:[NSString stringWithFormat:@"%@年%@月",yearStr,monthStr] withTag:1001];
    [self removeFromSuperview];
}
#pragma mark - 取消按钮点击方法
- (void)cancelAction{
    [self removeFromSuperview];

}

- (void)setViews{
    self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.5];
    self.picView = [[UIView alloc]initWithFrame:CGRectMake(15, 172, self.frame.size.width-30, 325)];
    self.picView.backgroundColor = [UIColor whiteColor];
    self.picView.layer.cornerRadius = 6;
    [self addSubview:self.picView];
    
     CGFloat widrh =  self.picView.frame.size.width*0.25;
    //年
    self.yearPicker = [[UIPickerView alloc]init];
    self.yearPicker.delegate = self;
    self.yearPicker.dataSource = self;
    [self.picView addSubview:self.yearPicker];
    [self.yearPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(57);
        make.left.offset(widrh);
        make.width.offset(84);
        make.height.offset(144);
    }];
    
    //月
    self.monthPicker = [[UIPickerView alloc]init];
    self.monthPicker.delegate = self;
    self.yearPicker.dataSource = self;
    [self.picView addSubview:self.monthPicker];
    [self.monthPicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(57);
        make.left.equalTo(self.yearPicker.mas_right).offset(30);
        make.width.offset(57);
        make.height.offset(144);
    }];
    
  
    
    //取消
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.picView addSubview:cancelButton];
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(0);
        make.width.offset(66);
        make.height.offset(39);
    }];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(70, 0, 120, 50)];
    [self.picView addSubview:label];
    label.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    label.text = @"选择时间";
    label.font = [UIFont systemFontOfSize:15];
    label.textAlignment =1;
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.offset(0);
        make.left.offset(70);
        make.right.offset(-70);
        make.height.offset(50);
    }];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.picView.frame.size.width, 1)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.picView addSubview:line];
    
    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeSystem];
    sureButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
    sureButton.layer.shadowOffset = CGSizeMake(0,4);
    sureButton.layer.shadowOpacity = 1;
    sureButton.layer.shadowRadius = 9;
    
    CAGradientLayer *gl = [CAGradientLayer layer];
    gl.frame = CGRectMake(0,0,self.picView.frame.size.width-60,44);
    gl.startPoint = CGPointMake(0, 0);
    gl.endPoint = CGPointMake(1, 1);
    gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
    gl.locations = @[@(0.0),@(0.5),@(1.0)];
    gl.cornerRadius = 10;
    [sureButton.layer addSublayer:gl];

    

    [sureButton setTitle:@"确定" forState:UIControlStateNormal];
    [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sureButton addTarget:self action:@selector(sureAction) forControlEvents:UIControlEventTouchUpInside];
    sureButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [self.picView addSubview:sureButton];
    [sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.offset(-26);
        make.right.offset(-30);
        make.left.offset(30);
        make.height.offset(44);
    }];
    
    
}
#pragma mark - pickerView的delegate方法
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (pickerView == self.yearPicker) {
        [self.monthPicker reloadAllComponents];
//        [self.dayPicker reloadAllComponents];
    }else if (pickerView == self.monthPicker){
//        [self.dayPicker reloadAllComponents];
    }else{
    }
}
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (pickerView == self.yearPicker) {
        
        return 15;
        
    }else if (pickerView == self.monthPicker){
        return 12;
    }else{
        return 1;
    }
    return 0;
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *rowLabel = [[UILabel alloc]init];
    rowLabel.textAlignment = NSTextAlignmentCenter;
//    rowLabel.backgroundColor = [UIColor whiteColor];
    rowLabel.frame = CGRectMake(0, 0, 39,self.picView.frame.size.width);
    rowLabel.textAlignment = NSTextAlignmentCenter;
    rowLabel.font = [UIFont systemFontOfSize:25];
    rowLabel.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    
    if (pickerView == self.yearPicker) {
        
        [pickerView.subviews[1] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 48, 84, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 96, 84, 2)];
        [rowLabel sizeToFit];
        
        rowLabel.text = self.yearArray[row];
        
    }else if (pickerView == self.monthPicker){
        [pickerView.subviews[1] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[2] setBackgroundColor:[UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0]];
        [pickerView.subviews[1] setFrame:CGRectMake(0 , 48, 57, 2)];
        [pickerView.subviews[2] setFrame:CGRectMake(0, 96, 57, 2)];
        [rowLabel sizeToFit];
        
        rowLabel.text = [NSString stringWithFormat:@"%.2ld",row % 12 + 1];
    }else{
        
        
    }
    
    

    return rowLabel;
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    
    return 48;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    
    return 64 ;
    
}
#pragma mark - 懒加载
-(NSMutableArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSMutableArray array];
    }
    return _yearArray;
}
@end
