//
//  YLSCommodityAttriController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/11/5.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//  商品属性

#import "YLSCommodityAttriController.h"
#import "AttriCell.h"
#import "AttriLabView.h"

@interface YLSCommodityAttriController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * AttriTableview;
/** 数据 **/
@property (strong,nonatomic)NSMutableArray * Data;

@end

@implementation YLSCommodityAttriController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品属性";
    /*导航栏*/
    [self setupNav];
    /*UI*/
    [self createUI];
}

#pragma mark - 导航栏
-(void)setupNav{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setTitle:@"保存" forState:UIControlStateNormal];
    [Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:14];
    [Button addTarget:self action:@selector(SaveAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *SaveButton =[[UIBarButtonItem alloc]initWithCustomView:Button];
    // [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(SaveAction)];
    
    self.navigationItem.rightBarButtonItem = SaveButton;
    
}
-(void)SaveAction{
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"确认保存";
    NSString *card_number = [NSString stringWithFormat:@"您添加的商品属性还未保存，是否确认不保存直 接退出。"];
    samView.deleteText.text = card_number;
     [samView.deleteButton setTitle:@"保存退出" forState:UIControlStateNormal];
    [samView.cancel setTitle:@"退出" forState:UIControlStateNormal];
    samView.DeleteCardBlock = ^{
//        [self Delete_goods:goodsArr];
        
    };
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
}
#pragma mark - UI
-(void)createUI{
    
    /**添加属性*/
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(59);
    }];
    /**添加按钮*/
    UIButton *AddButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [AddButton setTitle:@"添加属性" forState:UIControlStateNormal];
    [AddButton setTitleColor:UIColorFromRGB(0x222222) forState:UIControlStateNormal];
    AddButton.titleLabel.font = [UIFont systemFontOfSize:16];
    AddButton.layer.cornerRadius = 20;
    AddButton.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [AddButton addTarget:self action:@selector(AddAttriAction) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:AddButton];
    [AddButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(9.5);
        make.bottom.mas_offset(-9.5);
        make.left.mas_offset(42.5);
        make.right.mas_offset(-42.5);
    }];
    
    [self.view addSubview:self.AttriTableview];
    [self.AttriTableview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.mas_offset(0);
        make.bottom.mas_offset(-59);
    }];
    
   
}



#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return self.Data.count;
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AttriCell * cell= [tableView dequeueReusableCellWithIdentifier:@"AttriCell"];
    cell=[[AttriCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttriCell"];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
//    cell.Data = self.Data[indexPath.row];
    return cell;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = UIColorFromRGB(0xF6F6F6);
    UIView *heightview = [[UIView alloc] init];
    heightview.frame = CGRectMake(15,15,ScreenW-30,87);
    heightview.backgroundColor = [UIColor whiteColor];
    heightview.layer.cornerRadius = 5;
    [headerV addSubview:heightview];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(10,14.5,100,14);
    label.numberOfLines = 0;
    label.text = @"商品属性";
    label.font = [UIFont systemFontOfSize:15];
    [heightview addSubview:label];
    
    
    UILabel *label1 = [[UILabel alloc] init];
    label1.frame = CGRectMake(10,label.bottom+10,heightview.width-20,12.5);
    label1.numberOfLines = 0;
    label1.text = @"商品属性是指下单时有多种口味，如全糖/无糖，微辣/特辣等。不影响商品价格。 ";
    label1.font = [UIFont systemFontOfSize:13];
    label1.textColor = UIColorFromRGB(0x999999);
    [label1 sizeToFit];
    [heightview addSubview:label1];
    return headerV;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UILabel *footer = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 52)];
    return footer;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 102;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AttriCell * cell = (AttriCell *)[tableView.dataSource tableView:tableView cellForRowAtIndexPath:indexPath];
    //直接返回cell 高度
    return [cell getCellHeight];
    
//    return 350;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delagate && [self.delagate respondsToSelector:@selector(AddlAttri:and:)]) {
        [self.delagate AddlAttri:@"" and:@""];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark -  添加属性
-(void)AddAttriAction{
    
}
#pragma mark -  删除属性
-(void)DeleteAttriAction{
    
}
#pragma mark - 懒加载
-(UITableView *)AttriTableview{
    if (!_AttriTableview) {
        _AttriTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH-44) style:UITableViewStyleGrouped];
        [_AttriTableview registerClass:[AttriCell class] forCellReuseIdentifier:@"AttriCell"];
        _AttriTableview.delegate =  self;
        _AttriTableview.dataSource = self;
        _AttriTableview.backgroundColor = [UIColor clearColor];
        _AttriTableview.separatorStyle = UITableViewCellAccessoryNone;
    }
    return _AttriTableview;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
