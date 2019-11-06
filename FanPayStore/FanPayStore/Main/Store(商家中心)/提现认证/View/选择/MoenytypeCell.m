//
//  MoenytypeCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoenytypeCell.h"

@implementation MoenytypeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self addSubview:self.TextLabel];
        [self addSubview:self.selectBtn];
    }
    return self;
}
- (void)setData:(NSDictionary *)Data{
    if ([[MethodCommon judgeStringIsNull:Data[@"category_name"]] isEqualToString:@""]) {
        
        self.TextLabel.text = @"";
    }else{
        self.TextLabel.text = [NSString stringWithFormat:@"%@",Data[@"category_name"]];
    }
    
    
    
}

- (void)SeleAction:(UIButton *)sender{
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
}
-(UILabel *)TextLabel{
    if (!_TextLabel) {
        _TextLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 50)];
        _TextLabel.textColor = UIColorFromRGB(0x222222);
        _TextLabel.font = [UIFont systemFontOfSize:15];
    }
    return _TextLabel;
}
-(UIButton *)selectBtn{
    if (!_selectBtn) {
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(10, 0, self.width, 50);
        _selectBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        [_selectBtn setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"btn_check_box_pressed"] forState:UIControlStateSelected];
        [_selectBtn addTarget:self action:@selector(SeleAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _selectBtn;
}
@end
