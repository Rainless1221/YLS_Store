//
//  Account_TXTableViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/1.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "Account_TXTableViewCell.h"

@implementation Account_TXTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview:self.CellBase];
        [self.CellBase addSubview:self.cellLabel];
        [self.CellBase addSubview:self.cellText];
        
        [self.CellBase addSubview:self.celltype];
        [self.celltype mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.right.mas_offset(-27);
            make.size.mas_offset(CGSizeMake(65, 15));
        }];
        
        [self.CellBase addSubview:self.cellIcon_jt];
        [self.cellIcon_jt mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.right.mas_offset(-10);
            make.size.mas_offset(CGSizeMake(6, 10));
        }];
        
        
        
        
//        UIView *view = [[UIView alloc] init];
//        view.frame = CGRectMake(25,520.5,325,0.5);
//        view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
//        [self.CellBase addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.bottom.mas_offset(-5);
//            make.height.mas_offset(1);
//        }];
        
    }
    return self;
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data
{
    
    _cellLabel.text = [NSString stringWithFormat:@"%@",Data[@"label"]];


}
- (void)setTableData:(NSDictionary *)TableData{
    
    
    
    NSString *str = [NSString stringWithFormat:@"%@",TableData[@"celltype"]];
    
    if ([str isEqualToString:@"1"]) {
        _celltype.text = @"已完成";
        _celltype.textColor = UIColorFromRGB(0x222222);
        NSString *String = [NSString stringWithFormat:@"%@",TableData[@"cellText1"]];
        if ([String isEqualToString:@""]) {
            _cellText.text = @"已上传";

        }else{
            _cellText.text = [NSString stringWithFormat:@"%@  %@",TableData[@"cellText1"],TableData[@"cellText2"]];

        }


    }else{
        _celltype.text = @"待完成";
        _celltype.textColor = UIColorFromRGB(0x3D8AFF);

    }
}
#pragma mark - 懒加载
-(UIView *)CellBase{
    if (!_CellBase) {
        _CellBase = [[UIView alloc]initWithFrame:CGRectMake(15, 0, ScreenW-30, 65)];
        _CellBase.backgroundColor = [UIColor whiteColor];
        _CellBase.layer.cornerRadius = 5;
    }
    return _CellBase;
}
-(UILabel *)cellLabel{
    if (!_cellLabel) {
        _cellLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,15,150,15)];
        _cellLabel.font = [UIFont systemFontOfSize:autoScaleW(15)];
        _cellLabel.textColor = UIColorFromRGB(0x222222);
    }
    return _cellLabel;
}
-(UILabel *)cellText{
    if (!_cellText) {
        _cellText = [[UILabel alloc]initWithFrame:CGRectMake(10,self.cellLabel.bottom,self.CellBase.width-20,20)];
        _cellText.font = [UIFont systemFontOfSize:autoScaleW(12)];
        _cellText.textColor = UIColorFromRGB(0x999999);
        _cellText.text = @"未上传";
    }
    return _cellText;
}
-(UILabel *)celltype{
    if (!_celltype) {
        _celltype = [[UILabel alloc]initWithFrame:CGRectMake(10,0,self.CellBase.width,20)];
        _celltype.font = [UIFont systemFontOfSize:autoScaleW(12)];
        _celltype.textColor = UIColorFromRGB(0x3D8AFF);
        _celltype.textAlignment = 2;
        _celltype.text = @"待完成";
    }
    return _celltype;
}
-(UIImageView *)cellIcon_jt{
    if (!_cellIcon_jt) {
        _cellIcon_jt = [[UIImageView alloc]initWithFrame:CGRectMake(ScreenW-50,35,10,10)];
        _cellIcon_jt.image = [UIImage imageNamed:@"ico_arrow_right_black"];
    }
    return _cellIcon_jt;
}
@end
