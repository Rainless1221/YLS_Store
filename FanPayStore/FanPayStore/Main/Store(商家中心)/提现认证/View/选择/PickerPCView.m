//
//  PickerPCView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "PickerPCView.h"

@implementation PickerPCView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        
        
        
//        [self get_province_and_city];
        
        [self createUI];
        
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesturRecognizer];
    self.Baseview = [[UIView alloc] init];
    self.Baseview.frame = CGRectMake(0,367,375,400);
    self.Baseview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.Baseview.layer.cornerRadius = 5;
    [self addSubview:self.Baseview];
    [self.Baseview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(400);
    }];
    
    [self.Baseview addSubview:self.XButton];
    [self.Baseview addSubview:self.Button];
    [self.Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-16);
        make.height.mas_offset(44);
    }];
    
    [self.Baseview addSubview:self.Navlabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 50,self.Baseview.width-20 , 1)];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.Baseview addSubview:line];
    
    
}
-(void)get_province_and_city{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_province_and_city:model.merchant_id andstore_id:model.store_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC = resDic[@"data"][@"province_city_info"];
            [self.pickerDic removeAllObjects];
            //            for (NSDictionary *dict in DIC) {
            //                [self.pickerDic addObject:dict];
            //            }
            
            for (NSDictionary *dict in DIC) {
                [self.pickerDic addObject:dict];
                [self.provinceArray addObject:dict[@"province"]];
            }
            self.selectedArray = self.pickerDic[0][@"sub"];
            self.cityArray = self.selectedArray;
            
        }
        
    } andfailure:^{
        
    }];
}
#pragma mark -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinceArray.count;
    } else if (component == 1) {
        return self.cityArray.count;
    } else {
        return 0;
    }
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        return [self.provinceArray objectAtIndex:row];
    } else if (component == 1) {
        return [self.cityArray objectAtIndex:row][@"city"];
    } else {
        return @"3";
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    return self.frame.size.width/2;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        self.selectedArray = self.pickerDic[row][@"sub"];
        self.province = self.provinceArray[row];
        if (self.selectedArray.count > 0) {
            self.cityArray = self.selectedArray;
        } else {
            self.cityArray = @[];
        }
        if (self.cityArray.count > 0) {
            
        } else {
            //            self.townArray = @[];
        }
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
    }
    if (component == 1) {
        
        self.city = self.cityArray[row][@"city"];
        
    }
    if (component == 2) {
        
    }
    
    
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:15]];
    }
    pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;
}

-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self removeFromSuperview];
    
}
-(void)XAction{
    [self removeFromSuperview];
    
}
-(void)ButtonAction{
    NSInteger selectProvince = [self.pickerView selectedRowInComponent:0];
    NSInteger selectCity     = [self.pickerView selectedRowInComponent:1];
    self.province = self.provinceArray[selectProvince];
    self.city = self.cityArray[selectCity][@"city"];
    if (self.AddressBlcok) {
        self.AddressBlcok(self.province,self.city);
    }
    
    [self removeFromSuperview];

}
- (void)setData:(NSArray *)Data{
    [self.pickerDic removeAllObjects];
    for (NSDictionary *dict in Data) {
        [self.pickerDic addObject:dict];
        [self.provinceArray addObject:dict[@"province"]];
    }
    self.selectedArray = self.pickerDic[0][@"sub"];
    self.cityArray = self.selectedArray;
    
}
#pragma mark - 懒加载

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 51, self.frame.size.width, 280)];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
        _pickerView.backgroundColor = [UIColor whiteColor];
    }
    return _pickerView;
}
-(UIButton *)XButton{
    if (!_XButton) {
        _XButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _XButton.frame = CGRectMake(0, 0, 50, 50);
        [_XButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
        [_XButton addTarget:self action:@selector(XAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _XButton;
}
-(UIButton *)Button{
    if (!_Button) {
        _Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button setTitle:@"确认" forState:UIControlStateNormal];
        [_Button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _Button.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Button.layer.cornerRadius = 10;
        [_Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Button;
}
-(UILabel *)Navlabel{
    if (!_Navlabel) {
        _Navlabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, ScreenW-100, 50)];
        _Navlabel.textAlignment = 1;
        _Navlabel.font = [UIFont systemFontOfSize:15];
    }
    return _Navlabel;
}

-(NSMutableArray *)provinceArray{
    if (!_provinceArray) {
        _provinceArray = [NSMutableArray array];
    }
    return _provinceArray;
}
-(NSMutableArray *)pickerDic{
    if (!_pickerDic) {
        _pickerDic = [NSMutableArray array];
    }
    return _pickerDic;
}
@end
