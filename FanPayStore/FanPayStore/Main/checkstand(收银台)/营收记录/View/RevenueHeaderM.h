//
//  RevenueHeaderM.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/4/24.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RevenueHeaderDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
//@required
-(void)RevenueButton:(NSInteger )Btntag;
-(void)DateAction;
@end

@interface RevenueHeaderM : UIView
/*时间选择*/
@property (strong,nonatomic)FL_Button * TimeButton;
@property (strong,nonatomic)UIView * line;
@property(nonatomic,weak)id<RevenueHeaderDelegate>delagate;

@end
