//
//  MarkeViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MarkeViewCell.h"

@implementation MarkeViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.CellBase];
        [self.CellBase addSubview:self.cellIcon];
        [self.CellBase addSubview:self.cellLabel];
        [self.CellBase addSubview:self.cell_text];
        [self.CellBase addSubview:self.cell_imag];

        
    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    _cellIcon.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",Data[@"icon"]]];
    
    
    self.cellLabel.text = [NSString stringWithFormat:@"%@",Data[@"name"]];

    
    
    self.cell_text.text = [NSString stringWithFormat:@"%@",Data[@"text"]];

}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 100)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
        

    }
    return _CellBase;
}
-(UIImageView *)cellIcon{
    if (!_cellIcon) {
        _cellIcon = [[UIImageView alloc]initWithFrame:CGRectMake(10,15,30,30)];
    }
    return _cellIcon;
}
-(UILabel *)cellLabel{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(55,22,100,15)];
        _cellLabel.font = [UIFont systemFontOfSize:autoScaleW(16)];
        _cellLabel.textColor = UIColorFromRGB(0x222222);
        _cellLabel.text = @"翻呗活动";
    }
    return _cellLabel;
}
-(UILabel *)cell_text{
    if (!_cell_text) {
        _cell_text = [[UILabel alloc]initWithFrame:CGRectMake(55,_cellLabel.bottom +15,246,32)];
        _cell_text.font = [UIFont systemFontOfSize:autoScaleW(13)];
        _cell_text.textColor = UIColorFromRGB(0x999999);
        _cell_text.numberOfLines = 0;
        _cell_text.text = @"翻呗活动是指商家通过一鹿省平台创建的在线优惠活动。";

    }
    return _cell_text;
}
-(UIImageView *)cell_imag{
    if (!_cell_imag) {
        _cell_imag = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-46,45,6,10)];
        _cell_imag.image = [UIImage imageNamed:@"input_arrow_right_blue"];
    }
    return _cell_imag;
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
