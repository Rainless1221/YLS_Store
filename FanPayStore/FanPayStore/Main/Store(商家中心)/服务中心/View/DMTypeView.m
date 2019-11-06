//
//  DMTypeView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "DMTypeView.h"

@implementation DMTypeView
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    self.iscate = 1;
    /** 视图点击 */
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesturRecognizer];
    /** 请求类型 */
    [self merchant_center];
    [self createUI];
}
-(void)tapAction:(id)tap{
    [self removeFromSuperview];
}
/** 叉号事件 **/
- (IBAction)downAction:(UIButton *)sender {
    [self removeFromSuperview];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
}
#pragma mark - 请求
-(void)merchant_center{
    [MBProgressHUD MBProgress:@""];
    UserModel *model = [UserModel getUseData];
    
    [[FBHAppViewModel shareViewModel]get_store_category_info:model.merchant_id Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC=resDic[@"data"];
            [self.categoryData removeAllObjects];
            for (NSDictionary *dict in DIC[@"store_category_info"]) {
                [self.categoryData addObject:dict];
            }
//            self.categoryData = DIC[@"store_category_info"];
            [self.TableView reloadData];
        }else{
            [SVProgressHUD setMinimumDismissTimeInterval:2];
            [SVProgressHUD showErrorWithStatus:resDic[@"message"]];
        }
        [MBProgressHUD hideHUD];
    } andfailure:^{
        [MBProgressHUD hideHUD];
    }];
}
- (void)merchant_category:(NSString *)categoryId{
    if (self.iscate > 1) {
        return ;
    }
    [MBProgressHUD MBProgress:@""];
     UserModel *model = [UserModel getUseData];
    [[FBHAppViewModel shareViewModel] get_sec_store_category_info:model.merchant_id andcategory_id:categoryId Success:^(NSDictionary *resDic) {
        
        if ([resDic[@"status"] integerValue] == 1) {
            NSDictionary *DIC = resDic[@"data"];

            
            for (NSString *key in DIC) {
                 NSDictionary *dict =  DIC[key];
                if (dict.count == 0) {
                    [MBProgressHUD hideHUD];
                    return ;
                }
                [self.categoryData removeAllObjects];
                for (NSDictionary *Dic in dict) {
                    [self.categoryData addObject:Dic];
                }
                


            }
            self.iscate ++;
            self.btnTag = 0;
            [self.TableView reloadData];
            
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
    /** 类型列表 */
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 51, ScreenW-30, _BaseView.height - 110) style:UITableViewStylePlain];
    [tableView registerNib:[UINib nibWithNibName:@"RunTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"RunTypeTableViewCell"];
    //    self.tableView.style = UITableViewStyleGrouped;
    tableView.delegate =  self;
    tableView.dataSource = self;
    tableView.layer.cornerRadius = 5;
    tableView.backgroundColor = [UIColor whiteColor];
    // 允许在编辑模式进行多选操作
    tableView.allowsMultipleSelectionDuringEditing = YES;
    [_BaseView addSubview:tableView];
    self.TableView = tableView;
    /** 无数据 **/
    tableView.defaultNoDataText = @"";//提示语
    tableView.defaultNoDataImage = [UIImage imageNamed:@"no_product_tip"];//提示图片
    tableView.backgroundView = [UIView new];
    YBWeakSelf
    tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        /** 刷新列表 **/
        [weakSelf.TableView reloadData];
    };
}
#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.categoryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RunTypeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RunTypeTableViewCell" forIndexPath:indexPath];
    cell.selectBtn.tag = indexPath.row;
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    cell.Data = self.categoryData[indexPath.row];
    
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
            if (self.iscate== 1) {
               self.category_id = [NSString stringWithFormat:@"%@",self.categoryData[btnTag][@"category_id"]];
            }
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.categoryData[btnTag][@"category_id"]];
            if ([cate isEqualToString:@""]) {
                return ;
            }
            [self merchant_category:cate];
        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            weakCell.selectBtn.selected = NO;
            self.btnTag = btnTag;
            [tableView reloadData];
            if (self.iscate== 1) {
                self.category_id = [NSString stringWithFormat:@"%@",self.categoryData[btnTag][@"category_id"]];
            }
            /** 二级类型 */
            NSString *cate = [NSString stringWithFormat:@"%@",self.categoryData[btnTag][@"category_id"]];
            if ([cate isEqualToString:@""]) {
                return ;
            }
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

/**
 * 确定选择的类型
 **/
- (IBAction)QDAction:(id)sender {

    if (self.iscate== 1) {
        self.category_id = [NSString stringWithFormat:@"%@",self.categoryData[self.btnTag][@"category_id"]];
        if (self.fbhtypeBlock) {
            self.fbhtypeBlock(self.category_id,nil,self.categoryData[self.btnTag][@"category_name"],self.categoryData[self.btnTag][@"category_pic"]);
        }
    }else{
        if (self.fbhtypeBlock) {
            self.fbhtypeBlock(self.category_id,self.categoryData[self.btnTag][@"category_id"],self.categoryData[self.btnTag][@"category_name"],self.categoryData[self.btnTag][@"category_pic"]);
        }
    }
    
    [self removeFromSuperview];
}


-(NSMutableArray *)categoryData{
    if (!_categoryData) {
        _categoryData = [NSMutableArray array];
    }
    return _categoryData;
}
@end
