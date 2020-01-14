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

@interface YLSCommodityAttriController ()<UITableViewDelegate,UITableViewDataSource,AttriDataDelegate,UINavigationBarDelegate>
@property (strong,nonatomic)UITableView * AttriTableview;
/** 是否要保存数据 **/
@property (strong,nonatomic)NSMutableArray * SaveData;
@end
//@"不辣,微辣,二级辣,中辣,大辣,变态辣"
@implementation YLSCommodityAttriController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品属性";

//    if (self.Data.count==0) {
//        NSArray *marArr = @[@{@"attr_name":@"",
//                              @"attr_value":@""
//                              },
//                            ];
//
//        for (NSDictionary *dict in marArr) {
//            [self.Data addObject:dict];
//
//        }
//    }
    
    for (NSDictionary *dict in self.Data) {
        [self.SaveData addObject:dict];
        
    }
    
    /*导航栏*/
    [self setupNav];
    /*UI*/
    [self createUI];
   
}

#pragma mark - 导航栏
-(void)setupNav{
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    [Button setTitle:@"保存" forState:UIControlStateNormal];
    Button.tag = 1;
    [Button setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    Button.titleLabel.font = [UIFont systemFontOfSize:14];
    [Button addTarget:self action:@selector(SaveAction1:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *SaveButton =[[UIBarButtonItem alloc]initWithCustomView:Button];
    // [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(SaveAction)];
    
    self.navigationItem.rightBarButtonItem = SaveButton;
    
    
    UIButton *Button1 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [Button1 setTitle:@"保存" forState:UIControlStateNormal];
    Button1.tag = 2;
    [Button1 setImage:[UIImage imageNamed:@"icn_nav_back_darkgray_normal"] forState:UIControlStateNormal];
    [Button1 setTitleColor:UIColorFromRGB(0xF7AE2B) forState:UIControlStateNormal];
    Button1.titleLabel.font = [UIFont systemFontOfSize:14];
    [Button1 addTarget:self action:@selector(SaveAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *SaveButton1 =[[UIBarButtonItem alloc]initWithCustomView:Button1];
    // [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(SaveAction)];
    
    self.navigationItem.leftBarButtonItem = SaveButton1;
    
}
-(void)SaveAction:(UIButton *)Btn{
    
     [self.view endEditing:YES];
    NSMutableArray *Array = [NSMutableArray array];
    for (NSDictionary*dict in self.Data) {
        if ([dict[@"attr_value"] isEqualToString:@""] || [dict[@"attr_name"] isEqualToString:@""]) {
            
        }else{
            [Array addObject:dict];
        }
        
    }
    if (Array.count == 0) {
        if (self.delagate && [self.delagate respondsToSelector:@selector(AddlAttri:and:and:)]) {
            [self.delagate AddlAttri:@"" and:@"" and:Array];
        }
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }

    
    
    NSString* text = [NSString new];
    NSString* text1 = [NSString new];
    if (self.SaveData.count == 0) {
        text = @"";
    }else{
        NSError *error = nil;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self.SaveData
                                                           options:0
                                                             error:&error];
        
        if ([jsonData length] && error == nil){
            text = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        }
        
        NSError *error1 = nil;
        NSData *jsonData1 = [NSJSONSerialization dataWithJSONObject:self.Data
                                                           options:0
                                                             error:&error1];
        
        if ([jsonData1 length] && error1 == nil){
            text1= [[NSString alloc] initWithData:jsonData1 encoding:NSUTF8StringEncoding];
        }
        
        
    }
    
    
    /*是否一样的值*/
    if ([text1 isEqualToString:text]) {
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    
    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
    samView.deleteLabel.text = @"确认保存";
    NSString *card_number = [NSString stringWithFormat:@"您添加的商品属性还未保存，是否确认不保存直 接退出。"];
    samView.deleteText.text = card_number;
     [samView.deleteButton setTitle:@"保存退出" forState:UIControlStateNormal];
    [samView.cancel setTitle:@"退出" forState:UIControlStateNormal];
    samView.DeleteCardBlock = ^{
       
        if (self.delagate && [self.delagate respondsToSelector:@selector(AddlAttri:and:and:)]) {
            [self.delagate AddlAttri:@"" and:@"" and:Array];
        }
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    samView.CardBlock = ^{
        [self.navigationController popViewControllerAnimated:YES];
    };
    
    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
}
-(void)SaveAction1:(UIButton *)Btn{
    
    [self.view endEditing:YES];
    NSMutableArray *Array = [NSMutableArray array];
    for (NSDictionary*dict in self.Data) {
        if ([dict[@"attr_value"] isEqualToString:@""] || [dict[@"attr_name"] isEqualToString:@""]) {
            
        }else{
            [Array addObject:dict];
        }
        
    }

    if (self.delagate && [self.delagate respondsToSelector:@selector(AddlAttri:and:and:)]) {
        [self.delagate AddlAttri:@"" and:@"" and:Array];
    }
    [self.navigationController popViewControllerAnimated:YES];
    
//    DeleteView *samView = [[DeleteView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//    samView.deleteIcon.image = [UIImage imageNamed:@"icn_alert"];
//    samView.deleteLabel.text = @"确认保存";
//    NSString *card_number = [NSString stringWithFormat:@"您添加的商品属性还未保存，是否确认不保存直 接退出。"];
//    samView.deleteText.text = card_number;
//    [samView.deleteButton setTitle:@"保存退出" forState:UIControlStateNormal];
//    [samView.cancel setTitle:@"退出" forState:UIControlStateNormal];
//    samView.DeleteCardBlock = ^{
//
//        if (self.delagate && [self.delagate respondsToSelector:@selector(AddlAttri:and:and:)]) {
//            [self.delagate AddlAttri:@"" and:@"" and:Array];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//
//    samView.CardBlock = ^{
//        [self.navigationController popViewControllerAnimated:YES];
//    };
//
//    [[UIApplication sharedApplication].keyWindow addSubview:samView];
    
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
    return self.Data.count;
//    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    AttriCell * cell= [tableView dequeueReusableCellWithIdentifier:@"AttriCell"];
    cell=[[AttriCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AttriCell"];
    cell.delagate = self;
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.SuXin.text = [NSString stringWithFormat:@"属性%ld",indexPath.row+1];
    cell.Data = self.Data[indexPath.row];
    
    cell.AttriDataBlock = ^(NSString * _Nonnull attr_name, NSString * _Nonnull attr_value) {
        [self.Data removeObjectAtIndex:indexPath.row];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:attr_name forKey:@"attr_name"];
        [dict setObject:attr_value forKey:@"attr_value"];
        
        [self.Data insertObject:dict atIndex:indexPath.row];
        [self.AttriTableview reloadData];
    };
    
    cell.DeleteAttriBlock = ^{
         [self.Data removeObjectAtIndex:indexPath.row];
         [self.AttriTableview reloadData];
    };
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
   
}
#pragma mark -  添加属性
-(void)AddAttriAction{
    NSArray *marArr = @[@{@"attr_name":@"",
                          @"attr_value":@""
                          },
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
        
    }
    [self.AttriTableview reloadData];
}
#pragma mark -  删除属性
-(void)DeleteAttriAction{
    
}
#pragma mark -传过来的数据
-(void)AttriData:(NSString *)attr_name and:(NSString *)attr_value{
    
   
    
    
}
-(void)setData:(NSMutableArray *)Data{
    _Data = [NSMutableArray array];
    if (Data.count==0) {
        NSArray *marArr = @[@{@"attr_name":@"",
                              @"attr_value":@""
                              },
                            ];
        
        for (NSDictionary *dict in marArr) {
            [self.Data addObject:dict];
            
        }
    }else{
        for (NSDictionary *dict in Data) {
            [self.Data addObject:dict];
        }
    }
    
    
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
//-(NSMutableArray *)Data{
//    if (!_Data) {
//        _Data = [NSMutableArray array];
//    }
//    return _Data;
//}
-(NSMutableArray *)SaveData{
    if (!_SaveData) {
        _SaveData = [NSMutableArray array];
    }
    return _SaveData;
}
@end
