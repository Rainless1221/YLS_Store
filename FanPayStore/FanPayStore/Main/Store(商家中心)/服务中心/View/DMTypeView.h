//
//  DMTypeView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/3/11.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DMTypeView : UIView <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic)   IBOutlet UIView *BaseView;
@property (weak, nonatomic)   IBOutlet UIView *line;
@property (strong,nonatomic)  UITableView * TableView;
@property (nonatomic, assign) NSInteger btnTag;//默认选中的Tag
@property (strong,nonatomic)  NSMutableArray * categoryData;
@property (assign,nonatomic)NSInteger iscate;
@property (strong,nonatomic)NSString * category_id;
/** 经营类型事件 **/
@property (nonatomic, copy) void(^fbhtypeBlock)(NSString *type,NSString *sex_type,NSString *name,NSString *imag);

@end
