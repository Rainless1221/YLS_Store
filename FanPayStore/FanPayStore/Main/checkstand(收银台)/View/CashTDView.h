//
//  CashTDView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/2/27.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CashTDView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *BaseView;
//@property (weak, nonatomic) IBOutlet UITableView *TDTableView;
@property (nonatomic, strong) UITableView * TDTableView;
@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag
/** 银行卡数据 */
@property (strong,nonatomic)NSArray * Data;
/** 去添加银行卡 **/
@property (nonatomic, copy) void(^AllbankBlock)(void);
/** 选中的银行卡 **/
@property (nonatomic, copy) void(^selebankBlock)(NSInteger row);

@end
