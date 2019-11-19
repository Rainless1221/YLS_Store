//
//  RefundView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/29.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RefundDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)LookOrder;
-(void)LookDetaButton:(NSInteger)order;


@end
NS_ASSUME_NONNULL_BEGIN

@interface RefundView : UIView<UIScrollViewDelegate>
@property (strong,nonatomic)UIScrollView * RScrollView;
@property (strong,nonatomic)UIPageControl * pageControl ;
@property (strong,nonatomic)UIView * Refun_View;
@property (strong,nonatomic)UILabel * lable_text1;
@property (strong,nonatomic)UILabel * lable_text2;
@property (strong,nonatomic)UILabel * lable_text3;
@property (strong,nonatomic)UILabel * lable_text4;
/*代理*/
@property(nonatomic,weak)id<RefundDelegate>delagate;
@property (strong,nonatomic)NSMutableArray * Data;
@end

NS_ASSUME_NONNULL_END
