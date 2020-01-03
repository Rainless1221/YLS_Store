//
//  AttriCell.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/12/30.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AttriLabView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol AttriDataDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)AttriData:(NSString *)attr_name and:(NSString *)attr_value and:(NSInteger)Row;

@end

@interface AttriCell : UITableViewCell<AttriLabDelegate,UITextFieldDelegate>
@property (strong,nonatomic)UILabel * SuXin;
@property (strong,nonatomic)UIButton * DeleteBtn;
@property (strong,nonatomic)UIView * BaseView;
@property (strong,nonatomic)UITextField * AttriField;
@property (strong,nonatomic)UIButton * AddAttriBtn;
@property (strong,nonatomic)UITextField * AttriField1;
@property (strong, nonatomic) AttriLabView    *tagList;
/*赋值*/
@property (strong,nonatomic)NSDictionary * Data;
@property(nonatomic,weak)id<AttriDataDelegate>delagate;
@property (nonatomic, copy) void(^AttriDataBlock)(NSString *attr_name,NSString *attr_value);//编辑事件
@property (nonatomic, copy) void(^DeleteAttriBlock)(void);//删除事件

/*高度*/
- (CGFloat)getCellHeight;
@end

NS_ASSUME_NONNULL_END
