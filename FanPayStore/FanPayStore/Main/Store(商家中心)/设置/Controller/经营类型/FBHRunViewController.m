//
//  FBHRunViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/6.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "FBHRunViewController.h"

@interface FBHRunViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * RunTableView;
/**  **/
@property (strong,nonatomic)NSMutableArray * Data;
/** 默认选中的Tag **/
@property (nonatomic, assign) NSInteger btnTag;
@property (assign,nonatomic)NSInteger iscate;

@end

@implementation FBHRunViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.iscate = 1;

}
#pragma mark - 请求
-(void)merchant_center{
    UserModel *model = [UserModel getUseData];

    [[FBHAppViewModel shareViewModel]get_store_category_info:model.merchant_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            [self.Data removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_category_info"]) {
                [self.Data addObject:dict];
            }
            /**
             * UI
             */
            [self createUI];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
    } andfailure:^{
        
    }];
}
- (void)merchant_category:(NSString *)categoryId{
    if (self.iscate > 2) {
        return ;
    }
    [MBProgressHUD MBProgress:@""];
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel] get_sec_store_category_info:model.merchant_id andcategory_id:categoryId Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            
            
            [self.Data removeAllObjects];
            
            for (NSString *key in DIC) {
                
                NSDictionary *dict =  DIC[key];
                for (NSDictionary *Dic in dict) {
                    [self.Data addObject:Dic];
                }
                
                
                
            }
            
            [self.RunTableView reloadData];
            
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"经营类型";
    [self merchant_center];
}
#pragma mark - UI
-(void)createUI{
    
    NSInteger i = 5;
    if (self.Data.count>7) {
        i = 7;
    }else{
        i = self.Data.count;
    }
    /** 列表 **/
    [self.view addSubview:self.RunTableView];
    
    [self.RunTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(15);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(50*i);
    }];

    /** 确定按钮 **/
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.backgroundColor = UIColorFromRGB(0x3D8AFF);
    [Button setTitle:@"确定" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    Button.layer.cornerRadius = 10;

    [Button addTarget:self action:@selector(typeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.RunTableView.mas_bottom).offset(20);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
    }];
    
}
#pragma mark - 确定选择
-(void)typeAction{
//    if (self.fbhtypeBlock) {
//        self.fbhtypeBlock(self.categoryData[self.btnTag][@"category_id"],self.categoryData[self.btnTag][@"category_name"],self.categoryData[self.btnTag][@"category_pic"]);
//    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RunTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RunTypeTableViewCell" forIndexPath:indexPath];
    cell.selectBtn.tag = indexPath.row;
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.Data = self.Data[indexPath.row];
    
    if (cell.selectBtn.tag == self.btnTag) {
        cell.isSelect = YES;
        cell.selectBtn.selected =YES;
    }else{
        cell.isSelect = NO;
        cell.selectBtn.selected = NO;
    }
    __weak RunTypeTableViewCell *weakCell = cell;
    [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            weakCell.selectBtn.selected =YES;
            self.btnTag = btnTag;
            NSLog(@"$$$$$$%ld",(long)btnTag);
            [tableView reloadData];
            self.iscate ++;
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.Data[btnTag][@"category_id"]];
            [self merchant_category:cate];
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            weakCell.selectBtn.selected = NO;
            self.btnTag = btnTag;
            [tableView reloadData];
            self.iscate ++;
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.Data[btnTag][@"category_id"]];
            [self merchant_category:cate];
        }
    }];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - GET
-(UITableView *)RunTableView{
    if (!_RunTableView) {
        _RunTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _RunTableView.backgroundColor = [UIColor whiteColor];
        _RunTableView.layer.cornerRadius = 5;
        _RunTableView.dataSource = self;
        _RunTableView.delegate = self;
        [_RunTableView registerNib:[UINib nibWithNibName:@"RunTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"RunTypeTableViewCell"];
        
        _RunTableView.defaultNoDataText = @"";
        _RunTableView.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
        _RunTableView.backgroundView = [UIView new];
        _RunTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
            //        [self merchant_center:1];
        };
        
    }
    return _RunTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
