//
//  BranchViewCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/11.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "BranchViewCell.h"

@implementation BranchViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.branchicon];
        [self addSubview:self.StoreName];
        [self.branchicon addSubview:self.branchimage];
        [self addSubview:self.addButton];
        
        
        
    }
    return self;
}
#pragma mark - 赋值
- (void)setData:(NSDictionary *)Data{

    
    //店名
    self.StoreName.text = [NSString stringWithFormat:@"%@",Data[@"store_name"]];
    
    
    //icon
    NSString *url = [NSString stringWithFormat:@"%@",Data[@"store_logo"]];
    if ([PublicMethods isUrl:url]) {
        
    }else{
        url = [NSString stringWithFormat:@"%@%@",FBHApi_Url,url];
    }
    [self.branchicon sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"pic_default_avatar"]];
    
    
    //主or分。branch_type
//    self.branchimage.hidden = NO;

    NSString *type = [NSString stringWithFormat:@"%@",Data[@"branch_type"]];
    if ([type isEqualToString:@"1"]) {
        self.branchimage.image = [UIImage imageNamed:@"icn_branch_store"];

    }else{
        self.branchimage.image = [UIImage imageNamed:@"icn_main_store"];
    }
    
    
    
}
-(void)btnAction{
    
    if (self.conversionBlock) {
        self.conversionBlock();
    }
}
#pragma mark - 懒加载
-(UIButton *)branchButton{
    if (!_branchButton) {
        _branchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _branchButton.frame = CGRectMake(10, 10, self.width - 20, self.height-30);
        [_branchButton setImage:[UIImage imageNamed:@"jiameng_top_bg"] forState:UIControlStateNormal];
        
        
    }
    return _branchButton;
}
-(UIImageView *)branchicon{
    if (!_branchicon) {
        _branchicon = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, self.width - 20, self.height-40)];
        _branchicon.image = [UIImage imageNamed:@"btn_add_branch_store_normal"];
        _branchicon.layer.cornerRadius = 5;
        _branchicon.layer.masksToBounds = YES;
    }
    return _branchicon;
}
-(UILabel *)StoreName{
    if (!_StoreName) {
        _StoreName = [[UILabel alloc]initWithFrame:CGRectMake(self.branchicon.left, self.branchicon.bottom+5, self.width-10, 20)];
        _StoreName.text = @"添加分店";
        _StoreName.textColor = UIColorFromRGB(0x333333);
        _StoreName.font = [UIFont systemFontOfSize:15];
    }
    return _StoreName;
}
-(UIImageView *)branchimage{
    if (!_branchimage) {
        _branchimage = [[UIImageView alloc]initWithFrame:CGRectMake(self.branchicon.width-20, 0, 20, 20)];
        _branchimage.image = [UIImage imageNamed:@"icn_main_store"];
        _branchimage.hidden = YES;

    }
    return _branchimage;
}
-(UIButton *)addButton{
    if (!_addButton) {
        _addButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _addButton.frame = CGRectMake(10, self.branchicon.height-25, 65, 30);
        [_addButton setTitle:@" 编辑" forState:UIControlStateNormal];
        [_addButton setImage:[UIImage imageNamed:@"icn_branch_edit_white"] forState:UIControlStateNormal];
        _addButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_addButton addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
        _addButton.hidden = YES;

    }
    return _addButton;
}
@end
