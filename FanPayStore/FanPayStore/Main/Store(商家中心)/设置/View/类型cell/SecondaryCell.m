//
//  SecondaryCell.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "SecondaryCell.h"

@implementation SecondaryCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        self.backgroundColor = [UIColor whiteColor];
        /*名称*/
        self.category_name = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 150, 50)];
        self.category_name.textColor = UIColorFromRGB(0x222222);
        self.category_name.font = [UIFont systemFontOfSize:15];
//        category_name.text = [NSString stringWithFormat:@"%@",self.TypesData[indexPath.row][@"category_name"]];
        [self addSubview:self.category_name];
        
        /* icon */
        self.icon = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.icon setImage:[UIImage imageNamed:@"btn_check_box_normal"] forState:UIControlStateNormal];
        [self.icon setImage:[UIImage imageNamed:@"btn_product_label_select_yellow"] forState:UIControlStateSelected];
        [self.icon addTarget:self action:@selector(SeleAction:) forControlEvents:UIControlEventTouchUpInside];
        self.icon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;

        [self addSubview:self.icon];
        [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.mas_offset(0);
            make.right.mas_offset(-10);
            make.left.mas_offset(0);
            make.height.mas_offset(50);
        }];
        /*line*/
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 49, self.width-50, 1)];
        line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
        [self addSubview:line];
        [line mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.bottom.mas_offset(0);
            make.height.mas_offset(1);
        }];
        
    }
    return self;
}
- (void)setData:(NSDictionary *)Data{
    self.category_name.text = [NSString stringWithFormat:@"%@",Data[@"category_name"]];
}

- (void)SeleAction:(UIButton *)sender {
    self.isSelect = !self.isSelect;
    if (self.qhxSelectBlock) {
        self.qhxSelectBlock(self.isSelect,sender.tag);
    }
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
