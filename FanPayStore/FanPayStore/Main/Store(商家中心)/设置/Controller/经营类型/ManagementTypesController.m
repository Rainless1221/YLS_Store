//
//  ManagementTypesController.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/9.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "ManagementTypesController.h"
#import "secondaryViewController.h"

@interface ManagementTypesController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * TypesTableView;
@property (strong,nonatomic)NSMutableArray * TypesData;
@end

@implementation ManagementTypesController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"经营类型";
    [self merchant_center];
}
#pragma mark - 请求
-(void)merchant_center{
    UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel]get_store_category_info:model.merchant_id Success:^(NSDictionary *resDic) {
        if ([resDic[@"status"] integerValue]==1) {
            NSDictionary *DIC=resDic[@"data"];
            [self.TypesData removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_category_info"]) {
                [self.TypesData addObject:dict];
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

#pragma mark - UI
-(void)createUI{
    
    [self.view addSubview:self.TypesTableView];
    [self.TypesTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(0);
        make.left.mas_offset(autoScaleW(15));
        make.right.mas_offset(-autoScaleW(15));
        make.bottom.mas_offset(0);
    }];
    
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.TypesData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if (!cell) {
       cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"];
    }

    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);

    /*类型名称*/
    UILabel *category_name = [[UILabel alloc]initWithFrame:CGRectMake(35, 0, 150, 50)];
    category_name.textColor = UIColorFromRGB(0x222222);
    category_name.font = [UIFont systemFontOfSize:15];
    category_name.text = [NSString stringWithFormat:@"%@",self.TypesData[indexPath.row][@"category_name"]];
    [cell addSubview:category_name];
    
    /* icon */
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 6, 10)];
    icon.image = [UIImage imageNamed:@"input_arrow_right_deepgray"];
    [cell addSubview:icon];
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.right.mas_offset(-10);
        make.size.mas_offset(CGSizeMake(6, 10));
    }];
    /*line*/
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 49, cell.width-50, 1)];
    line.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    [cell addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(10);
        make.right.mas_offset(-10);
        make.bottom.mas_offset(-1);
        make.height.mas_offset(1);
    }];
    
    /*category_pic*/
    UIImageView *category_pic = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
    [cell addSubview:category_pic];
    [category_pic mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_offset(0);
        make.left.mas_offset(10);
        make.size.mas_offset(CGSizeMake(16, 16));
    }];
    NSString *url = [NSString stringWithFormat:@"%@",self.TypesData[indexPath.row][@"category_pic"]];
    NSString * imageUrl = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [category_pic sd_setImageWithURL:[NSURL URLWithString:imageUrl] placeholderImage:photoImage];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    secondaryViewController *VC = [secondaryViewController new];
    VC.categoryId = [NSString stringWithFormat:@"%@",self.TypesData[indexPath.row][@"category_id"]];
    //category_name
    VC.category_name = [NSString stringWithFormat:@"%@",self.TypesData[indexPath.row][@"category_name"]];
    [self.navigationController pushViewController:VC animated:NO];

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
        [_TypesTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
        
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
