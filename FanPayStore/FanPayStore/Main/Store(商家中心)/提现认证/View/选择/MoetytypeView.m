//
//  MoetytypeView.m
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import "MoetytypeView.h"

@implementation MoetytypeView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.75];
        self.view_H = 400;

        [self createUI];
    }
    return self;
}

#pragma mark - UI
-(void)createUI{
        UITapGestureRecognizer *tapGesturRecognizer=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tapGesturRecognizer];
    self.Baseview = [[UIView alloc] init];
    self.Baseview.frame = CGRectMake(0,367,375,400);
    self.Baseview.backgroundColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0];
    self.Baseview.layer.cornerRadius = 5;
    [self addSubview:self.Baseview];
    [self.Baseview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_offset(0);
        make.height.mas_offset(self.view_H);
    }];
    
    [self.Baseview addSubview:self.XButton];
    [self.Baseview addSubview:self.Button];
    [self.Button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_offset(15);
        make.right.mas_offset(-15);
        make.bottom.mas_offset(-16);
        make.height.mas_offset(44);
    }];
    
    [self.Baseview addSubview:self.Navlabel];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(10, 50,self.Baseview.width-20 , 1)];
    line.backgroundColor = UIColorFromRGB(0xEAEAEA);
    [self.Baseview addSubview:line];
    
    
}

#pragma mark - TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.Data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MoenytypeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MoenytypeCell" forIndexPath:indexPath];
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
    __weak MoenytypeCell *weakCell = cell;
    [cell setQhxSelectBlock:^(BOOL choice,NSInteger btnTag){
        if (choice) {
            weakCell.selectBtn.selected = YES;
            self.btnTag = btnTag;
            NSLog(@"$$$$$$%ld",(long)btnTag);
            [tableView reloadData];
            if (self.iscate== 1) {
                self.category_name = [NSString stringWithFormat:@"%@",self.Data[btnTag][@"category_name"]];
            }

        }
        else{
            //选中一个之后，再次点击，是未选中状态，图片仍然设置为选中的图片，记录下tag，刷新tableView，这个else 也可以注释不用，tag只记录选中的就可以
            weakCell.selectBtn.selected = NO;
            self.btnTag = btnTag;
            [tableView reloadData];
            if (self.iscate== 1) {
                self.category_name = [NSString stringWithFormat:@"%@",self.Data[btnTag][@"category_name"]];
            }
            /** 二级类型 */

            
        }
    }];
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
//点击
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //当手指离开某行时，就让某行的选中状态消失
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}





#pragma mark   - 方法
-(void)setIsAdds:(BOOL)isAdds{
    if (isAdds == YES) {
        
        self.typeTable.hidden=YES;

    }else{
        
        /** 类型列表 */
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(15, 51, ScreenW-30, self.Baseview.height - 110) style:UITableViewStyleGrouped];
//        [tableView registerNib:[UINib nibWithNibName:@"RunTypeTableViewCell" bundle:nil] forCellReuseIdentifier:@"RunTypeTableViewCell"];
        [tableView registerClass:[MoenytypeCell class] forCellReuseIdentifier:@"MoenytypeCell"];
        //    self.tableView.style = UITableViewStyleGrouped;
        tableView.delegate =  self;
        tableView.dataSource = self;
        tableView.layer.cornerRadius = 5;
        tableView.backgroundColor = [UIColor whiteColor];
        // 允许在编辑模式进行多选操作
        tableView.allowsMultipleSelectionDuringEditing = YES;
        [self.Baseview addSubview:tableView];
        self.typeTable = tableView;
        /** 无数据 **/
        tableView.defaultNoDataText = @"";//提示语
        tableView.defaultNoDataImage = [UIImage imageNamed:@""];//提示图片
        tableView.backgroundView = [UIView new];
        YBWeakSelf
        tableView.defaultNoDataViewDidClickBlock = ^(UIView *view) {
            /** 刷新列表 **/
            [weakSelf.typeTable reloadData];
        };
        
    }
    
}



-(void)XAction{
    [self removeFromSuperview];

}

-(void)ButtonAction{
    if (self.iscate== 1) {
        self.category_name = [NSString stringWithFormat:@"%@",self.Data[self.btnTag][@"category_name"]];
        if (self.fbhtypeBlock) {
            self.fbhtypeBlock(self.category_name,@"",self.Data[self.btnTag][@"category_name"],self.Data[self.btnTag][@"category_name"]);
        }
    }else{
        if (self.fbhtypeBlock) {
            self.fbhtypeBlock(self.category_name,self.Data[self.btnTag][@"category_name"],self.Data[self.btnTag][@"category_name"],self.Data[self.btnTag][@"category_name"]);
        }
    }
    
        
    
    [self removeFromSuperview];
    
}
-(void)tapAction:(UITapGestureRecognizer *)tap{
    
    [self removeFromSuperview];
    
}
#pragma mark - 懒加载

-(UIButton *)XButton{
    if (!_XButton) {
        _XButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _XButton.frame = CGRectMake(0, 0, 50, 50);
        [_XButton setImage:[UIImage imageNamed:@"suspension_layer_btn_close_normal"] forState:UIControlStateNormal];
        [_XButton addTarget:self action:@selector(XAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _XButton;
}
-(UIButton *)Button{
    if (!_Button) {
        _Button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_Button setTitle:@"确认" forState:UIControlStateNormal];
        [_Button.titleLabel setFont:[UIFont systemFontOfSize:18]];
        _Button.backgroundColor = [UIColor colorWithRed:61/255.0 green:138/255.0 blue:255/255.0 alpha:1.0];
        _Button.layer.cornerRadius = 10;
        [_Button addTarget:self action:@selector(ButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Button;
}
-(UILabel *)Navlabel{
    if (!_Navlabel) {
        _Navlabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 0, ScreenW-100, 50)];
        _Navlabel.textAlignment = 1;
        _Navlabel.font = [UIFont systemFontOfSize:15];
    }
    return _Navlabel;
}
-(NSMutableArray *)Data{
    if (!_Data) {
        _Data = [NSMutableArray array];
    }
    return _Data;
}


@end
