//
//  DetailsPLView.h
//  FanPayStore
//
//  Created by mocoo_ios on 2019/7/26.
//  Copyright © 2019 mocoo_ios. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetaiOrderDelegate<NSObject>
//方法可实现的
@optional
//方法必须实现
-(void)Huifu_order;


@end
NS_ASSUME_NONNULL_BEGIN

@interface DetailsPLView : UIView <StarEvaluatorDelegate>

@property (strong,nonatomic)YYLabel * evaluate_content;//
@property (strong,nonatomic)NSDictionary * Data;
@property (strong,nonatomic)StarEvaluator *starEvaluator;
@property (strong,nonatomic)UILabel *star ;
/*代理*/
@property(nonatomic,weak)id<DetaiOrderDelegate>delagate;

@end

NS_ASSUME_NONNULL_END
