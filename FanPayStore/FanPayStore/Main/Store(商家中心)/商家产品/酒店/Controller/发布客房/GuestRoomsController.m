//
//  GuestRoomsController.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/12.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "GuestRoomsController.h"
#import "RoomsCell.h"
#import "RoomsView.h"
#import "RoomsViewone.h"
#import "RoomsViewtwo.h"
#import "RoomsViewImage.h"
#import "RoomsController.h"

@interface GuestRoomsController ()<UITableViewDelegate,UITableViewDataSource,RoomsDelegate,RoomsRulesDelegate>
@property (strong,nonatomic)UITableView * RoomsTableView;
@property (strong,nonatomic)NSMutableArray * Data;

@property (strong,nonatomic)UIScrollView * SJScrollView;
@property (strong,nonatomic)RoomsView * scrollView;

@end

@implementation GuestRoomsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"发布客房";
    NSArray *marArr = @[@[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"房间信息"
                              },
                            @{@"icon":@"icn_msg_cnenter_service",
                              @"label":@"房间设施"},
                            @{@"icon":@"icn_msg_cnenter_notice",
                              @"label":@"房间照片"},
                            
                            ],
                        @[
                            @{@"icon":@"icn_msg_cnenter_system",
                              @"label":@"定价"
                              },
                            @{@"icon":@"icn_msg_cnenter_service",
                              @"label":@"预定规则"},
                            @{@"icon":@"icn_msg_cnenter_notice",
                              @"label":@"优惠促销（选填）"},
                            
                            ],
                        @[@{@"icon":@"icn_msg_cnenter_system",
                            @"label":@"商品标签"
                            },]
                        ];
    
    for (NSDictionary *dict in marArr) {
        [self.Data addObject:dict];
        
    }
    
    [self createUI];
    
}
#pragma mark - UI
-(void)createUI{
    
//    [self.view addSubview:self.RoomsTableView];
//    [self.RoomsTableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.right.left.mas_offset(0);
//    }];

    
    [self.view addSubview:self.SJScrollView];
    [self.SJScrollView addSubview:self.scrollView];
    
}
#pragma mark - UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.Data.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 3;
            break;
        case 1:
            return 3;
            break;
        case 2:
            return 1;
            break;
            
        default:
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
//    UIView *view = [[UIView alloc] init];
//    view.frame = CGRectMake(25,520.5,325,0.5);
//    view.backgroundColor = [UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1.0];
    if (indexPath.row == 1) {
       

    }else if (indexPath.row == 2){
        
        
    }else{
//        [cell.BaseView addSubview:view];
//        [view mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.mas_offset(10);
//            make.right.mas_offset(-10);
//            make.bottom.mas_offset(0);
//            make.height.mas_offset(1);
//        }];
        HotelOrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HotelOrderCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor clearColor];
        //    cell.Data = self.Data[indexPath.section][indexPath.row];
        //    cell.TableData = self.Data[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;

        
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 1) {
       return 340;
        
    }else if (indexPath.row == 2){
        return 219;
    } else
    {
        return 429;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return  45;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *header_View = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, 45)];
    
    NSArray *headerArr = @[@"房间信息",@"预定设置",@"标签"];
    header_View.backgroundColor = UIColorFromRGB(0xF6F6F6);
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(15,15,100,14.5);
    label.numberOfLines = 0;
    label.text = [NSString stringWithFormat:@"%@",headerArr[section]];
    [header_View addSubview:label];
    
    return header_View;
    
}

#pragma mark -  选择
-(void)Fill:(UIButton *)sender{
     RoomsController *VC = [RoomsController new];
    if (sender.tag == 10) {
        /*房间信息*/
        VC.NavSting = @"房间信息";
        
    }else if (sender.tag == 11){
        /*房间设施*/
        VC.NavSting = @"房间设施";


    }else if (sender.tag == 12){
        /*房间照片*/
        VC.NavSting = @"房间照片";

        
    }else if (sender.tag == 20){
        /*房间定价*/
        VC.NavSting = @"房间定价";
        
        
    }else if (sender.tag == 21){
        /*房间预定规则*/
        VC.NavSting = @"房间预定规则";
        
        
    }else{
        /*设置房间优惠促销*/
        VC.NavSting = @"设置房间优惠促销";
        
    }
    
    [self.navigationController pushViewController:VC animated:YES];

}
#pragma mark - 懒加载
-(UITableView *)RoomsTableView{
    if (!_RoomsTableView) {
        _RoomsTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenW, ScreenH) style:UITableViewStyleGrouped];
        _RoomsTableView.delegate = self;
        _RoomsTableView.dataSource = self;
        _RoomsTableView.backgroundColor = UIColorFromRGB(0xF6F6F6);
        
        [_RoomsTableView registerClass:[HotelOrderCell class] forCellReuseIdentifier:@"HotelOrderCell"];
        [_RoomsTableView registerClass:[TheHotelCell class] forCellReuseIdentifier:@"TheHotelCell"];

        _RoomsTableView.separatorStyle = UITableViewCellSelectionStyleNone;
        
    }
    return _RoomsTableView;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}

-(UIScrollView *)SJScrollView{
    if (!_SJScrollView) {
        _SJScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-44)];
        _SJScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, 761);
        _SJScrollView.delegate = self;
    }
    return _SJScrollView;
}
-(RoomsView *)scrollView{
    if (!_scrollView) {
        _scrollView = [[RoomsView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 761)];
        _scrollView.backgroundColor = MainbackgroundColor;
        _scrollView.delagate = self;
        
    }
    return _scrollView;
}
@end
