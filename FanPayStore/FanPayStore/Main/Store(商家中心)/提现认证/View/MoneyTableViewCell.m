//
//  MoneyTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoneyTableViewCell.h"

@implementation MoneyTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.CellBase];
        [self.CellBase addSubview:self.cellIcon];
        [self.CellBase addSubview:self.cellIcon_jt];
        [self.CellBase addSubview:self.cellLabel];
        [self.cellIcon_jt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(6, 10));
        }];
        
    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    _cellIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",Data[@"icon"]]];
    
    _cellLabel.text = [NSString stringWithFormat:@"%@",Data[@"label"]];

}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 80)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
    }
    return _CellBase;
}
-(UIImageView *)cellIcon{
    if (!_cellIcon) {
        _cellIcon = [[UIImageView alloc]initWithFrame:CGRectMake(29,18,44,44)];
    }
    return _cellIcon;
}
-(UIImageView *)cellIcon_jt{
    if (!_cellIcon_jt) {
        _cellIcon_jt = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-50,35,10,10)];
        _cellIcon_jt.image = [UIImage imageNamed:@"ico_arrow_right_blue"];
    }
    return _cellIcon_jt;
}
-(UILabel *)cellLabel{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(90,32,100,15)];
        _cellLabel.font = [UIFont systemFontOfSize:autoScaleW(16)];
        _cellLabel.textColor = UIColorFromRGB(0x222222);
        _cellLabel.text = @"小微商户";
    }
    return _cellLabel;
}
@end
