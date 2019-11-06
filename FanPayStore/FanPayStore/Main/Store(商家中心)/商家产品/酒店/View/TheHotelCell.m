//
//  TheHotelCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "TheHotelCell.h"

@implementation TheHotelCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
    [self addSubview:self.BaseView];
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(7);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-7);
    }];
    
    [self.BaseView addSubview:self.cellimage];
    [self.BaseView addSubview:self.cellName];
    [self.BaseView addSubview:self.celljiage];
    [self.BaseView addSubview:self.cellnote];
    [self.BaseView addSubview:self.cellbiaoqian];
    

    [self.cellimage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(autoScaleW(120), autoScaleW(100)));
    }];
    
    
    [self.cellName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.equalTo(self.cellimage.mas_right).offset(16);
        make.right.mas_offset(-10);
        make.height.mas_offset(17);
    }];
    [self.celljiage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.cellimage.mas_bottom).offset(14);
        make.left.equalTo(self.cellimage.mas_right).offset(16);
    }];
    
    [self.cellnote mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.celljiage.mas_bottom).offset(0);
        make.left.equalTo(self.celljiage.mas_right).offset(16);
    }];
    [self.cellbiaoqian mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.cellimage.mas_bottom).offset(0);
        make.left.equalTo(self.cellimage.mas_right).offset(16);
        make.height.mas_offset(20);
    }];
    
    
    self.cellName.text = @"云坞";
    
    NSString *protocol = [NSString stringWithFormat:@"%@元/晚",@"980"];
    NSMutableAttributedString *attri_str=[[NSMutableAttributedString alloc] initWithString:protocol];
    //设置字体颜色
    [attri_str setFont:[UIFont systemFontOfSize:13]];
    [attri_str setColor:[UIColor colorWithHexString:@"EE4E3E"]];
    NSRange ProRange = [protocol rangeOfString:@"元/晚"];
    [attri_str setFont:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [attri_str setTextHighlightRange:ProRange color:[UIColor colorWithHexString:@"EE4E3E"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.celljiage.attributedText = attri_str;
//    [self.celljiage sizeToFit];
    
    NSString *protocol1 = [NSString stringWithFormat:@"1间"];
    NSMutableAttributedString *attri_str1=[[NSMutableAttributedString alloc] initWithString:protocol1];
    //设置字体颜色
    [attri_str1 setFont:[UIFont systemFontOfSize:13]];
    [attri_str1 setColor:[UIColor colorWithHexString:@"3D8AFF"]];
    NSRange ProRange1 = [protocol1 rangeOfString:@"间"];
//    [attri_str1 setFont:[UIFont systemFontOfSize:20] range:NSMakeRange(0, 1)];
    [attri_str1 setTextHighlightRange:ProRange1 color:[UIColor colorWithHexString:@"999999"] backgroundColor:[UIColor whiteColor] userInfo:nil];
    self.cellnote.attributedText = attri_str1;

    
    self.cellbiaoqian.text = @"#标准房";

    
    /*下架按钮*/
    [self.BaseView addSubview:self.DeleteButton];
    [self.DeleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
    /*编辑按钮*/
    [self.BaseView addSubview:self.DetailButton];
    [self.DetailButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-15);
        make.right.equalTo(self.DeleteButton.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(80, 32));
    }];
}
/** 下架 */
-(void)DeleteAction{
    
    //    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_order:)]) {
    //        [self.delagate delete_order:self.Data];
    //    }
    
}
/** 编辑 */
-(void)DetailAction{
    
    //    if (self.delagate && [self.delagate respondsToSelector:@selector(Delete:)]) {
    //        [self.delagate Delete:self.Data];
    //    }
}

#pragma mark - 懒加载
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 7, ScreenW-30, 209)];
        _BaseView.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView;
}
-(UIImageView *)cellimage{
    if (!_cellimage) {
        _cellimage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, autoScaleW(120), autoScaleW(100))];
        _cellimage.image = [UIImage imageNamed:@"pic_default_avatar"];
    }
    return _cellimage;
}
-(UILabel *)cellName{
    if (!_cellName) {
        _cellName = [[UILabel alloc]initWithFrame:CGRectMake(16, 15, 120, 17)];
        _cellName.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
        _cellName.font = [UIFont systemFontOfSize:autoScaleW(18)];
        _cellName.textAlignment = 0;
    }
    return _cellName;
}
-(YYLabel *)celljiage{
    if (!_celljiage) {
        _celljiage = [[YYLabel alloc]initWithFrame:CGRectMake(145, 124, 80, 18)];
        _celljiage.textColor = [UIColor colorWithRed:238/255.0 green:78/255.0 blue:62/255.0 alpha:1.0];
        _celljiage.font = [UIFont systemFontOfSize:20];
    }
    return _celljiage;
}
-(YYLabel *)cellnote{
    if (!_cellnote) {
        _cellnote = [[YYLabel alloc]initWithFrame:CGRectMake(145, 127, 100, 18)];
        _cellnote.textColor = [UIColor colorWithRed:238/255.0 green:78/255.0 blue:62/255.0 alpha:1.0];
        _cellnote.font = [UIFont systemFontOfSize:20];

    }
    return _cellnote;
}
-(UILabel *)cellbiaoqian{
    if (!_cellbiaoqian) {
        _cellbiaoqian = [[UILabel alloc]initWithFrame:CGRectMake(16, 15, 65, 20)];
        _cellbiaoqian.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _cellbiaoqian.font = [UIFont systemFontOfSize:autoScaleW(12)];
        _cellbiaoqian.textAlignment = 0;
        _cellbiaoqian.layer.borderWidth = 1;
        _cellbiaoqian.layer.borderColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0].CGColor;
        _cellbiaoqian.layer.cornerRadius = 10;
    }
    return _cellbiaoqian;
}
-(UIButton *)DeleteButton{
    if (!_DeleteButton) {
        _DeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_DeleteButton setTitle:@"下架" forState:UIControlStateNormal];
        [_DeleteButton setTitleColor:UIColorFromRGB(0x4F4F4F) forState:UIControlStateNormal];
        _DeleteButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _DeleteButton.layer.cornerRadius = 16;
        _DeleteButton.layer.borderWidth = 1;
        _DeleteButton.layer.borderColor = [UIColorFromRGB(0x8D8D8D) CGColor];
        [_DeleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DeleteButton;
}
-(UIButton *)DetailButton{
    if (!_DetailButton) {
        _DetailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_DetailButton setTitle:@"编辑" forState:UIControlStateNormal];
        [_DetailButton setTitleColor:UIColorFromRGB(0xFFFFFF) forState:UIControlStateNormal];
        [_DetailButton setBackgroundColor:UIColorFromRGB(0x3D8AFF)];
        _DetailButton.titleLabel.font = [UIFont systemFontOfSize:14];
        _DetailButton.layer.cornerRadius = 16;
        _DetailButton.layer.borderWidth = 1;
        _DetailButton.layer.borderColor = [UIColorFromRGB(0x3D8AFF) CGColor];
        [_DetailButton addTarget:self action:@selector(DetailAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _DetailButton;
}
@end
