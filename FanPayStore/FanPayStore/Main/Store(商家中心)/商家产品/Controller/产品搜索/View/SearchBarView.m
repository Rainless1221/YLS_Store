//
//  SearchBarView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2020/1/2.
//  Copyright © 2020 mocoo_ios. All rights reserved.
//

#import "SearchBarView.h"

@implementation SearchBarView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        /*UI*/
        [self createUI];
    }
    return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.icon];
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(7);
        make.height.width.mas_offset(12);
    }];
    
    
    [self addSubview:self.QuXiao];
    [self.QuXiao mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-2);
        make.height.mas_offset(32);
        make.width.mas_offset(30);
    }];
    
    [self addSubview:self.SearchField];
    [self.SearchField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(24);
        make.right.mas_offset(-24);
        make.height.mas_offset(32);
        
    }];
    
    
}
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSLog(@"1");//输入文字时 一直监听
    NSString *text = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (text.length==0||text==nil) {
        self.QuXiao.hidden = YES;
    }else{
        self.QuXiao.hidden = NO;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"2");// 准备开始输入 文本字段将成为第一响应者
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"3");//文本彻底结束编辑时调用
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"4");//返回一个BOOL值，指定是否循序文本字段开始编辑
    return YES;
}
-(BOOL)textFieldShouldClear:(UITextField *)textField
{
    NSLog(@"5");// 点击‘x’清除按钮时 调用
    return YES;
}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"6");//返回BOOL值，指定是否允许文本字段结束编辑，当编辑结束，文本字段会让出第一响应者
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSLog(@"7");// 点击键盘的‘换行’会调用
    return YES;
}
#pragma mark - 清除输入框的内容
-(void)QingAction{
    self.SearchField.text = @"";
     self.QuXiao.hidden = YES;
}
#pragma mark - 懒加载
-(UIImageView *)icon{
    if (!_icon) {
        _icon = [[UIImageView alloc]init];
        _icon.image = [UIImage imageNamed:@"icn_nav_searchbar_find"];
//        _icon.backgroundColor = [UIColor redColor];
    }
    return _icon;
}
-(UIButton *)QuXiao{
    if (!_QuXiao) {
        _QuXiao =[UIButton buttonWithType:UIButtonTypeCustom];
        [_QuXiao setImage:[UIImage imageNamed:@"icn_nav_searchbar_clear"] forState:UIControlStateNormal];
        _QuXiao.hidden = YES;
        [_QuXiao addTarget:self action:@selector(QingAction) forControlEvents:UIControlEventTouchUpInside];
//        _QuXiao.backgroundColor = [UIColor redColor];
    }
    return _QuXiao;
}
-(UITextField *)SearchField{
    if (!_SearchField) {
        _SearchField = [[UITextField alloc]init];
        _SearchField.delegate = self;
        //修改字体大小
        _SearchField.font = [UIFont systemFontOfSize:12];
        _SearchField.placeholder = @"商品名称";
    }
    return _SearchField;
}
@end
