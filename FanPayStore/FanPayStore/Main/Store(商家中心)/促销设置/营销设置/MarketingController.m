//
//  MarketingController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/6/4.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MarketingController.h"
#import "FBHPreferlistController.h"

@interface MarketingController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView * markeTableView;
@property (strong,nonatomic)NSMutableArray * Data;
@end

@implementation MarketingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"营销设置";

    NSArray *marArr = @[
//                        @{@"icon":@"icn_acti_fanbei",
//                          @"name":@"翻呗活动",
//                          @"text":@"翻呗活动是指商家通过一鹿省平台创建的在线优惠活动。"
//                          
//                          },
                        @{@"icon":@"icn_acti_tehui",
                          @"name":@"特惠活动",
                          @"text":@"商家用户可以给商品设置折扣价格，创建店铺的折扣活动。"

                          },
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
    }
    [self createUI];
    
    
    
}
#pragma mark - UI
-(void)createUI{
    [self.view addSubview:self.markeTableView];
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.Data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MarkeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarkeViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xF6F6F6);
    cell.Data = self.Data[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 115;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 180;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 180)];
    UIImageView *footerImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 40, 100, 100)];
    footerImage.image  = [UIImage imageNamed:@"icn_more_activity"];
    [footer addSubview:footerImage];
    [footerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_offset(0);
        make.size.mas_offset(CGSizeMake(100, 100));
        make.top.mas_offset(40);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0,footerImage.bottom+10,ScreenW,13);
    label.numberOfLines = 0;
    label.textAlignment = 1;
    label.font = [UIFont systemFontOfSize:13];
    label.text = @"更多营销活动，敬请期待~";
    label.textColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
    [footer addSubview:label];
    
    return footer;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    if (indexPath.row ==0) {
//        [self.navigationController pushViewController:[FBHSZViewController new] animated:NO];
//
//    }else{
        [self.navigationController pushViewController:[FBHPreferlistController new] animated:NO];

//    }
}

#pragma mark - 懒加载
-(UITableView *)markeTableView{
    if (!_markeTableView) {
        _markeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStylePlain];
        _markeTableView.delegate = self;
        _markeTableView.dataSource = self;
        _markeTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);

        [_markeTableView registerClass:[MarkeViewCell class] forCellReuseIdentifier:@"MarkeViewCell"];
        _markeTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _markeTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}
@end
