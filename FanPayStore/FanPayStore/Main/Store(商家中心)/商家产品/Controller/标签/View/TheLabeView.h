//
//  TheLabeView.h
//  FanBeiHua
//
//  Created by mocoo_ios on 2019/5/14.
//  Copyright © 2019年 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol LabelpullDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)pulllabelcell:(NSInteger)integer;

@end

@interface TheLabeView : UIView
/* 下拉按钮 */
@property (strong,nonatomic)UIButton * pull_down;

@property (strong,nonatomic)NSMutableArray * tagArray;
@property(nonatomic,weak)id<LabelpullDelegate>delagate;

@end
