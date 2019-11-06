//
//  secondaryViewController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "secondaryViewController.h"
#import "SecondaryCell.h"

@interface secondaryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * TypesTableView;
@property (strong,nonatomic)NSMutableArray * TypesData;
@property (strong,nonatomic)NSString * sec_category_id;
@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag

@end

@implementation secondaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.category_name;

    [self createUI];
    [self merchant_category:self.categoryId];
}
#pragma mark - UI
-(void)createUI{
    /** 确定按钮 **/
    UIButton *Button = [UIButton buttonWithType:UIButtonTypeCustom];
    Button.backgroundColor = UIColorFromRGB(0xF7AE2B);
    [Button setTitle:@"确定" forState:UIControlStateNormal];
    [Button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [Button.titleLabel setFont:[UIFont systemFontOfSize:16]];
    Button.layer.cornerRadius = 10;
    
    [Button addTarget:self action:@selector(typeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:Button];
    [Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_offset(-10);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.height.mas_offset(44);
    }];
    
    [self.view addSubview:self.TypesTableView];
    [self.TypesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.equalTo(Button.mas_top).offset(-13);
    }];
    
    
}
#pragma mark - 确定选择
-(void)typeAction{
    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[SetupViewController class]]) {
            UserModel *model = [UserModel getUseData];
            
            NSDictionary *dict = @{
                                   @"category_id":[NSString stringWithFormat:@"%@",self.categoryId],
                                   @"sec_category_id":[NSString stringWithFormat:@"%@",self.sec_category_id]
                                   };
            [[FBHAppViewModel shareViewModel]insert_store_application:model.merchant_id andMerchantDict:dict Success:^(NSDictionary *resDic) {
                if ([resDic[@"status"] integerValue] == 1) {
                    
                    
                    [self.navigationController popToViewController:controller animated:YES];

                    
                    //            [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [SVProgressHUD setMinimumDismissTimeInterval:2];
                    [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
                }
            } andfailure:^{
                
            }];
            
            
        }else if ([controller isKindOfClass:[StoreNameViewController class]]){
            
            NSDictionary *dict = @{
                                   @"categoryId":[NSString stringWithFormat:@"%@",self.categoryId],
                                   @"sec_category_id":[NSString stringWithFormat:@"%@",self.TypesData[self.btnTag][@"category_id"]],
                                   @"category_pic":[NSString stringWithFormat:@"%@",self.TypesData[self.btnTag][@"category_pic"]],
                                   @"category_name":[NSString stringWithFormat:@"%@",self.TypesData[self.btnTag][@"category_name"]],
                                   };
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"store_category" object:dict];

            [self.navigationController popToViewController:controller animated:YES];
            
        }
    }

    
    
}
- (void)merchant_category:(NSString *)categoryId{
    
    [MBProgressHUD MBProgress:@"数据加载中.."];
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel] get_sec_store_category_info:model.merchant_id andcategory_id:categoryId Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];
            
            for (NSString *key in DIC) {
                NSDictionary *dict =  DIC[key];
                for (NSDictionary *Dic in dict) {
                    [self.TypesData addObject:Dic];
                }
                
            }
            [self.TypesTableView reloadData];
            
        }else {
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
    
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TypesData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SecondaryCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
        cell = [[SecondaryCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"SecondaryCell"];
    }
    cell.icon.tag = indexPath.row;
    cell.Data = self.TypesData[indexPath.row];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    
    
    if (cell.icon.tag == self.btnTag) {
        cell.isSelect = YES;
        cell.icon.selected =YES;
    }else{
        cell.isSelect = NO;
        cell.icon.selected = NO;
    }
    
   __weak SecondaryCell *weakCell = cell;
    [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            weakCell.icon.selected = YES;
            self.btnTag = btnTag;
            NSLog(@"$$$$$$%ld",(long)btnTag);
            [tableView reloadData];
            
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.TypesData[btnTag][@"category_id"]];
            if ([cate isEqualToString:@""]) {
                return ;
            }
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            weakCell.icon.selected = NO;
            self.btnTag = btnTag;
            [tableView reloadData];
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.TypesData[btnTag][@"category_id"]];
            if ([cate isEqualToString:@""]) {
                return ;
            }
            
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
    self.sec_category_id = self.TypesData[indexPath.row][@"category_id"];

    
}

#pragma mark - 懒加载
-(UITableView *)TypesTableView{
    if (!_TypesTableView) {
        _TypesTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _TypesTableView.backgroundColor = [UIColor clearColor];
        _TypesTableView.layer.cornerRadius = 5;
        _TypesTableView.dataSource = self;
        _TypesTableView.delegate = self;
        _TypesTableView.separatorStyle = NO;
        _TypesTableView.showsVerticalScrollIndicator = NO;
        //        [_TypesTableView registerNib:[UINib nibWithNibName:@"UITableViewCell" bundle:nil] forCellReuseIdentifier:@"UITableViewCell"];
        [_TypesTableView registerClass:[SecondaryCell class] forCellReuseIdentifier:@"SecondaryCell"];
        
        _TypesTableView.defaultNoDataText = @"";
        _TypesTableView.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
        _TypesTableView.backgroundView = [UIView new];
        _TypesTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
            //        [self merchant_center:1];
        };
        
    }
    return _TypesTableView;
}
-(NSMutableArray *)TypesData{
    if (!_TypesData) {
        _TypesData = [NSMutableArray array];
    }
    return _TypesData;
}
@end
