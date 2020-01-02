//
//  EquipmentCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/21.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "EquipmentCell.h"

@implementation EquipmentCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIView *view = [[UIView alloc] init];
        view.frame = CGRectMake(15,0,ScreenW-30,85);
        view.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
        view.layer.cornerRadius = 0;
        [self addSubview:view];
        
        [view addSubview:self.machine_name];
        [view addSubview:self.machine_code];
        [view addSubview:self.machine_tixt];
        [self.machine_name mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_offset(15);
            make.left.mas_offset(10);
            make.right.mas_offset(-60);
            make.height.mas_offset(14);
        }];
        [self.machine_code mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.machine_name.mas_bottom).offset(9.5);
            make.left.mas_offset(10);
            make.right.mas_offset(-60);
        }];
        [self.machine_tixt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.machine_code.mas_bottom).offset(7.5);
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
        }];
        /*解绑*/
        UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [Button setTitle:@"解绑" forState:UIControlStateNormal];
        [Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        Button.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        Button.layer.borderWidth = 1;
        Button.layer.cornerRadius = 5;
        Button.titleLabel.font = [UIFont systemFontOfSize:15];
        [Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:Button];
        [Button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.centerY.mas_offset(0);
            make.size.mas_offset(CGSizeMake(50, 28));
        }];
    }
    return self;
}
-(void)ButtonAction{
    if (self.unbindingBlock) {
        self.unbindingBlock();
    }
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{
    
    //
    NSString *name = [NSString stringWithFormat:@"%@",Data[@"machine_name"]];
    if ([[MethodCommon judgeStringIsNull:name] isEqualToString:@""]) {
        name = @"";
    }else{
        self.machine_name.text = name;

    }

    //
    NSString *code = [NSString stringWithFormat:@"%@",Data[@"machine_code"]];
    if ([[MethodCommon judgeStringIsNull:code] isEqualToString:@""]) {
        code = @"";
    }else{
        self.machine_code.text = [NSString stringWithFormat:@"终端号：%@",code];
    }

    
    NSString *tixt = [NSString stringWithFormat:@"%@",Data[@"multi"]];
    NSString *tixt1 = [NSString stringWithFormat:@"%@",Data[@"setsound"]];
    if ([[MethodCommon judgeStringIsNull:tixt] isEqualToString:@""]) {
        tixt = @"";
    }
    if ([[MethodCommon judgeStringIsNull:tixt1] isEqualToString:@""]) {
        tixt1 = @"";
    }
        self.machine_tixt.text = [NSString stringWithFormat:@"打印联数：%@       音量：%@",tixt,tixt1];

    
    
}
#pragma mark - 懒加载
-(UILabel *)machine_name{
    if (!_machine_name) {
        _machine_name = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
        _machine_name.textColor = [UIColor blackColor];
        _machine_name.font = [UIFont systemFontOfSize:15];
    }
    return _machine_name;
}
-(UILabel *)machine_code{
    if (!_machine_code) {
        _machine_code = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
        _machine_code.textColor = UIColorFromRGB(0x999999);
        _machine_code.font = [UIFont systemFontOfSize:13];
    }
    return _machine_code;
}
-(UILabel *)machine_tixt{
    if (!_machine_tixt) {
        _machine_tixt = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 120, 20)];
        _machine_tixt.textColor = UIColorFromRGB(0x999999);
        _machine_tixt.font = [UIFont systemFontOfSize:13];
    }
    return _machine_tixt;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
