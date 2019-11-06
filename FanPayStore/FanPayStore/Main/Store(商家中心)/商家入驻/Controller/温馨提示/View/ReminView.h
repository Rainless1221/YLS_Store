//
//  ReminView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/22.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ReminDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Remin:(UIView *)ReminV and:(UIButton* )icon;

@end

@interface ReminView : UIView
@property(nonatomic,weak)id<ReminDelegate>delagate;

@property (strong,nonatomic)UIButton * icon;
@property (strong,nonatomic)UILabel * reminlable;
@property (strong,nonatomic)NSArray * Data;

@end
