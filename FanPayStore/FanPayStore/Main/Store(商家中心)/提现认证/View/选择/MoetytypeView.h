//
//  MoetytypeView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/3.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MoenytypeCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface MoetytypeView : UIView<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UIView * Baseview;
@property (strong,nonatomic)UIButton * XButton;
@property (strong,nonatomic)UILabel * Navlabel;
@property (strong,nonatomic)UIButton * Button;
@property (strong,nonatomic)UITableView * typeTable;
@property (strong,nonatomic)NSMutableArray * Data;
@property (nonatomic,assign)NSInteger btnTag;//默认选中的Tag
@property (assign,nonatomic)NSInteger iscate;

@property (assign,nonatomic)CGFloat view_H;
@property (assign,nonatomic)BOOL isAdds;




@property (strong,nonatomic)NSString  * category_name;
@property (nonatomic, copy) void(^fbhtypeBlock)(NSString *type,NSString *sex_type,NSString *name,NSString *imag);


@end

NS_ASSUME_NONNULL_END
