//
//  CashTDView.m
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import "CashTDView.h"
#import "CashTDViewCell.h"
@implementation CashTDView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
    
}
#pragma mark 初始化frame地方
- (void)drawRect:(CGRect)rect{
    /** 视图点击 */
    UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tapGesturRecognizer];
    
    self.TDTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.BaseView.width, self.BaseView.height-51) style:UITableViewStylePlain];
    [self.TDTableView registerNib:[UINib nibWithNibName:@"CashTDViewCell" bundle:nil] forCellReuseIdentifier:@"CashTDViewCell"];
    [self.TDTableView registerNib:[UINib nibWithNibName:@"CashTDViewCell" bundle:nil] forCellReuseIdentifier:@"CashTDViewCell"];
    self.TDTableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.TDTableView.estimatedSectionHeaderHeight = 0;
    self.TDTableView.estimatedSectionFooterHeight = 0;
    self.TDTableView.delegate =  self;
    self.TDTableView.dataSource = self;
    self.TDTableView.backgroundColor = [UIColor whiteColor];
    self.TDTableView.tableFooterView = [[UIView alloc] init];
    [self.BaseView addSubview:self.TDTableView];
    
    self.TDTableView.defaultNoDataText = @"";
    self.TDTableView.defaultNoDataImage = [UIImage imageNamed:@"no_order_tip"];
    self.TDTableView.backgroundView = [UIView new];
    self.TDTableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
        
        //        [self merchant_center:1];
    };
    
    
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    CGPoint touchPoint = [tap locationInView:self.BaseView];
    
    CGRect userHeaderImageRect = [self convertRect:self.BaseView.bounds fromView:self.BaseView];
    
    if (CGRectContainsPoint(userHeaderImageRect, touchPoint)) {
        
        return;
    }
    [self removeFromSuperview];
}
#pragma mark - TableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section==0) {
        return self.Data.count;
    }
    if (self.Data.count == 0) {
        return 1;
    }else{
        return 0;

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CashTDViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CashTDViewCell" forIndexPath:indexPath];
    cell.backgroundColor = UIColorFromRGB(0xFFFFFF);
    if (indexPath.section == 1) {
        cell.iconImage.image = [UIImage imageNamed:@"ico_add_bankcard"];
        cell.TextLabl.text = @"添加银行卡";
        [cell.SeleButton setImage:[UIImage imageNamed:@"ico_arrow_right_blue"] forState:UIControlStateNormal];
        [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
            /** 去添加银行卡 **/
            if (self.AllbankBlock) {
                self.AllbankBlock();
            }
            [self removeFromSuperview];
        }];
    }else{
        
        cell.SeleButton.tag = indexPath.row;
        cell.Data = self.Data[indexPath.row];
        if (cell.SeleButton.tag == self.btnTag) {
            cell.isSelect = YES;
            cell.SeleButton.selected =YES;
        }else{
            cell.isSelect = NO;
            cell.SeleButton.selected = NO;
        }
        __weak CashTDViewCell *weakCell = cell;
        [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
            if (choice) {
                weakCell.SeleButton.selected =YES;
                self.btnTag = btnTag;
                NSLog(@"$$$$$$%ld",(long)btnTag);
                if (self.selebankBlock) {
                    self.selebankBlock(btnTag);
                }
                [self removeFromSuperview];
                
                [tableView reloadData];
            }
            else{
                //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
                weakCell.SeleButton.selected =NO;
                self.btnTag = btnTag;
                if (self.selebankBlock) {
                    self.selebankBlock(btnTag);
                }
                [self removeFromSuperview];
                
                [tableView reloadData];
            }
        }];
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
//取消按钮
- (IBAction)QXAction:(id)sender {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
