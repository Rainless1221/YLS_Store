//
//  AttriCell.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/30.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "AttriCell.h"

@implementation AttriCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        /*UI*/
        [self createUI];
    }
    
     return self;
}
#pragma mark - UI
-(void)createUI{
    [self addSubview:self.SuXin];
    [self.SuXin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(14.5);
        make.height.mas_offset(45);
    }];
    
    [self addSubview:self.DeleteBtn];
    [self.DeleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-15);
        make.size.mas_offset(CGSizeMake(44, 20));
        make.top.mas_offset(15);
    }];
    [self addSubview:self.BaseView];
    [self.BaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(45);
        make.right.mas_offset(-15);
        make.left.mas_offset(15);
        make.bottom.mas_offset(0);
    }];
    
    
    /********   输入  *******/
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(9.5,0,70,50);
    label1.numberOfLines = 0;
    label1.text = @"属性名称";
    label1.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:label1];
    
    
    [self.BaseView addSubview:self.AttriField];
    [self.AttriField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.right.mas_offset(-15);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    
    UIView *LineView = [[UIView alloc] init];
    LineView.frame = CGRectMake(10,50,self.width-20,0.5);
    LineView.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView addSubview:LineView];
    
    
    UILabel *label2 = [[UILabel alloc] init];
    label2.frame = CGRectMake(9.5,LineView.bottom,70,50);
    label2.numberOfLines = 0;
    label2.text = @"属性选项";
    label2.font = [UIFont systemFontOfSize:15];
    [self.BaseView addSubview:label2];
    
    [self.BaseView addSubview:self.AttriField1];
    [self.AttriField1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(LineView.mas_bottom).offset(0);
        make.right.mas_offset(-15);
        make.left.equalTo(label1.mas_right).offset(10);
        make.height.mas_offset(50);
    }];
    
    [self.BaseView addSubview:self.AddAttriBtn];
    [self.AddAttriBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(50, 50));
        make.top.mas_offset(50);
    }];
    
    UIView *LineView1 = [[UIView alloc] init];
    LineView1.frame = CGRectMake(10,LineView.bottom+50,self.width-20,0.5);
    LineView1.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [self.BaseView addSubview:LineView1];
    
     NSMutableArray *array = [NSMutableArray arrayWithObjects:@"主食",@"推荐菜",@"汤类",@"锅煲",@"特色小食",@"时蔬",@"酒水",@"酒水酒水酒水酒水酒水",@"111",nil];
    self.tagList = [[AttriLabView alloc]initWithFrame:CGRectMake(0, label2.bottom,ScreenW-35, 10)];
    self.tagList.tagArray = array;
    self.tagList.delagate = self;
    /*标签颜色*/
    self.tagList.tagColor = UIColorFromRGB(0x666666);
    /*标签背景颜色*/
    self.tagList.tagBackgroundColor = UIColorFromRGB(0xF9F9F9);
    /*选中标签颜色*/
    self.tagList.SeletagColor = UIColorFromRGB(0xF7AE2B);
    /*选中标签背景颜色*/
    self.tagList.SeletagBackgroundColor = UIColorFromRGB(0xFCF6DE);
    /*标签边框颜色*/
    self.tagList.borderColor= UIColorFromRGB(0xDCDCDC);
    /*选中标签边框颜色*/
    self.tagList.SeleborderColor= UIColorFromRGB(0xF7AE2B);
    self.tagList.backgroundColor = [UIColor clearColor];//UIColorFromRGB(0xFFFFFF);
    
    [self.BaseView addSubview:self.tagList];
    
    self.BaseView.height  = self.tagList.height +145;
    
    self.SuXin.text = @"属性1";
}
#pragma mark - 添加
-(void)addAttri{
    if (self.AttriField1.text==nil||self.AttriField1.text.length==0) {
        
        return;
    }
    [self.tagList addTag:self.AttriField1.text];
    self.AttriField1.text = @"";
    
    self.BaseView.height  = self.tagList.height +145;
    CGRect frame = self.frame;
    frame.size.height = self.BaseView.height;
    [UIView animateWithDuration:0.25 animations:^{
        self.frame = frame;
    }];
    
}
#pragma mark - 高度
- (CGFloat)getCellHeight{
    return self.BaseView.height;
}
#pragma mark - 懒加载
-(UILabel *)SuXin{
    if (!_SuXin) {
        _SuXin = [[UILabel alloc] initWithFrame:CGRectMake(14.5, 0, 100, 45)];
        _SuXin.numberOfLines = 0;
        _SuXin.font = [UIFont systemFontOfSize:15];
        _SuXin.textColor = UIColorFromRGB(0x222222);
    }
    return _SuXin;
}
-(UIButton *)DeleteBtn{
    if (!_DeleteBtn) {
        _DeleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _DeleteBtn.frame = CGRectMake(self.width-55, 15, 40, 20);
        [_DeleteBtn setTitle:@"删除" forState:UIControlStateNormal];
        [_DeleteBtn setTitleColor:UIColorFromRGB(0xD03B34) forState:UIControlStateNormal];
        _DeleteBtn.titleLabel.font = [UIFont systemFontOfSize:12];
        _DeleteBtn.layer.borderWidth = 1;
        _DeleteBtn.layer.borderColor = UIColorFromRGB(0xD03B34).CGColor;
        _DeleteBtn.layer.cornerRadius = 10;
    }
    return _DeleteBtn;
}
-(UIView *)BaseView{
    if (!_BaseView) {
        _BaseView = [[UIView alloc]initWithFrame:CGRectMake(15, 45, self.width-30, self.height-45)];
        _BaseView.backgroundColor = [UIColor whiteColor];
        _BaseView.layer.cornerRadius = 5;
    }
    return _BaseView;
}

-(UITextField *)AttriField{
    if (!_AttriField) {
        _AttriField = [[UITextField alloc]init];
        _AttriField.placeholder = @"例如：甜度，辣度";
        _AttriField.font = [UIFont systemFontOfSize:15];
    }
    return _AttriField;
}
-(UITextField *)AttriField1{
    if (!_AttriField1) {
        _AttriField1 = [[UITextField alloc]init];
        _AttriField1.placeholder = @"例如：少糖，正常糖，多糖";
        _AttriField1.font = [UIFont systemFontOfSize:15];
    }
    return _AttriField1;
}

-(UIButton *)AddAttriBtn{
    if (!_AddAttriBtn) {
        _AddAttriBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_AddAttriBtn setImage:[UIImage imageNamed:@"icn_add_attributes_gray"] forState:UIControlStateNormal];
        [_AddAttriBtn addTarget:self action:@selector(addAttri) forControlEvents:UIControlEventTouchUpInside];
    }
    return _AddAttriBtn;
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
