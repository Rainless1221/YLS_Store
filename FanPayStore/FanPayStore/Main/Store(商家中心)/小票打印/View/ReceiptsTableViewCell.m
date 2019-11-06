//
//  ReceiptsTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/9/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "ReceiptsTableViewCell.h"

@implementation ReceiptsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.ReceName];
        [self.ReceName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.left.mas_offset(10);
            make.right.mas_offset(-130);
        }];
        
        
        [self addSubview:self.ReceType];
        [self.ReceType mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.width.mas_offset(60);
            make.right.mas_offset(-75);
        }];
        
       
        
        [self addSubview:self.TypeButton_sele];
        [self.TypeButton_sele mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.width.mas_offset(45);
            make.height.mas_offset(16);
            make.right.mas_offset(-8);
        }];
        
        [self addSubview:self.TypeButton];
        [self.TypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.mas_offset(0);
            make.width.mas_offset(15);
            make.right.mas_offset(-10);
        }];
    }
    return self;
}

-(void)setReceData:(CBPeripheral *)receData{
    
    self.ReceName.text = [NSString stringWithFormat:@"%@",receData.name];
    
    
    if (receData.state == CBPeripheralStateConnected) {
        //链接
        self.ReceType.text = [NSString stringWithFormat:@"已连接"];
        _TypeButton_sele.backgroundColor = UIColorFromRGB(0x45A6FF);
        self.TypeButton_sele.selected = YES;

        self.TypeButton.hidden = YES;
    } else {
        //未链接

        self.ReceType.text = [NSString stringWithFormat:@"可连接"];
        _TypeButton_sele.backgroundColor = UIColorFromRGB(0xFFFFFF);
        self.TypeButton_sele.selected = NO;
        self.TypeButton.hidden = NO;

    }
}
#pragma mark - 懒加载
-(UILabel *)ReceName{
    if (!_ReceName) {
        _ReceName = [[UILabel alloc]init];
        _ReceName.textColor = [UIColor blackColor];
        _ReceName.font = [UIFont systemFontOfSize:16];
    }
    return _ReceName;
}
-(UILabel *)ReceType{
    if (!_ReceType) {
        _ReceType = [[UILabel alloc]init];
        _ReceType.textColor = UIColorFromRGB(0x999999);
        _ReceType.font = [UIFont systemFontOfSize:12];
        _ReceType.textAlignment = 1;
    }
    return _ReceType;
}
-(UIButton *)TypeButton{
    if (!_TypeButton) {
        _TypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TypeButton setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
    }
    return _TypeButton;
}
-(UIButton *)TypeButton_sele{
    if (!_TypeButton_sele) {
        _TypeButton_sele = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TypeButton_sele setTitle:@"已连接" forState:UIControlStateSelected];
//        [_TypeButton_sele setImage:[UIImage imageNamed:@"ico_arrow_right_black"] forState:UIControlStateNormal];
//        [_TypeButton_sele setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateSelected];
        _TypeButton_sele.titleLabel.font = [UIFont systemFontOfSize:10];
        _TypeButton_sele.layer.cornerRadius = 8;

    }
    return _TypeButton_sele;
}
@end
