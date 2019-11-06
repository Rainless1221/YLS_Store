//
//  zyyy_DateListView.h
//  日历
//
//  Created by yurong on 2017/7/26.
//  Copyright © 2017年 1. All rights reserved.
//

#import <UIKit/UIKit.h>
@class zyyy_DateListView;

@protocol zyyyDelegate <NSObject>

-(void)moveImageBtnClick:(zyyy_DateListView *)Zview andData:(NSDictionary *)Dict;

@end
@interface zyyy_DateListView : UIView
@property(nonatomic,strong)UIScrollView *dateScroView;

@property(nonatomic,assign)id<zyyyDelegate>delegate;

@end
