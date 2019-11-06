//
//  TableViewSectionHeaderView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "TableViewSectionHeaderView.h"
@interface TableViewSectionHeaderView ()



@end
@implementation TableViewSectionHeaderView
- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}
#pragma mark -赋值
- (void)setData:(NSDictionary *)Data{
//    self.label.text = Data[@""];
    self.label1.text = [NSString stringWithFormat:@"营收 %@ 支出 %@",Data[@""],Data[@""]] ;
}
- (void)setTitleStr:(NSString *)titleStr {
    _titleStr = titleStr;
    self.label.text = titleStr;
//    self.label1.text = [NSString stringWithFormat:@"营收 %@ 支出 %@",titleStr,titleStr] ;

}

- (void)setupUI {
    self.label = [UILabel new];
    self.label.font = [UIFont systemFontOfSize:15];
    [self.contentView addSubview:self.label];
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.mas_offset(29);
    }];
    
    self.label1 = [UILabel new];
    self.label1.font = [UIFont systemFontOfSize:12];
    self.label1.textColor = UIColorFromRGB(0x999999);
    [self.contentView addSubview:self.label1];
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.mas_offset(-15);
    }];
    
    UIView *yuan = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 5)];
    yuan.backgroundColor = UIColorFromRGB(0x3D8AFF);
    yuan.layer.cornerRadius = 2;
    yuan.layer.masksToBounds = YES;
    [self addSubview:yuan];
    [yuan mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self.label.mas_left).offset(-10);
        make.size.mas_offset(CGSizeMake(5, 5));
    }];
    
}




@end
