//
//  CodeTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/8/13.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "CodeTableViewCell.h"

@implementation CodeTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.CellBase];
       
        [self.CellBase addSubview:self.zhuo];
        [self.zhuo mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.bottom.mas_offset(0);
            make.width.mas_offset(45);
        }];
        
        [self.CellBase addSubview:self.munt];
        [self.munt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.equalTo(self.zhuo.mas_right).offset(5);
        }];
        [self.CellBase addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.left.equalTo(self.munt.mas_right).offset(20);
            make.size.mas_offset(CGSizeMake(20, 20));
        }];
        
        UIButton *deleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        deleButton.titleLabel.font  =[UIFont systemFontOfSize:15];
        [deleButton setImage:[UIImage imageNamed:@"btn_delete_shop_info_image_normal"] forState:UIControlStateNormal];
        [deleButton addTarget:self action:@selector(deleAction) forControlEvents:UIControlEventTouchUpInside];
        [self.CellBase addSubview:deleButton];
        [deleButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.right.bottom.mas_offset(0);
            make.width.mas_offset(40);
        }];
        
        [self.CellBase addSubview:self.addButton];
        [self.addButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_offset(0);
        }];

        self.CellBase.userInteractionEnabled = YES;
        UITapGestureRecognizer *labelTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTouchUpInside:)];
        
        [self.CellBase addGestureRecognizer:labelTapGestureRecognizer];
    }
    return self;
}
-(void) labelTouchUpInside:(UITapGestureRecognizer *)recognizer{
    if (self.BaseCodeBlock) {
        self.BaseCodeBlock();
    }
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    //table_number
     _munt.text = [NSString stringWithFormat:@"%@",Data[@"table_number"]];
    
}
-(void)addAction{
    if (self.addCodeBlock) {
        self.addCodeBlock();
    }
}
-(void)deleAction{
    if (self.deleCodeBlock) {
        self.deleCodeBlock();
    }
}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 60)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
        
    }
    return _CellBase;
}
-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addButton setTitle:@" 添加新桌号" forState:UIControlStateNormal];
        [_addButton setTitleColor:[UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0] forState:UIControlStateNormal];
        _addButton.titleLabel.font  =[UIFont systemFontOfSize:15];
        [_addButton setImage:[UIImage imageNamed:@"icn_add_table_code_item"] forState:UIControlStateNormal];
        _addButton.backgroundColor = [UIColor whiteColor];
        [_addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _addButton;
}
-(UILabel *)zhuo{
    if (!_zhuo) {
        _zhuo = [[UILabel alloc]initWithFrame:CGRectMake(0,0,45,60)];
        _zhuo.font = [UIFont systemFontOfSize:autoScaleW(11)];
        _zhuo.textColor = UIColorFromRGB(0x666666);
        _zhuo.textAlignment = 1;
        _zhuo.text = @"桌号：";
    }
    return _zhuo;
}
-(UILabel *)munt{
    if (!_munt) {
        _munt = [[UILabel alloc]initWithFrame:CGRectMake(45,0,45,60)];
        _munt.font = [UIFont systemFontOfSize:autoScaleW(22)];
        _munt.textColor = UIColorFromRGB(0x222222);
        _munt.textAlignment = 1;
        _munt.text = @"心喜阁";
    }
    return _munt;
}
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 20, 20)];
        _icon.image = [UIImage imageNamed:@"icn_sample_qrcode"];
    }
    return _icon;
}
@end
