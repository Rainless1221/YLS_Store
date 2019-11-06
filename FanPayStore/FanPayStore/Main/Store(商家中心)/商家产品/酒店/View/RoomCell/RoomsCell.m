//
//  RoomsCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "RoomsCell.h"

@implementation RoomsCell
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
        make.top.bottom.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
    }];
    
    
    [self.BaseView addSubview:self.celltext];
    [self.celltext mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(150, 15));
    }];
    
    
}
#pragma mark - 赋值
-(void)setData:(NSDictionary *)Data{
    
    self.celltext.text = [NSString stringWithFormat:@"%@",Data[@"label"]];
}
#pragma mark - 懒加载
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 7, ScreenW-30, 209)];
        _BaseView.backgroundColor = [UIColor whiteColor];
    }
    return _BaseView;
}
-(UILabel *)celltext{
    if (!_celltext) {
        _celltext = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 120, 15)];
        _celltext.font = [UIFont systemFontOfSize:15];
        _celltext.textColor = [UIColor colorWithRed:34/255.0 green:34/255.0 blue:34/255.0 alpha:1.0];
    }
    return _celltext;
}
@end
