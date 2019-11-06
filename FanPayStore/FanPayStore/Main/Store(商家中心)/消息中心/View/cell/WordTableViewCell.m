//
//  WordTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "WordTableViewCell.h"

@implementation WordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.CellBase];
        [self.CellBase addSubview:self.cellIcon];
        [self.CellBase addSubview:self.cellLabel];
        [self.CellBase addSubview:self.cellText];
        [self.CellBase addSubview:self.celltype];
        [self.CellBase addSubview:self.celltime];
        [self.celltime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_offset(-10);
            make.top.mas_offset(22);
        }];

    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    _cellLabel.text = [NSString stringWithFormat:@"%@",Data[@"label"]];
    NSString *imageName = [NSString stringWithFormat:@"%@",Data[@"icon"]];
    _cellIcon.image = [UIImage imageNamed:imageName];
    
}
- (void)setTableData:(NSDictionary *)TableData{
    
    /*内容*/
    if ([[MethodCommon judgeStringIsNull:[NSString stringWithFormat:@"%@",TableData[@"news_content"]]] isEqualToString:@""]) {
        
    }else{
        _cellText.text = [NSString stringWithFormat:@"%@",TableData[@"news_content"]];
    }
    
 /*
  未读
  */
    NSString *num = [NSString stringWithFormat:@"%@",TableData[@"unread_news_num"]];

    if ([[MethodCommon judgeStringIsNull:num] isEqualToString:@""]) {
        
    }else{
        if ([num isEqualToString:@"0"]) {
            _celltype.hidden = YES;
        }else{
            _celltype.hidden = NO;
            _celltype.text = num;
            _celltype.backgroundColor = UIColorFromRGB(0xEE3319);
        }
        
    }
    
    /*时间*/
    NSString *time = [NSString stringWithFormat:@"%@",TableData[@"add_time"]];
    
    if ([[MethodCommon judgeStringIsNull:time] isEqualToString:@""]) {
        
    }else{
            _celltime.text = time;
        
    }
}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 83)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
    }
    return _CellBase;
}
-(UIImageView *)cellIcon{
    if (!_cellIcon) {
        _cellIcon = [[UIImageView alloc]initWithFrame:CGRectMake(6,13,56,56)];
    }
    return _cellIcon;
}
-(UILabel *)cellLabel{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.cellIcon.right+10,15,150,15)];
        _cellLabel.font = [UIFont systemFontOfSize:autoScaleW(18)];
        _cellLabel.textColor = UIColorFromRGB(0x222222);
    }
    return _cellLabel;
}
-(UILabel *)cellText{
    if (!_cellText) {
        _cellText = [[UILabel alloc]initWithFrame:CGRectMake(self.cellLabel.left,self.cellLabel.bottom+10,self.CellBase.width-self.cellLabel.left-30,20)];
        _cellText.font = [UIFont systemFontOfSize:autoScaleW(13)];
        _cellText.textColor = UIColorFromRGB(0x999999);
    }
    return _cellText;
}
-(UILabel *)celltype{
    if (!_celltype) {
        _celltype = [[UILabel alloc]initWithFrame:CGRectMake(self.CellBase.width-30,46,18,18)];
        _celltype.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _celltype.textColor = UIColorFromRGB(0xFFFFFF);
        _celltype.textAlignment = 1;
        _celltype.layer.cornerRadius = 9;
        _celltype.layer.masksToBounds = YES;

    }
    return _celltype;
}
-(UILabel *)celltime{
    if (!_celltime) {
        _celltime = [[UILabel alloc]initWithFrame:CGRectMake(self.cellLabel.right,22,self.CellBase.width-self.cellLabel.right-10,18)];
        _celltime.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _celltime.textColor = UIColorFromRGB(0x999999);
        _celltime.textAlignment = 2;
        
    }
    return _celltime;
}
@end
