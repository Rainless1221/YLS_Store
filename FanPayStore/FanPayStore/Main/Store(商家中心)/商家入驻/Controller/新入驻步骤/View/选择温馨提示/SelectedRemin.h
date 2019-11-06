//
//  SelectedRemin.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/10/25.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol SelectedReminDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)SelectedReminAction:(UIView *)ReminV and:(UIButton* )icon;

@end

typedef enum{
    ReminVieWStatus_1,//
    ReminVieWStatus_2,//
}ReminVieWStatus;

@interface SelectedRemin : UIView
@property (strong,nonatomic)UIButton * ReminIcon;//logo
@property (strong,nonatomic)UILabel * ReminLable;//文本
@property (nonatomic,assign)ReminVieWStatus status;
@property(nonatomic,weak)id<SelectedReminDelegate>delagate;
@property (strong,nonatomic)NSDictionary * Data;//赋值
@end

NS_ASSUME_NONNULL_END
