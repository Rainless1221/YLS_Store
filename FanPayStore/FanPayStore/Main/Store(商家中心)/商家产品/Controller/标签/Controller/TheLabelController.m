//
//  TheLabelController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/13.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
// 商品标签

#import "TheLabelController.h"
#import "LabelViewController.h"
#import "labelView.h"
#import "RTDragCellTableView.h"

@interface TheLabelController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,ThelabelcellDelegate,EditDelegate,UITextFieldDelegate,RTDragCellTableViewDataSource,RTDragCellTableViewDelegate>
/* 基视图 */
@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)UIView * ViewOne;
@property (strong,nonatomic)UIView * ViewTwo;
/* 标签九宫格 */
@property (strong,nonatomic)UICollectionView * LableCollectionView;
/* 标签列表 */
@property (strong,nonatomic)RTDragCellTableView * LableTableview;
@property (strong,nonatomic)NSMutableArray * LabelData;
/* 添加标签 */
@property (strong,nonatomic)UITextField * theLabel;
@property (strong,nonatomic)NSString * LabelStr;
@property (strong,nonatomic)NSString * category_id;

@property (strong, nonatomic) labelView    *tagList;
/** 最大字数 */
@property (nonatomic,assign) NSInteger maxLength;
/** 字数限制文本 */
@property (nonatomic, strong) UILabel * lengthLabel;
//拖动编辑按钮
@property (strong,nonatomic)UIButton * TuoBtn;
@end

@implementation TheLabelController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"商品标签";
    self.view.backgroundColor = MainbackgroundColor;
    [self merchant_center];
    /*导航栏*/
    [self setupNav];
    /*UI*/
    [self createUI];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]list_goods_category:model.merchant_id andstore_id:model.store_id  Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
           
            NSDictionary *DIC=resDic[@"data"][@"goods_category"];
            //category_id
            //category_name
            [self.LabelData removeAllObjects];

            for (NSDictionary *dict in DIC) {
                [self.LabelData addObject:dict];

            }

            [self.tagList removeFromSuperview];
            [self.ViewOne removeFromSuperview];
            [self.ViewTwo removeFromSuperview];
            [self.theLabel removeFromSuperview];
            [self.LableTableview removeFromSuperview];
            
            [self createUI];

//            [self.LableTableview reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.ViewOne];
    [self.SJScrollView addSubview:self.ViewTwo];
#pragma mark - 添加标签名称
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 50, self.ViewOne.width-20, 1)];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.ViewOne addSubview:line];
    
    /* 添加button */
    UIButton *addition = [UIButton buttonWithType:UIButtonTypeCustom];
    addition.frame = CGRectMake(self.ViewOne.width-70, 10, 60, 30);
    [addition setTitle:@"添加" forState:UIControlStateNormal];
    [addition setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [addition.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [addition setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    addition.layer.cornerRadius = 2;
    [addition addTarget:self action:@selector(addLabelAction) forControlEvents:UIControlEventTouchUpInside];
    [self.ViewOne addSubview:addition];
    
    self.theLabel = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, 120, 50)];
    self.theLabel.placeholder = @"添加标签名称";
    self.theLabel.delegate = self;
    self.theLabel.font = [UIFont systemFontOfSize:15];
    [self.ViewOne addSubview:self.theLabel];
    [self.theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(10);
        make.height.mas_offset(50);
        make.right.equalTo(addition.mas_left).offset(-35);
    }];
    self.maxLength = 10;
    [self.ViewOne addSubview:self.lengthLabel];
    [self.lengthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.width.mas_offset(50);
        make.height.mas_offset(50);
        make.right.equalTo(addition.mas_left).offset(-5);
    }];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:)
                                                name:@"UITextFieldTextDidChangeNotification" object:self.theLabel];
    
    
    /*已添加标签*/
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, line.bottom+15, 150, 14)];
    label1.text = @"已添加标签";
    label1.textColor= UIColorFromRGB(0x222222);
    label1.font = [UIFont systemFontOfSize:15];
    [self.ViewOne addSubview:label1];
    
    /*可从已添加的标签中选择产品符合的标签。*/
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.bottom+10, self.ViewOne.width-20, 14)];
    label2.text = @"可从已添加的标签中选择产品符合的标签。";
    label2.textColor= UIColorFromRGB(0xCCCCCC);
    label2.font = [UIFont systemFontOfSize:13];
    [self.ViewOne addSubview:label2];
     //暂无任何标签~
    UILabel *label_ZW = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.bottom+15, 150, 14)];
    label_ZW.text = @"暂无任何标签~";
    label_ZW.textColor= UIColorFromRGB(0x222222);
    label_ZW.font = [UIFont systemFontOfSize:15];
    [self.ViewOne addSubview:label_ZW];
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"主食",@"推荐菜",@"汤类",@"锅煲",@"特色小食",@"时蔬",@"酒水",nil];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *Dict in self.LabelData) {
        [array addObject:Dict[@"category_name"]];
    }
    self.tagList = [[labelView alloc]initWithFrame:CGRectMake(0, label2.bottom+15, self.ViewOne.width-10, 10)];
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
    self.tagList.backgroundColor = UIColorFromRGB(0xFFFFFF);

    [self.ViewOne addSubview:self.tagList];
    
    self.ViewOne.height  = self.tagList.height + (self.LabelData.count>0 ? 160:180);
    self.ViewTwo.mj_y = self.ViewOne.bottom + 15;
    self.ViewTwo.height  = 110 + self.LabelData.count*52;
    self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.ViewTwo.height +self.ViewOne.height + 120);
    
    
    
#pragma mark - 标签管理
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 19, 150, 14)];
    label3.text = @"标签管理";
    label3.textColor= UIColorFromRGB(0x222222);
    label3.font = [UIFont systemFontOfSize:15];
    [self.ViewTwo addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, label3.bottom+10, 250, 33)];
    label4.text = @"可以修改或者删除现有的标签。点“编辑”，可以拖拽调整标签顺序。";
    label4.numberOfLines = 0;
    label4.textColor= UIColorFromRGB(0xCCCCCC);
    label4.font = [UIFont systemFontOfSize:13];
    [self.ViewTwo addSubview:label4];
    //暂无任何标签~
    UILabel *label_ZW1 = [[UILabel alloc]initWithFrame:CGRectMake(10, label4.bottom+15, 150, 14)];
    label_ZW1.text = @"暂无任何标签~";
    label_ZW1.textColor= UIColorFromRGB(0x222222);
    label_ZW1.font = [UIFont systemFontOfSize:15];
    [self.ViewTwo addSubview:label_ZW1];
    
   
    [self.ViewTwo addSubview:self.TuoBtn];
    [self.TuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(19);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(60, 32));
    }];
    
    
    /* 标签列表 */
    self.LableTableview = [[RTDragCellTableView alloc]init];//[[RTDragCellTableView alloc]initWithFrame:CGRectMake(0, 70, ScreenW-30, 400) style:UITableViewStyleGrouped];
    self.LableTableview.delegate = self;
    self.LableTableview.dataSource = self;
    self.LableTableview.allowsSelection = NO;
    self.LableTableview.backgroundColor = [UIColor whiteColor];
    [self.LableTableview registerNib:[UINib nibWithNibName:@"ThelabelCell" bundle:nil] forCellReuseIdentifier:@"ThelabelCell"];
    self.LableTableview.separatorStyle = NO;
    self.LableTableview.scrollEnabled = NO;
    self.LableTableview.defaultNoDataText = @"";
    self.LableTableview.defaultNoDataImage = nil;
    self.LableTableview.backgroundView = [UIView new];
    if (self.LabelData.count >0) {
        [self.ViewTwo addSubview:self.LableTableview];
        [self.LableTableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(label4.mas_bottom).offset(0);
            make.left.right.bottom.mas_offset(0);
        }];
    }
    
    
    self.SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, self.ViewTwo.height +self.ViewOne.height + 120);

    
    [self.tagList clickTag:self.tagList.LabelButton];

}
#pragma mark - 导航栏 
-(void)setupNav{
    UIButton *leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 50, 28)];
    [leftbutton setBackgroundColor:UIColorFromRGB(0xF7AE2B)];
    [leftbutton setTitle:@"确定" forState:UIControlStateNormal];
    [leftbutton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [leftbutton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    leftbutton.layer.cornerRadius = 14;
    [leftbutton addTarget:self action:@selector(AddlabelAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem = [[UIBarButtonItem alloc]initWithCustomView:leftbutton];self.navigationItem.rightBarButtonItem = rightitem;
    
}
#pragma mark - 确定
-(void)AddlabelAction{
    if ([[MethodCommon judgeStringIsNull:self.LabelStr] isEqualToString:@""]) {
        return;
    }
    if (self.delagate && [self.delagate respondsToSelector:@selector(Addlabel:and:)]) {
        [self.delagate Addlabel:self.LabelStr and:self.category_id];
    }
    [self.navigationController popViewControllerAnimated:YES];

}
#pragma mark - 选中标签
-(void)Addlabelcell:(NSString *)lableString and:(NSInteger)integer{
    NSLog(@" 选择的ID ：%@",self.LabelData[integer][@"category_id"]);
    self.LabelStr = lableString;
    self.category_id = self.LabelData[integer][@"category_id"];
    NSLog(@"%f",self.tagList.height)
    
    self.ViewOne.height  = self.tagList.height + 120;
    self.ViewTwo.mj_y = self.ViewOne.bottom + 15;
}
#pragma mark - 添加标签
-(void)addLabelAction
{
    if (self.theLabel.text==nil||self.theLabel.text.length==0) {
        
        return;
    }
    [self.tagList addTag:self.theLabel.text];
    self.ViewOne.height  = self.tagList.height + 120;
    self.ViewTwo.mj_y = self.ViewOne.bottom + 15;
    
    [self add_goodLabel:self.theLabel.text];
}
-(void)add_goodLabel:(NSString *)category_name{
    
    [MBProgressHUD MBProgress:@"数据加载中..."];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]add_goods_category:model.merchant_id andstore_id:model.store_id andcategory_name:category_name Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {

            [self merchant_center];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];

    }];
    

}
#pragma mark - 排序标签
-(void)TuoAction:(UIButton *)sender{
    
    if (sender.selected == YES) {
        [MBProgressHUD MBProgress:@"数据加载中..."];
        UserModel *model = [UserModel getUseData];
        //sort_goods_category
        NSMutableArray *arr = [NSMutableArray array];
        NSMutableArray *sortarr = [NSMutableArray array];
        NSMutableArray *Array = [NSMutableArray array];
        for (int i = 0; i<self.LabelData.count; i++) {
            NSString *ID= [NSString stringWithFormat:@"%@",self.LabelData[i][@"category_id"]];
            NSString *sort= [NSString stringWithFormat:@"%d",i];
   
//            NSDictionary *ARRdict =@{@"category_id":ID,@"sort":sort};
//            [Array addObject:ARRdict];
//           NSString*obje = [self jsonStringWithDict:ARRdict];
//            NSDictionary *dict = [self dictionaryWithJsonString:[NSString stringWithFormat:@"category_id:%@,sort:%@",ID,sort]];
            [arr addObject:ID];
            [sortarr addObject:sort];
        }
        
        NSString *string = [arr componentsJoinedByString:@","];
        NSString *sortstring = [sortarr componentsJoinedByString:@","];

        
        NSDictionary *Dict = @{
//                               @"category_sort":@"",
                                @"type":@"2",
                                @"category_id":string,
                                @"sort":sortstring,
                                   };
        
        [[FBHAppViewModel shareViewModel]sort_goods_category:model.merchant_id andstore_id:model.store_id andcategory_sort:Dict Success:^(NSDictionary *resDic) {
            if ([resDic[@"status"] integerValue]==1) {
                
                self.TuoBtn.selected = NO;
                self.TuoBtn.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
                [self merchant_center];
            }else{
                [SVProgressHUD setMinimumDismissTimeInterval:2];
                [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
            }
            [MBProgressHUD hideHUD];

        } andfailure:^{
            [MBProgressHUD hideHUD];

        }];
        
    }else{
        sender.selected = YES;
        sender.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;
    }
    
}
- (NSString *)jsonStringWithDict:(NSDictionary *)dict {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    return mutStr;
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString
{
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
}
-(void)EditDele{
    
    [self merchant_center];
}
#pragma mark -------------------- UITextFieldDelegate --------------------

#pragma mark - Notification Method
-(void)textFieldEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    NSString *toBeString = textField.text;
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > 9)
            {
                textField.text = [toBeString substringToIndex:9];
            }
        }
        
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > 9)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:9];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:9];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, 9)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
    
    self.lengthLabel.text = [NSString stringWithFormat:@"%zd/%zd",toBeString.length,self.maxLength];
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.LabelData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ThelabelCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThelabelCell" forIndexPath:indexPath];
    
    cell.Data = self.LabelData[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 52;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LabelViewController *VC = [LabelViewController new];
    VC.labelStr = self.LabelData[indexPath.row][@"category_name"];
    VC.category_id = self.LabelData[indexPath.row][@"category_id"];
    VC.delagate = self;

    [self.navigationController pushViewController:VC animated:NO];
}
- (NSArray *)originalArrayDataForTableView:(RTDragCellTableView *)tableView{
    return self.LabelData;
}
-(void)Gesture:(NSIndexPath*)index{
    LabelViewController *VC = [LabelViewController new];
    VC.labelStr = self.LabelData[index.row][@"category_name"];
    VC.category_id = self.LabelData[index.row][@"category_id"];
    VC.delagate = self;
    [self.navigationController pushViewController:VC animated:NO];

}
/**将修改重排后的数组传入，以便外部更新数据源*/
- (void)tableView:(RTDragCellTableView *)tableView newArrayDataForDataSource:(NSArray *)newArray{
    [self.LabelData removeAllObjects];
    for (NSDictionary *dict in newArray) {
        [self.LabelData addObject:dict];
        self.TuoBtn.selected = YES;
        self.TuoBtn.layer.borderColor = UIColorFromRGB(0xF7AE2B).CGColor;

    }

}
#pragma mark - 懒加载
-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _SJScrollView.backgroundColor = MainbackgroundColor;
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 780);
    }
    return _SJScrollView;
}
-(UIView *)ViewOne{
    if (!_ViewOne) {
        _ViewOne = [[UIView alloc]initWithFrame:CGRectMake(15, 15, ScreenW-30, 160)];
        _ViewOne.backgroundColor = [UIColor whiteColor];
        _ViewOne.layer.cornerRadius = 5;
    }
    return _ViewOne;
}
-(UIView *)ViewTwo{
    if (!_ViewTwo) {
        _ViewTwo = [[UIView alloc]initWithFrame:CGRectMake(15, self.ViewOne.bottom+15, ScreenW-30, 119)];
        _ViewTwo.backgroundColor = [UIColor whiteColor];
        _ViewTwo.layer.cornerRadius = 5;
    }
    return _ViewTwo;
}
- (UILabel *) lengthLabel{
    if(!_lengthLabel){
        _lengthLabel = [UILabel new];
        _lengthLabel.backgroundColor = [UIColor clearColor];
        _lengthLabel.textColor = UIColorFromRGB(0xD1D1D1);
        _lengthLabel.textAlignment = NSTextAlignmentRight;
        _lengthLabel.font = [UIFont systemFontOfSize:17];
        _lengthLabel.text = [[NSString alloc]initWithFormat:@"0/%ld",(long)self.maxLength];
    }
    return _lengthLabel;
}
//-(UITableView *)LableTableview{
//    if (!_LableTableview) {
//        _LableTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 70, ScreenW-30, 400) style:UITableViewStyleGrouped];
//        _LableTableview.delegate = self;
//        _LableTableview.dataSource = self;
//        _LableTableview.backgroundColor = [UIColor clearColor];
//        [_LableTableview registerNib:[UINib nibWithNibName:@"ThelabelCell" bundle:nil] forCellReuseIdentifier:@"ThelabelCell"];
//        _LableTableview.separatorStyle = NO;
//        _LableTableview.scrollEnabled = NO;
//    }
//    return _LableTableview;
//}
-(NSMutableArray *)LabelData{
    if (!_LabelData) {
        _LabelData = [NSMutableArray array];
    }
    return _LabelData;
}
-(UIButton *)TuoBtn{
    if (!_TuoBtn) {
        _TuoBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_TuoBtn setTitle:@"编辑" forState:UIControlStateNormal];
        [_TuoBtn setTitle:@"确定" forState:UIControlStateSelected];
        [_TuoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_TuoBtn setTitleColor:UIColorFromRGB(0xF7AE2B)  forState:UIControlStateSelected];
        
        _TuoBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        _TuoBtn.layer.borderWidth = 1;
        _TuoBtn.layer.borderColor = UIColorFromRGB(0xDCDCDC).CGColor;
        _TuoBtn.layer.cornerRadius = 5;
        [_TuoBtn addTarget:self action:@selector(TuoAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _TuoBtn;
}
@end
