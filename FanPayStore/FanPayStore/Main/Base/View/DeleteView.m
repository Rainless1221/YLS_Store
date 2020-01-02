//
//  DeleteView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/15.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "DeleteView.h"

@implementation DeleteView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.56];

        [self addSubview:self.Baseview];
        [self.Baseview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.size.mas_offset(CGSizeMake(ScreenW-30, 353));
            make.center.mas_offset(0);
        }];
#pragma mark - 图标
        [self.Baseview addSubview:self.deleteIcon];
        [self.deleteIcon mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_offset(0);
            make.top.mas_offset(30);
            make.size.mas_offset(CGSizeMake(48, 48));
        }];
#pragma mark - 标题
        [self.Baseview addSubview:self.deleteLabel];
        [self.deleteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(10);
            make.right.mas_offset(-10);
            make.height.mas_offset(50);
            make.top.equalTo(self.deleteIcon.mas_bottom).offset(10);
        }];
        [self.Baseview addSubview:self.deleteText];
        [self.deleteText mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(44);
            make.top.equalTo(self.deleteLabel.mas_bottom).offset(0);
        }];
#pragma mark - 按钮
        [self.Baseview addSubview:self.cancel];
        [self.cancel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(44);
            make.bottom.mas_offset(-28);
        }];
        
        [self.Baseview addSubview:self.deleteButton];
        [self.deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_offset(30);
            make.right.mas_offset(-30);
            make.height.mas_offset(44);
            make.bottom.equalTo(self.cancel.mas_top).offset(-15);
        }];
    }
    return self;
}

#pragma mark - /** 删除 */
-(void)DeleteAction{
    
//    if (self.delagate && [self.delagate respondsToSelector:@selector(delete_card)]) {
//        [self.delagate delete_card];
//    }
    
    if (self.DeleteCardBlock) {
        self.DeleteCardBlock();
    }
    [self removeFromSuperview];

}
-(void)cancelAction{
    [self removeFromSuperview];

}
#pragma mark - 懒加载
-(UIView *)Baseview{
    if (!_Baseview) {
        _Baseview = [[UIView alloc]initWithFrame:CGRectMake(15, 157, ScreenW-30, 353)];
        _Baseview.backgroundColor = [UIColor whiteColor];
        _Baseview.layer.cornerRadius = 6;
    }
    return _Baseview;
}
-(UIImageView *)deleteIcon{
    if (!_deleteIcon) {
        _deleteIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 30, 48, 48)];
    }
    return _deleteIcon;
}
-(UILabel *)deleteLabel{
    if (!_deleteLabel) {
        _deleteLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _deleteIcon.bottom+14, ScreenW-30, 20)];
        _deleteLabel.textAlignment = 1;
        _deleteLabel.textColor = UIColorFromRGB(0x222222);
        _deleteLabel.font = [UIFont systemFontOfSize:20];
    }
    return _deleteLabel;
}
-(UILabel *)deleteText{
    if (!_deleteText) {
        _deleteText = [[UILabel alloc]initWithFrame:CGRectMake(30, _deleteLabel.bottom, ScreenW-60, 20)];
        _deleteText.textColor = UIColorFromRGB(0x222222);
        _deleteText.font = [UIFont systemFontOfSize:13];
        _deleteText.numberOfLines = 0;
    }
    return _deleteText;
}
-(UIButton *)deleteButton{
    if (!_deleteButton) {
        _deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _deleteButton.frame = CGRectMake(0,0,ScreenW-90,44);
        [_deleteButton setTitle:@"删除" forState:UIControlStateNormal];
        _deleteButton.titleLabel.font = [UIFont systemFontOfSize:18];
        [_deleteButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _deleteButton.backgroundColor = [UIColor colorWithRed:247/255.0 green:174/255.0 blue:43/255.0 alpha:1.0];
        _deleteButton.layer.cornerRadius = 10;
//        _deleteButton.layer.shadowColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:0.5].CGColor;
//        _deleteButton.layer.shadowOffset = CGSizeMake(0,1);
//        _deleteButton.layer.shadowOpacity = 1;
//        _deleteButton.layer.shadowRadius = 9;
//        CAGradientLayer *gl = [CAGradientLayer layer];
//        gl.frame = _deleteButton.frame;
//        gl.startPoint = CGPointMake(0, 0);
//        gl.endPoint = CGPointMake(1, 1);
//        gl.cornerRadius = 10;
//        gl.colors = @[(__bridge id)[UIColor colorWithRed:61/255.0 green:137/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:69/255.0 green:166/255.0 blue:255/255.0 alpha:1.0].CGColor,(__bridge id)[UIColor colorWithRed:67/255.0 green:193/255.0 blue:255/255.0 alpha:1.0].CGColor];
//        gl.locations = @[@(0.0),@(0.5),@(1.0)];
//
//        [_deleteButton.layer addSublayer:gl];
        [_deleteButton addTarget:self action:@selector(DeleteAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _deleteButton;
}
-(UIButton *)cancel{
    if (!_cancel) {
        _cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cancel setTitle:@"取消" forState:UIControlStateNormal];
        [_cancel setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
        _cancel.frame = CGRectMake(0,0,ScreenW-90,44);
        _cancel.titleLabel.font = [UIFont systemFontOfSize:18];
        _cancel.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
        _cancel.layer.cornerRadius = 10;
        _cancel.layer.borderWidth = 1;
        [_cancel addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];

    }
    return _cancel;
}
@end
